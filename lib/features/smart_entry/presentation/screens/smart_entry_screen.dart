import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/smart_entry_controller.dart';
import '../widgets/numeric_keypad.dart';
import '../widgets/mode_selector.dart';
import '../widgets/smart_preview_card.dart';
import '../widgets/form_fields.dart';

class SmartEntryScreen extends ConsumerStatefulWidget {
  final TransactionMode? initialMode;

  const SmartEntryScreen({super.key, this.initialMode});

  @override
  ConsumerState<SmartEntryScreen> createState() => _SmartEntryScreenState();
}

class _SmartEntryScreenState extends ConsumerState<SmartEntryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialMode != null) {
        ref.read(smartEntryControllerProvider.notifier).switchMode(widget.initialMode!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(smartEntryControllerProvider);
    final controller = ref.read(smartEntryControllerProvider.notifier);
    final accentColor = controller.getAccentColor(context);

    return Scaffold(
      appBar: _buildAppBar(context, state, controller, accentColor),
      body: SafeArea(
        child: Column(
          children: [
            // Mode Selector
            ModeSelector(
              currentMode: state.mode,
              onModeChanged: (mode) => controller.switchMode(mode),
            ),
            // Amount Display
            _buildAmountDisplay(context, state, controller),
            // Smart Preview
            SmartPreviewCard(
              mode: state.mode,
              dailySpendPreview: controller.getDailySpendPreview(),
              incomeBalancePreview: controller.getIncomeBalancePreview(),
              transferPreview: controller.getTransferPreview(),
            ),
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
            NumericKeypad(
              onKeyPressed: controller.updateAmount,
              accentColor: accentColor,
            ),
            // Action Buttons
            _buildActionButtons(context, state, controller, accentColor),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, SmartEntryState state, SmartEntryController controller, Color accentColor) {
    return AppBar(
      title: const Text('Add Transaction'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _handleBack(context, state),
      ),
      actions: [
        // OCR Scan
        IconButton(
          icon: const Icon(Icons.document_scanner_outlined),
          onPressed: () => _openOcrScanner(),
          tooltip: 'OCR Scan',
        ),
        // Grocery Session
        IconButton(
          icon: const Icon(Icons.shopping_basket_outlined),
          onPressed: () => _openGrocerySession(),
          tooltip: 'Grocery Session',
        ),
        // Recurring Toggle
        IconButton(
          icon: Icon(
            state.isRecurring ? Icons.repeat_on : Icons.repeat,
            color: state.isRecurring ? accentColor : null,
          ),
          onPressed: controller.toggleRecurring,
          tooltip: 'Recurring',
        ),
      ],
    );
  }

  Widget _buildAmountDisplay(BuildContext context, SmartEntryState state, SmartEntryController controller) {
    final accentColor = controller.getAccentColor(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        controller.getFormattedAmount(),
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, SmartEntryState state, SmartEntryController controller, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Continue Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: state.isLoading || !state.isValid ? null : () => _handleContinue(context, controller),
              icon: const Icon(Icons.add),
              label: const Text('Continue'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Save Button
          Expanded(
            flex: 2,
            child: FilledButton.icon(
              onPressed: state.isLoading || !state.isValid ? null : () => _handleSave(context, controller),
              icon: state.isLoading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.check),
              label: const Text('Save'),
              style: FilledButton.styleFrom(
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave(BuildContext context, SmartEntryController controller) async {
    String? errorMessage;
    final success = await controller.save().then((success) {
      errorMessage = controller.state.error;
      return success;
    });
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction saved successfully')),
      );
      Navigator.of(context).pop();
    } else if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage ?? 'Failed to save transaction')),
      );
    }
  }

  Future<void> _handleContinue(BuildContext context, SmartEntryController controller) async {
    String? errorMessage;
    final success = await controller.saveAndContinue().then((success) {
      errorMessage = controller.state.error;
      return success;
    });
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction saved, ready for next entry')),
      );
    } else if (!success && mounted) {
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
          content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
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
      // Handle OCR scan result - could populate form fields
      if (result != null && result is Map<String, dynamic>) {
        final controller = ref.read(smartEntryControllerProvider.notifier);
        if (result['amount'] != null) {
          controller.setAmount(result['amount'] as double);
        }
        if (result['category'] != null) {
          controller.setCategory(result['category'] as String);
        }
        if (result['note'] != null) {
          controller.setNote(result['note'] as String);
        }
      }
    });
  }

  void _openGrocerySession() {
    context.push('/grocery/add').then((result) {
      // Handle grocery session result
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
}