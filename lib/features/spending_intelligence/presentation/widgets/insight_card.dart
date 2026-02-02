import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/insight.dart';

class InsightCard extends ConsumerWidget {
  final Insight insight;
  final VoidCallback onDismiss;

  const InsightCard({
    super.key,
    required this.insight,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color baseColor;
    IconData iconData;

    switch (insight.severity) {
      case InsightSeverity.critical:
        baseColor = colorScheme.error;
        break;
      case InsightSeverity.warning:
        baseColor = const Color(0xFFF57C00); // Orange 700
        break;
      case InsightSeverity.info:
        baseColor = colorScheme.primary;
        break;
    }

    switch (insight.type) {
      case InsightType.anomaly:
        iconData = Icons.warning_amber_rounded;
        break;
      case InsightType.budgetPrediction:
        iconData = Icons.trending_down_rounded;
        break;
      case InsightType.categoryDominance:
        iconData = Icons.pie_chart_outline_rounded;
        break;
      case InsightType.dailyInsight:
        iconData = Icons.lightbulb_outline_rounded;
        break;
    }

    return Dismissible(
      key: Key(insight.id),
      onDismissed: (_) => onDismiss(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.check_circle_outline, color: baseColor),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: baseColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: baseColor.withOpacity(0.3), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Subtle background decoration
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: baseColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(iconData, color: baseColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                insight.title,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: baseColor,
                                ),
                              ),
                              const Spacer(),
                              if (!insight.isRead)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight.message,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
