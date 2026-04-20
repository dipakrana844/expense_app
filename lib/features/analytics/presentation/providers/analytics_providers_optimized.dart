import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/expenses/domain/entities/expense_entity.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/income/domain/entities/income_entity.dart';
import 'package:smart_expense_tracker/features/income/presentation/providers/income_providers.dart';
import 'package:smart_expense_tracker/features/spending_intelligence/domain/entities/insight.dart';
import 'package:smart_expense_tracker/features/analytics/domain/entities/analytics_entity.dart';
import 'package:smart_expense_tracker/features/analytics/domain/usecases/get_financial_analytics_usecase.dart';
import 'package:smart_expense_tracker/features/analytics/domain/repositories/analytics_repository.dart';

/// Provider: Analytics Repository
///
/// Purpose: Provides the analytics repository
final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  // This would be injected from the infrastructure layer
  throw UnimplementedError('Analytics repository not implemented');
});

/// Provider: Get Financial Analytics Use Case
///
/// Purpose: Provides the use case for analytics calculations
final getFinancialAnalyticsUseCaseProvider =
    Provider<GetFinancialAnalyticsUsecase>((ref) {
      return GetFinancialAnalyticsUsecase(
        ref.watch(analyticsRepositoryProvider),
      );
    });

/// Provider: Cache for Analytics Data
///
/// Purpose: Caches expensive calculations to improve performance
final analyticsCacheProvider = Provider<AnalyticsCache>((ref) {
  return AnalyticsCache();
});

/// Simple cache implementation for analytics data
class AnalyticsCache {
  final Map<String, _CacheEntry> _cache = {};
  static const Duration _expiry = Duration(minutes: 5);
  static const int _maxSize = 10;

  AnalyticsData? get(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    if (DateTime.now().difference(entry.timestamp) > _expiry) {
      _cache.remove(key);
      return null;
    }

    return entry.data;
  }

  void set(String key, AnalyticsData data) {
    if (_cache.length >= _maxSize) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = _CacheEntry(data, DateTime.now());
  }

  void clear() {
    _cache.clear();
  }
}

class _CacheEntry {
  final AnalyticsData data;
  final DateTime timestamp;

  _CacheEntry(this.data, this.timestamp);
}

/// Provider: Analytics Data
///
/// Purpose: Main provider for all analytics data
/// - Fetches unified analytics data via use case
/// - Provides comprehensive analytics dashboard data
/// - Uses AsyncNotifierProvider for better async handling
final analyticsDataProvider =
    AsyncNotifierProvider<AnalyticsDataNotifier, AnalyticsData>(
      AnalyticsDataNotifier.new,
    );

class AnalyticsDataNotifier extends AsyncNotifier<AnalyticsData> {
  KeepAliveLink? _keepAliveLink;
  Timer? _debounceTimer;

  @override
  Future<AnalyticsData> build() async {
    // Keep the provider alive when the widget is disposed
    ref.onDispose(() {
      _keepAliveLink?.close();
      _debounceTimer?.cancel();
    });

    final cache = ref.watch(analyticsCacheProvider);
    final useCase = ref.watch(getFinancialAnalyticsUseCaseProvider);

    // Generate cache key based on current month
    final now = DateTime.now();
    final cacheKey = 'analytics_${now.year}_${now.month}';

    // Check cache first
    final cached = cache.get(cacheKey);
    if (cached != null) {
      _keepAliveLink = ref.keepAlive();
      return cached;
    }

    // Watch transactions and rebuild when they change
    final incomesAsync = ref.watch(incomesProvider);
    final expensesAsync = ref.watch(expensesProvider);

    return incomesAsync.when(
      data: (incomes) => expensesAsync.when(
        data: (expenses) async {
          try {
            final result = await useCase.call(
              incomes: incomes,
              expenses: expenses,
            );

            // Cache the result
            cache.set(cacheKey, result);

            // Keep the provider alive
            _keepAliveLink = ref.keepAlive();

            return result;
          } catch (e, stack) {
            state = AsyncValue.error(e, stack);
            rethrow;
          }
        },
        loading: () => throw StateError('Loading expenses'),
        error: (error, stack) => throw error,
      ),
      loading: () => throw StateError('Loading incomes'),
      error: (error, stack) => throw error,
    );
  }

  /// Manual refresh method with debouncing
  Future<void> refresh() async {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncValue.loading();

      final cache = ref.read(analyticsCacheProvider);
      final useCase = ref.read(getFinancialAnalyticsUseCaseProvider);
      final incomesAsync = ref.read(incomesProvider);
      final expensesAsync = ref.read(expensesProvider);

      state = await AsyncValue.guard(() async {
        return incomesAsync.when(
          data: (incomes) => expensesAsync.when(
            data: (expenses) async {
              final now = DateTime.now();
              final cacheKey = 'analytics_${now.year}_${now.month}';

              // Clear cache to force fresh data
              cache.clear();

              final result = await useCase.call(
                incomes: incomes,
                expenses: expenses,
              );

              // Cache the new result
              cache.set(cacheKey, result);

              return result;
            },
            loading: () => throw StateError('No data available'),
            error: (error, _) => throw error,
          ),
          loading: () => throw StateError('No data available'),
          error: (error, _) => throw error,
        );
      });
    });
  }
}

