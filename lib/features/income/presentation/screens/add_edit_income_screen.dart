import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';

/// Screen: AddEditIncomeScreen
///
/// Purpose: Screen for adding new income or editing existing income
/// - Provides form for income details (amount, source, date, note)
/// - Handles validation and submission
/// - Supports both create and update operations
class AddEditIncomeScreen extends ConsumerWidget {
  final IncomeEntity? income; // null for add, populated for edit

  const AddEditIncomeScreen({super.key, this.income});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(incomeFormProvider(income));
    final formNotifier = ref.read(incomeFormProvider(income).notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(income == null ? 'Add Income' : 'Edit Income'),
        actions: [
          if (!formState.isLoading)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: formState.isLoading ? null : formNotifier.submit,
              tooltip: 'Save Income',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              income == null
                  ? 'Record your income to track your financial health'
                  : 'Update your income details',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            // Amount Field
            _buildAmountField(context, formState, formNotifier),

            const SizedBox(height: 16),

            // Source Dropdown
            _buildSourceDropdown(context, formState, formNotifier),

            const SizedBox(height: 16),

            // Date Picker
            _buildDatePicker(context, formState, formNotifier),

            const SizedBox(height: 16),

            // Note Field
            _buildNoteField(context, formState, formNotifier),

            const SizedBox(height: 24),

            // Submit Button
            _buildSubmitButton(context, formState, formNotifier),

            // Error Message
            if (formState.error != null) ...[
              const SizedBox(height: 16),
              _buildErrorMessage(context, formState.error!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(
    BuildContext context,
    IncomeFormState state,
    IncomeFormNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount *',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: state.amount),
          onChanged: notifier.setAmount,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixText: '\$ ',
            hintText: '0.00',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            errorText: state.amount.isNotEmpty &&
                    double.tryParse(state.amount) == null
                ? 'Please enter a valid amount'
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSourceDropdown(
    BuildContext context,
    IncomeFormState state,
    IncomeFormNotifier notifier,
  ) {
    final theme = Theme.of(context);
    final predefinedSources = [
      'Salary',
      'Freelance',
      'Business',
      'Rental',
      'Gift',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Source *',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          key: ValueKey(state.source), // Force rebuild when source changes
          value: state.source.trim().isEmpty ? null : state.source,
          onChanged: (String? newValue) {
            if (newValue != null) {
              notifier.setSource(newValue);
            }
          },
          items: predefinedSources
              .map((source) => DropdownMenuItem(
                    value: source,
                    child: Text(source),
                  ))
              .toList(),
          decoration: InputDecoration(
            hintText: 'Select income source',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            errorText: state.source.trim().isEmpty ? 'Please select an income source' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    IncomeFormState state,
    IncomeFormNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context, notifier, state.date),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.date.toString().split(' ')[0],
                  style: theme.textTheme.bodyLarge,
                ),
                Icon(
                  Icons.calendar_today,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteField(
    BuildContext context,
    IncomeFormState state,
    IncomeFormNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note (Optional)',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: state.note),
          onChanged: notifier.setNote,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any details about this income...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    IncomeFormState state,
    IncomeFormNotifier notifier,
  ) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: state.isLoading ? null : notifier.submit,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state.isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Saving...'),
                ],
              )
            : Text(
                income == null ? 'Add Income' : 'Update Income',
                style: const TextStyle(fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, String error) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.error),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    IncomeFormNotifier notifier,
    DateTime currentDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != currentDate) {
      notifier.setDate(picked);
    }
  }
}