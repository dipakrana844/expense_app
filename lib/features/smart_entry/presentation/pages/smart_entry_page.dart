import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';

import '../providers/smart_entry_controller.dart';
import '../widgets/form_fields.dart';
import '../widgets/mode_selector.dart';
import '../widgets/numeric_keypad.dart';
import '../widgets/smart_preview_card.dart';

class SmartEntryPage extends ConsumerStatefulWidget {
  final TransactionMode? initialMode;
  final Map<String, dynamic>? initialEditData;

  const SmartEntryPage({super.key, this.initialMode, this.initialEditData});

  @override
  ConsumerState<SmartEntryPage> createState() => _SmartEntryPageState();
}

class _SmartEntryPageState extends ConsumerState<SmartEntryPage> {
  bool _isMagicEntryVisible = false;
  final TextEditingController _magicTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(smartEntryControllerProvider.notifier);
      if (widget.initialEditData != null) {
        controller.loadForEdit(widget.initialEditData!);
      } else {
        controller.resetForCreate();
        if (widget.initialMode != null) {
          controller.switchMode(widget.initialMode!);
        }
      }
    });
  }

  @override
  void dispose() {
    _magicTextController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  // Pure UI helpers — no business logic
  // --------------------------------------------------------------------------

  Color _accentColor(TransactionMode mode) => switch (mode) {
    TransactionMode.income => const Color(0xFF2196F3),
    TransactionMode.expense => const Color(0xFFF44336),
    TransactionMode.transfer => const Color(0xFF757575),
  };

  String _formattedAmount(String amountString) {
    if (amountString.isEmpty) return '${AppConstants.currencySymbol}0';
    final amount = CurrencyUtils.parseAmount(amountString) ?? 0;
    return CurrencyUtils.formatAmount(amount);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(smartEntryControllerProvider);
    final controller = ref.read(smartEntryControllerProvider.notifier);
    final accentColor = _accentColor(state.mode);

    return Scaffold(
      appBar: _buildAppBar(context, state, controller, accentColor),
      body: SafeArea(
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.escape): () =>
                _handleBack(context, state),
            const SingleActivator(LogicalKeyboardKey.enter): () =>
                _handleSave(context, controller),
            const SingleActivator(LogicalKeyboardKey.keyS, control: true): () =>
                _handleSave(context, controller),
            const SingleActivator(LogicalKeyboardKey.keyC, control: true): () =>
                _handleContinue(context, controller),
          },
          child: Focus(
            autofocus: true,
            child: Column(
              children: [
                // Mode Selector
                ModeSelector(
                  currentMode: state.mode,
                  onModeChanged: (mode) => controller.switchMode(mode),
                ),
                // Magic Entry Field
                if (_isMagicEntryVisible) _buildMagicEntryField(context, controller, accentColor),
                // Amount Display
                _buildAmountDisplay(context, state, accentColor),
                // Smart Preview
                _buildSmartPreview(state),
                // Form Fields (IndexedStack for performance)
                Expanded(
                  child: SmartEntryFormFields(
                    state: state,
                    onCategoryChanged: controller.setCategory,
                    onSourceChanged: controller.setSource,
                    onAccountChanged: controller.setAccount,
                    onFromAccountChanged: controller.setFromAccount,
                    onToAccountChanged: controller.setToAccount,
                    onFeeChanged: controller.setTransferFee,
                    onNoteChanged: controller.setNote,
                    onDateChanged: controller.setDate,
                    onTimeChanged: controller.setTime,
                  ),
                ),
                // Numeric Keypad
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  NumericKeypad(
                    onKeyPressed: controller.updateAmount,
                    accentColor: accentColor,
                  ),
                // Action Buttons
                _buildActionButtons(context, state, controller, accentColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Preview helpers — read from providers, pure computation
  // --------------------------------------------------------------------------

  Widget _buildSmartPreview(SmartEntryState state) {
    // Inline preview computations (previously on controller — now pure UI)
    double? dailySpendPreview;
    double? incomeBalancePreview;
    String? transferPreview;

    // These are display-only reads; no business logic.
    if (state.mode == TransactionMode.expense && state.amount > 0) {
      // Preview showing remaining daily budget — resolved in SmartPreviewCard
      dailySpendPreview = null; // SmartPreviewCard reads provider itself
    }
    if (state.mode == TransactionMode.income && state.amount > 0) {
      incomeBalancePreview = state.amount;
    }
    if (state.mode == TransactionMode.transfer &&
        state.fromAccount != null &&
        state.toAccount != null &&
        state.amount > 0) {
      transferPreview = '${state.fromAccount!} → ${state.toAccount!}';
    }

    return SmartPreviewCard(
      mode: state.mode,
      dailySpendPreview: dailySpendPreview,
      incomeBalancePreview: incomeBalancePreview,
      transferPreview: transferPreview,
      isDuplicateWarning: state.isDuplicateWarning,
    );
  }

  Widget _buildMagicEntryField(
    BuildContext context,
    SmartEntryController controller,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _magicTextController,
        decoration: InputDecoration(
          hintText: 'Try "Pizza 20" or "Salary 1000"',
          prefixIcon: const Icon(Icons.auto_awesome, size: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: () => _startVoiceEntry(),
            tooltip: 'Voice entry (coming soon)',
          ),
          filled: true,
          fillColor: accentColor.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: (text) => controller.handleMagicInput(text),
        onSubmitted: (text) {
          controller.handleMagicInput(text);
          setState(() => _isMagicEntryVisible = false);
        },
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Widget builders
  // --------------------------------------------------------------------------

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    SmartEntryState state,
    SmartEntryController controller,
    Color accentColor,
  ) {
    return AppBar(
      title: Text(state.isEditing ? 'Edit Transaction' : 'Add Transaction'),
      leading: Semantics(
        label: 'Close and exit',
        hint: 'Discard changes and return to previous screen',
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _handleBack(context, state),
        ),
      ),
      actions: [
        // Magic Entry Toggle
        Semantics(
          label: 'Toggle magic entry',
          hint: 'Enter transaction using natural language',
          child: IconButton(
            icon: Icon(
              _isMagicEntryVisible ? Icons.auto_awesome : Icons.auto_awesome_outlined,
              color: _isMagicEntryVisible ? accentColor : null,
            ),
            onPressed: () {
              setState(() => _isMagicEntryVisible = !_isMagicEntryVisible);
              if (!_isMagicEntryVisible) _magicTextController.clear();
            },
            tooltip: 'Magic Entry',
          ),
        ),
        // OCR Scan
        Semantics(
          label: 'Scan receipt with OCR',
          hint: 'Extract transaction details from a receipt image',
          child: IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            onPressed: () => _openOcrScanner(),
            tooltip: 'OCR Scan',
          ),
        ),
        // Grocery Session
        Semantics(
          label: 'Start grocery session',
          hint: 'Track multiple grocery items in one session',
          child: IconButton(
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () => _openGrocerySession(),
            tooltip: 'Grocery Session',
          ),
        ),
        // Recurring Toggle
        Semantics(
          label: 'Toggle recurring transaction',
          hint: state.isRecurring ? 'Turn off recurring' : 'Turn on recurring',
          child: IconButton(
            icon: Icon(
              state.isRecurring ? Icons.repeat_on : Icons.repeat,
              color: state.isRecurring ? accentColor : null,
            ),
            onPressed: controller.toggleRecurring,
            tooltip: 'Recurring',
          ),
        ),
      ],
    );
  }

  Widget _buildAmountDisplay(
    BuildContext context,
    SmartEntryState state,
    Color accentColor,
  ) {
    final formatted = _formattedAmount(state.amountString);
    return Semantics(
      label: 'Current amount: $formatted',
      value: formatted,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          formatted,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    SmartEntryState state,
    SmartEntryController controller,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Continue Button
          Expanded(
            child: Semantics(
              label: 'Continue to next transaction',
              hint: 'Save current transaction and prepare for next entry',
              enabled: !state.isEditing && !state.isLoading && state.isValid,
              child: OutlinedButton.icon(
                onPressed: state.isEditing || state.isLoading || !state.isValid
                    ? null
                    : () => _handleContinue(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('Continue'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Save Button
          Expanded(
            flex: 2,
            child: Semantics(
              label: 'Save transaction',
              hint: 'Save the current transaction and exit',
              enabled: !state.isLoading && state.isValid,
              child: FilledButton.icon(
                onPressed: state.isLoading || !state.isValid
                    ? null
                    : () => _handleSave(context, controller),
                icon: state.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check),
                label: Text(state.isEditing ? 'Update' : 'Save'),
                style: FilledButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Event handlers
  // --------------------------------------------------------------------------

  Future<void> _handleSave(
    BuildContext context,
    SmartEntryController controller,
  ) async {
    final wasEditing = ref.read(smartEntryControllerProvider).isEditing;
    final success = await controller.save();
    if (!context.mounted) return;

    final errorMessage = ref.read(smartEntryControllerProvider).error;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasEditing
                ? 'Transaction updated successfully'
                : 'Transaction saved successfully',
          ),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage ?? 'Failed to save transaction')),
      );
    }
  }

  Future<void> _handleContinue(
    BuildContext context,
    SmartEntryController controller,
  ) async {
    if (ref.read(smartEntryControllerProvider).isEditing) {
      await _handleSave(context, controller);
      return;
    }
    final success = await controller.saveAndContinue();
    if (!context.mounted) return;

    final errorMessage = ref.read(smartEntryControllerProvider).error;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction saved, ready for next entry'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage ?? 'Failed to save transaction')),
      );
    }
  }

  void _handleBack(BuildContext context, SmartEntryState state) {
    if (state.amountString.isNotEmpty ||
        state.category != null ||
        state.source != null ||
        state.note?.isNotEmpty == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text(
            'You have unsaved changes. Are you sure you want to discard them?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Discard'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _openOcrScanner() {
    context.push('/ocr/scan').then((result) {
      if (!mounted) return;
      if (result != null && result is Map<String, dynamic>) {
        final controller = ref.read(smartEntryControllerProvider.notifier);
        if (result['amount'] != null) {
          controller.setAmount(result['amount'] as double);
        }
        if (result['category'] != null) {
          final category = result['category'] as String;
          controller.setCategory(category);
        }
        if (result['note'] != null) {
          controller.setNote(result['note'] as String);
        }
      }
    });
  }

  void _openGrocerySession() {
    context.push('/grocery/add').then((result) {
      if (!mounted) return;
      if (result != null && result is Map<String, dynamic>) {
        final controller = ref.read(smartEntryControllerProvider.notifier);
        if (result['amount'] != null) {
          controller.setAmount(result['amount'] as double);
        }
        if (result['category'] != null) {
          controller.setCategory(result['category'] as String);
        }
      }
    });
  }

  // void _openAddCategorySheet(String transactionType) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //     builder: (context) => AddCategorySheet(transactionType: transactionType),
  //   );
  // }

  void _startVoiceEntry() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice entry is coming soon! Keep an eye on updates.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
