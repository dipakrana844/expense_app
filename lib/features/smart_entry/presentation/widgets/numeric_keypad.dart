import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Color? accentColor;

  const NumericKeypad({
    super.key,
    required this.onKeyPressed,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(['1', '2', '3'], context),
          const SizedBox(height: 8),
          _buildRow(['4', '5', '6'], context),
          const SizedBox(height: 8),
          _buildRow(['7', '8', '9'], context),
          const SizedBox(height: 8),
          _buildRow(['.', '0', 'BACK'], context),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys, BuildContext context) {
    return Row(
      children: keys.map((key) => Expanded(child: _buildKey(key, context))).toList(),
    );
  }

  Widget _buildKey(String key, BuildContext context) {
    final isBackspace = key == 'BACK';
    final isDot = key == '.';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onKeyPressed(key);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: isBackspace 
                  ? (accentColor ?? Theme.of(context).colorScheme.primary).withOpacity(0.1)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: isBackspace
                ? Icon(Icons.backspace_outlined, color: accentColor ?? Theme.of(context).colorScheme.primary)
                : Text(
                    isDot ? '.' : key,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}