import 'package:flutter/material.dart' hide DateUtils;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart' as app_utils;
import '../../../../core/services/smart_suggestion_service.dart';
import '../providers/smart_entry_controller.dart';

class SmartEntryFormFields extends StatelessWidget {
  final SmartEntryState state;
  final Function(String?) onCategoryChanged;
  final Function(String?) onSourceChanged;
  final Function(String?) onAccountChanged;
  final Function(String?) onFromAccountChanged;
  final Function(String?) onToAccountChanged;
  final Function(double?) onFeeChanged;
  final Function(String?) onNoteChanged;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;
  final Function(bool)? onAttachReceiptChanged;

  const SmartEntryFormFields({
    super.key,
    required this.state,
    required this.onCategoryChanged,
    required this.onSourceChanged,
    required this.onAccountChanged,
    required this.onFromAccountChanged,
    required this.onToAccountChanged,
    required this.onFeeChanged,
    required this.onNoteChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    this.onAttachReceiptChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: state.mode.index,
      children: [
        _buildIncomeFields(context),
        _buildExpenseFields(context),
        _buildTransferFields(context),
      ],
    );
  }

  Widget _buildExpenseFields(BuildContext context) {
    final suggestionService = SmartSuggestionServiceHolder.service;
    final categories = suggestionService?.getFrequentExpenseCategories() ?? AppConstants.expenseCategories;
    final accounts = suggestionService?.getAllAccounts() ?? ['Cash', 'Bank', 'UPI', 'Wallet'];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTimeRow(context),
          const SizedBox(height: 16),
          _buildCategoryDropdown(context, categories, state.category, onCategoryChanged),
          const SizedBox(height: 16),
          _buildAccountDropdown(context, accounts, state.account, 'Account (Optional)', onAccountChanged),
          const SizedBox(height: 16),
          _buildNoteField(context, state.note, onNoteChanged),
          const SizedBox(height: 16),
          _buildReceiptAttachment(context),
        ],
      ),
    );
  }

  Widget _buildReceiptAttachment(BuildContext context) {
    return InkWell(
      onTap: () {
        // Toggle receipt attachment
        if (onAttachReceiptChanged != null) {
          onAttachReceiptChanged!(true);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt attachment feature coming soon')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              'Attach Receipt (Optional)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeFields(BuildContext context) {
    final suggestionService = SmartSuggestionServiceHolder.service;
    final sources = suggestionService?.getFrequentIncomeSources() ?? ['Salary', 'Freelance', 'Investment', 'Gift', 'Others'];
    final accounts = suggestionService?.getAllAccounts() ?? ['Cash', 'Bank', 'UPI', 'Wallet'];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTimeRow(context),
          const SizedBox(height: 16),
          _buildSourceDropdown(context, sources, state.source, onSourceChanged),
          const SizedBox(height: 16),
          _buildAccountDropdown(context, accounts, state.account, 'Account (Optional)', onAccountChanged),
          const SizedBox(height: 16),
          _buildNoteField(context, state.note, onNoteChanged),
        ],
      ),
    );
  }

  Widget _buildTransferFields(BuildContext context) {
    final suggestionService = SmartSuggestionServiceHolder.service;
    final accounts = suggestionService?.getAllAccounts() ?? ['Cash', 'Bank', 'UPI', 'Wallet'];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTimeRow(context),
          const SizedBox(height: 16),
          _buildAccountDropdown(context, accounts, state.fromAccount, 'From Account', onFromAccountChanged),
          const SizedBox(height: 16),
          _buildAccountDropdown(context, accounts, state.toAccount, 'To Account', onToAccountChanged),
          const SizedBox(height: 16),
          _buildFeeField(context, state.transferFee, onFeeChanged),
          const SizedBox(height: 16),
          _buildNoteField(context, state.note, onNoteChanged),
        ],
      ),
    );
  }

  Widget _buildDateTimeRow(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      onLongPress: () => _copyPreviousDate(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 12),
            Text(
              app_utils.DateUtils.formatDate(state.date),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                state.time.format(context),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            if (state.isRecurring)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.repeat, size: 14, color: Colors.amber.shade800),
                    const SizedBox(width: 4),
                    Text('Recurring', style: TextStyle(fontSize: 12, color: Colors.amber.shade800)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(BuildContext context, List<String> categories, String? value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.category_outlined),
      ),
      items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSourceDropdown(BuildContext context, List<String> sources, String? value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Source',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      items: sources.map((src) => DropdownMenuItem(value: src, child: Text(src))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildAccountDropdown(BuildContext context, List<String> accounts, String? value, String label, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
      ),
      items: accounts.map((acc) => DropdownMenuItem(value: acc, child: Text(acc))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildFeeField(BuildContext context, double? fee, Function(double?) onChanged) {
    return TextFormField(
      initialValue: fee?.toString() ?? '',
      decoration: const InputDecoration(
        labelText: 'Transfer Fee (Optional)',
        border: OutlineInputBorder(),
        prefixText: AppConstants.currencySymbol,
        prefixIcon: Icon(Icons.receipt_outlined),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (val) => onChanged(double.tryParse(val)),
    );
  }

  Widget _buildNoteField(BuildContext context, String? note, Function(String?) onChanged) {
    return TextFormField(
      initialValue: note ?? '',
      decoration: const InputDecoration(
        labelText: 'Note (Optional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.note_outlined),
      ),
      maxLines: 2,
      onChanged: onChanged,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    // First select date
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: state.date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    
    if (pickedDate != null) {
      onDateChanged(pickedDate);
      
      // Then select time
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: state.time,
      );
      
      if (pickedTime != null) {
        onTimeChanged(pickedTime);
      }
    }
  }

  void _copyPreviousDate(BuildContext context) {
    // Copy previous date functionality - shows a snackbar for now
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Long press to copy previous transaction date')),
    );
  }
}

class SmartSuggestionServiceHolder {
  static SmartSuggestionService? service;
}