/// Provider: Daily Snapshot
///
/// Purpose: Provides daily spending snapshot with today/yesterday comparison
/// - Uses select() for granular reactivity
final dailySnapshotProvider = Provider<DailySnapshotEntity>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.dailySnapshot,
        loading: () => DailySnapshotEntity.empty(),
        error: (_, __) => DailySnapshotEntity.empty(),
      ),
    ),
  );
});

/// Provider: Smart Warnings
///
/// Purpose: Provides anomaly detection and budget burn insights
/// - Uses select() for granular reactivity
final smartWarningsProvider = Provider<List<Insight>>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.smartWarnings,
        loading: () => [],
        error: (_, __) => [],
      ),
    ),
  );
});

/// Provider: Trend Explanation
///
/// Purpose: Provides text explanation of spending trends
/// - Uses select() for granular reactivity
final trendExplanationProvider = Provider<String>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.trendExplanation,
        loading: () => 'Loading analytics...',
        error: (_, __) => 'Error loading analytics',
      ),
    ),
  );
});

/// Provider: Category Action Insights
///
/// Purpose: Provides category-wise spending insights
/// - Uses select() for granular reactivity
final categoryActionInsightsProvider =
    Provider<Map<String, CategoryInsightEntity>>((ref) {
      return ref.watch(
        analyticsDataProvider.select(
          (asyncValue) => asyncValue.when(
            data: (analytics) => analytics.categoryInsights,
            loading: () => {},
            error: (_, __) => {},
          ),
        ),
      );
    });

/// Provider: Financial Analytics
///
/// Purpose: Provides comprehensive financial analytics
/// - Uses select() for granular reactivity
final financialAnalyticsProvider = Provider<FinancialAnalyticsEntity>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.financialAnalytics,
        loading: () => FinancialAnalyticsEntity.empty(),
        error: (_, __) => FinancialAnalyticsEntity.empty(),
      ),
    ),
  );
});

/// Provider: Income vs Expense Trend
///
/// Purpose: Provides income vs expense trend data
/// - Uses select() for granular reactivity
final incomeExpenseTrendProvider = Provider<Map<String, Map<String, double>>>((
  ref,
) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.incomeExpenseTrend,
        loading: () => {},
        error: (_, __) => {},
      ),
    ),
  );
});

/// Provider: Monthly Analytics
///
/// Purpose: Provides monthly spending analytics
/// - Uses select() for granular reactivity
final monthlyAnalyticsProvider = Provider<MonthlyAnalyticsEntity>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.monthlyAnalytics,
        loading: () => MonthlyAnalyticsEntity.empty(),
        error: (_, __) => MonthlyAnalyticsEntity.empty(),
      ),
    ),
  );
});

/// Provider: Monthly Trend
///
/// Purpose: Provides monthly trend data
/// - Uses select() for granular reactivity
final monthlyTrendProvider = Provider<Map<String, double>>((ref) {
  return ref.watch(
    analyticsDataProvider.select(
      (asyncValue) => asyncValue.when(
        data: (analytics) => analytics.monthlyTrend,
        loading: () => {},
        error: (_, __) => {},
      ),
    ),
  );
});

/// Provider: Analytics Months Back
///
/// Purpose: Provides configurable months back for analytics
/// - Used by family provider for parameterized queries
final analyticsMonthsBackProvider = StateProvider<int>((ref) => 6);

/// Provider: Analytics Data with configurable months back
///
/// Purpose: Allows querying analytics for different time periods
/// - Uses family provider for parameterized queries
final analyticsDataFamilyProvider =
    AsyncNotifierProvider<AnalyticsDataFamilyNotifier, AnalyticsData>(
      AnalyticsDataFamilyNotifier.new,
    );

class AnalyticsDataFamilyNotifier extends AsyncNotifier<AnalyticsData> {
  int? _monthsBack;

  @override
  Future<AnalyticsData> build() async {
    // Get the months back parameter from the provider
    _monthsBack = ref.watch(analyticsMonthsBackProvider);

    if (_monthsBack == null) {
      throw StateError('monthsBack parameter is required');
    }

    final cache = ref.watch(analyticsCacheProvider);
    final useCase = ref.watch(getFinancialAnalyticsUseCaseProvider);

    // Generate cache key based on months back parameter
    final now = DateTime.now();
    final cacheKey = 'analytics_${now.year}_${now.month}_$_monthsBack';

    // Check cache first
    final cached = cache.get(cacheKey);
    if (cached != null) {
      return cached;
    }

    // Watch transactions and rebuild when they change
    final incomesAsync = ref.watch(incomesProvider);
    final expensesAsync = ref.watch(expensesProvider);

    return incomesAsync.when(
      data: (incomes) => expensesAsync.when(
        data: (expenses) async {
          try {
            final result = await useCase.call(
              incomes: incomes,
              expenses: expenses,
              monthsBack: _monthsBack!,
            );

            // Cache the result
            cache.set(cacheKey, result);

            return result;
          } catch (e, stack) {
            state = AsyncValue.error(e, stack);
            rethrow;
          }
        },
        loading: () => throw StateError('Loading expenses'),
        error: (error, stack) => throw error,
      ),
      loading: () => throw StateError('Loading incomes'),
      error: (error, stack) => throw error,
    );
  }
}
