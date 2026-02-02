import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/spending_intelligence_repository_impl.dart';
import '../../data/datasources/spending_intelligence_local_data_source.dart';
import '../../domain/repositories/spending_intelligence_repository.dart';
import '../../domain/usecases/get_insights.dart';
import '../../domain/usecases/mark_insight_read.dart';
import '../../domain/entities/insight.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';

final spendingIntelligenceLocalDataSourceProvider = Provider(
  (ref) => SpendingIntelligenceLocalDataSource(),
);

final spendingIntelligenceRepositoryProvider =
    Provider<SpendingIntelligenceRepository>((ref) {
      final localDataSource = ref.watch(
        spendingIntelligenceLocalDataSourceProvider,
      );
      final expenseDataSource = ref.watch(expenseLocalDataSourceProvider);
      return SpendingIntelligenceRepositoryImpl(
        localDataSource,
        expenseDataSource,
      );
    });

final getInsightsUseCaseProvider = Provider((ref) {
  return GetInsights(ref.watch(spendingIntelligenceRepositoryProvider));
});

final markInsightReadUseCaseProvider = Provider((ref) {
  return MarkInsightRead(ref.watch(spendingIntelligenceRepositoryProvider));
});

class InsightsNotifier extends StateNotifier<AsyncValue<List<Insight>>> {
  final GetInsights _getInsights;
  final MarkInsightRead _markRead;
  final SpendingIntelligenceLocalDataSource _dataSource;

  InsightsNotifier(this._getInsights, this._markRead, this._dataSource)
    : super(const AsyncValue.loading()) {
    _initAndLoad();
  }

  Future<void> _initAndLoad() async {
    try {
      await _dataSource.init();
      final insights = await _getInsights();
      state = AsyncValue.data(insights);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _initAndLoad();
  }

  Future<void> markAsRead(String id) async {
    await _markRead(id);
    state = state.whenData((insights) {
      return insights.map((insight) {
        if (insight.id == id) return insight.copyWith(isRead: true);
        return insight;
      }).toList();
    });
  }
}

final insightsProvider =
    StateNotifierProvider<InsightsNotifier, AsyncValue<List<Insight>>>((ref) {
      final getInsights = ref.watch(getInsightsUseCaseProvider);
      final markRead = ref.watch(markInsightReadUseCaseProvider);
      final dataSource = ref.watch(spendingIntelligenceLocalDataSourceProvider);
      return InsightsNotifier(getInsights, markRead, dataSource);
    });
