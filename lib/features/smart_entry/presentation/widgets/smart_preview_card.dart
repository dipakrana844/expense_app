import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../providers/smart_entry_controller.dart';

class SmartPreviewCard extends StatelessWidget {
  final TransactionMode mode;
  final double? dailySpendPreview;
  final double? incomeBalancePreview;
  final String? transferPreview;

  const SmartPreviewCard({
    super.key,
    required this.mode,
    this.dailySpendPreview,
    this.incomeBalancePreview,
    this.transferPreview,
  });

  @override
  Widget build(BuildContext context) {
    if (mode == TransactionMode.expense && dailySpendPreview != null) {
      return _buildDailySpendPreview(context);
    }
    if (mode == TransactionMode.transfer && transferPreview != null) {
      return _buildTransferPreview(context);
    }
    if (mode == TransactionMode.income && incomeBalancePreview != null) {
      return _buildIncomePreview(context);
    }
    if (mode == TransactionMode.income) {
      return _buildIncomePreview(context);
    }
    return const SizedBox.shrink();
  }

  Widget _buildDailySpendPreview(BuildContext context) {
    final isNegative = dailySpendPreview! < 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNegative 
            ? Colors.red.shade50 
            : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isNegative 
              ? Colors.red.shade200 
              : Colors.green.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isNegative ? Icons.warning_amber_rounded : Icons.check_circle_outline,
            color: isNegative ? Colors.red : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isNegative 
                  ? 'Over budget by ${CurrencyUtils.formatAmount(dailySpendPreview!.abs())}'
                  : 'After expense: ${CurrencyUtils.formatAmount(dailySpendPreview!)} remaining',
              style: TextStyle(
                color: isNegative ? Colors.red.shade700 : Colors.green.shade700,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferPreview(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.swap_horiz, color: Color(0xFF757575), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              transferPreview!,
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomePreview(BuildContext context) {
    final amount = incomeBalancePreview;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Color(0xFF2196F3), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              amount != null 
                  ? 'New balance after this: ${CurrencyUtils.formatAmount(amount)}'
                  : 'Adding this will increase your balance',
              style: const TextStyle(
                color: Color(0xFF1976D2),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}