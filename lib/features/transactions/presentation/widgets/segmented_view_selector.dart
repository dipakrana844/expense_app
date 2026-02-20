import 'package:flutter/material.dart';

class SegmentedViewSelector extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const SegmentedViewSelector({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final isSelected = controller.index == index;
              final colorScheme = Theme.of(context).colorScheme;

              return InkWell(
                onTap: () => controller.animateTo(index),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected ? null : Border.all(
                      color: colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
