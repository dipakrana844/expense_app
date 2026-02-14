import 'package:flutter/material.dart';
import '../providers/smart_entry_controller.dart';

class ModeSelector extends StatelessWidget {
  final TransactionMode currentMode;
  final Function(TransactionMode) onModeChanged;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildSegment(TransactionMode.income, 'Income', const Color(0xFF2196F3), context),
          _buildSegment(TransactionMode.expense, 'Expense', const Color(0xFFF44336), context),
          _buildSegment(TransactionMode.transfer, 'Transfer', const Color(0xFF757575), context),
        ],
      ),
    );
  }

  Widget _buildSegment(TransactionMode mode, String label, Color color, BuildContext context) {
    final isSelected = currentMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onModeChanged(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}