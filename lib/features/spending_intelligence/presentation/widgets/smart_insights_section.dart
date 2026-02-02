import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/spending_intelligence_provider.dart';
import 'insight_card.dart';

class SmartInsightsSection extends ConsumerWidget {
  const SmartInsightsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(insightsProvider);

    return insightsAsync.when(
      data: (insights) {
        final unreadInsights = insights.where((i) => !i.isRead).toList();
        if (unreadInsights.isEmpty) return const SizedBox.shrink();

        // Show max 3 insights to avoid clutter
        final displayInsights = unreadInsights.take(3).toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Smart Insights',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayInsights.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final insight = displayInsights[index];
                return InsightCard(
                  insight: insight,
                  onDismiss: () {
                    ref.read(insightsProvider.notifier).markAsRead(insight.id);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      // If error or loading, hide section to avoid disrupting UX
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
