import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../../domain/usecases/financial_trend_usecase.dart';

/// Provider: Financial Trend Use Case
///
/// Purpose: Provides the financial trend use case for calculations
final financialTrendUseCaseProvider = Provider<FinancialTrendUseCase>((ref) {
  return FinancialTrendUseCase();
});

/// Provider: Cache for financial trend data
///
/// Purpose: Caches expensive calculations to improve performance
final financialTrendCacheProvider = Provider<FinancialTrendCache>((ref) {
  return FinancialTrendCache();
});

/// Simple cache implementation for financial trend data
class FinancialTrendCache {
  final Map<String, _CacheEntry> _cache = {};
  static const Duration _expiry = Duration(minutes: 5);
  static const int _maxSize = 10;

  FinancialTrendDTO? get(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    if (DateTime.now().difference(entry.timestamp) > _expiry) {
      _cache.remove(key);
      return null;
    }

    return entry.data;
  }

  void set(String key, FinancialTrendDTO data) {
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
  final FinancialTrendDTO data;
  final DateTime timestamp;

  _CacheEntry(this.data, this.timestamp);
}

/// Provider: Financial Trend Data
///
/// Purpose: Main provider for complete financial trend analysis
/// - Fetches unified transaction data via allTransactionsProvider
/// - Processes through use case
/// - Provides comprehensive financial dashboard data
/// - Uses AsyncNotifierProvider for better async handling
final financialTrendProvider =
    AsyncNotifierProvider<FinancialTrendNotifier, FinancialTrendDTO>(
      FinancialTrendNotifier.new,
    );

class FinancialTrendNotifier extends AsyncNotifier<FinancialTrendDTO> {
  KeepAliveLink? _keepAliveLink;
  Timer? _debounceTimer;

  @override
  Future<FinancialTrendDTO> build() async {
    // Keep the provider alive when the widget is disposed
    ref.onDispose(() {
      _keepAliveLink?.close();
      _debounceTimer?.cancel();
    });

    final cache = ref.watch(financialTrendCacheProvider);
    final useCase = ref.watch(financialTrendUseCaseProvider);

    // Generate cache key based on current month
    final now = DateTime.now();
    final cacheKey = 'financial_trend_${now.year}_${now.month}';

    // Check cache first
    final cached = cache.get(cacheKey);
    if (cached != null) {
      _keepAliveLink = ref.keepAlive();
      return cached;
    }

    // Watch transactions and rebuild when they change
    final transactionsAsync = ref.watch(allTransactionsProvider);

    return transactionsAsync.when(
      data: (transactions) async {
        try {
          final result = await useCase.getFinancialTrend(
            transactions: transactions,
            monthsBack: 12,
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
      loading: () => throw StateError('Loading transactions'),
      error: (error, stack) => throw error,
    );
  }

  /// Manual refresh method with debouncing
  Future<void> refresh() async {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncValue.loading();

      final cache = ref.read(financialTrendCacheProvider);
      final useCase = ref.read(financialTrendUseCaseProvider);
      final transactionsAsync = ref.read(allTransactionsProvider);

      state = await AsyncValue.guard(() async {
        return transactionsAsync.when(
          data: (transactions) async {
            final now = DateTime.now();
            final cacheKey = 'financial_trend_${now.year}_${now.month}';

            // Clear cache to force fresh data
            cache.clear();

            final result = await useCase.getFinancialTrend(
              transactions: transactions,
              monthsBack: 12,
            );

            // Cache the new result
            cache.set(cacheKey, result);

            return result;
          },
          loading: () => throw StateError('No data available'),
          error: (error, _) => throw error,
        );
      });
    });
  }
}

/// Provider: Net Balance Trend for Chart
///
/// Purpose: Converts financial trend data to fl_chart compatible format
/// - Maps monthly balance points to FlSpot coordinates
/// - Ready for line chart visualization
/// - Uses select() for granular reactivity
final netBalanceTrendProvider = Provider<List<FlSpot>>((ref) {
  return ref.watch(
    financialTrendProvider.select(
      (asyncValue) => asyncValue.when(
        data: (trend) => trend.netBalanceTrend
            .asMap()
            .entries
            .map(
              (entry) =>
                  FlSpot(entry.key.toDouble(), entry.value.cumulativeBalance),
            )
            .toList(),
        loading: () => [],
        error: (_, __) => [],
      ),
    ),
  );
});

/// Provider: Income vs Expense Comparisons for Chart
///
/// Purpose: Prepares monthly comparison data for bar chart visualization
/// - Structures data for grouped bar chart
/// - Separates income and expense values
/// - Uses select() for granular reactivity
final incomeExpenseComparisonProvider = Provider<List<IncomeExpenseComparison>>(
  (ref) {
    return ref.watch(
      financialTrendProvider.select(
        (asyncValue) => asyncValue.when(
          data: (trend) => trend.monthlyComparisons,
          loading: () => [],
          error: (_, __) => [],
        ),
      ),
    );
  },
);

/// Provider: Financial Health Metrics
///
/// Purpose: Provides key financial health indicators
/// - Average income/expense calculations
/// - Savings rate and consistency metrics
/// - Best/worst month performance
/// - Uses select() for granular reactivity
final financialHealthMetricsProvider = Provider<FinancialHealthMetrics?>((ref) {
  return ref.watch(
    financialTrendProvider.select(
      (asyncValue) => asyncValue.when(
        data: (trend) => trend.healthMetrics,
        loading: () => null,
        error: (_, __) => null,
      ),
    ),
  );
});

/// Provider: Financial Insights
///
/// Purpose: Provides intelligent financial insights
/// - Trend analysis notifications
/// - Anomaly detections
/// - Performance recommendations
/// - Uses select() for granular reactivity
final financialInsightsProvider = Provider<List<FinancialInsight>>((ref) {
  return ref.watch(
    financialTrendProvider.select(
      (asyncValue) => asyncValue.when(
        data: (trend) => trend.insights,
        loading: () => [],
        error: (_, __) => [],
      ),
    ),
  );
});

/// Provider: Current Month Financial Summary
///
/// Purpose: Provides quick access to current month financial status
/// - Current month income, expenses, and net change
/// - Useful for real-time dashboard updates
/// - Uses select() for granular reactivity
final currentMonthFinancialSummaryProvider = Provider<MonthlyBalancePoint?>((
  ref,
) {
  return ref.watch(
    financialTrendProvider.select(
      (asyncValue) => asyncValue.when(
        data: (trend) {
          if (trend.netBalanceTrend.isEmpty) return null;

          final now = DateTime.now();
          final currentMonthKey =
              '${now.year}-${now.month.toString().padLeft(2, '0')}';

          return trend.netBalanceTrend.firstWhere(
            (point) => point.monthKey == currentMonthKey,
            orElse: () => trend.netBalanceTrend.last,
          );
        },
        loading: () => null,
        error: (_, __) => null,
      ),
    ),
  );
});

/// Provider: Financial Trend with configurable months back
///
/// Purpose: Allows querying financial trend for different time periods
/// - Useful for comparing different time ranges
/// - Uses family provider for parameterized queries
final financialTrendFamilyProvider =
    AsyncNotifierProvider<FinancialTrendFamilyNotifier, FinancialTrendDTO>(
      FinancialTrendFamilyNotifier.new,
    );

class FinancialTrendFamilyNotifier extends AsyncNotifier<FinancialTrendDTO> {
  int? _monthsBack;

  @override
  Future<FinancialTrendDTO> build() async {
    // Get the months back parameter from the provider
    _monthsBack = ref.watch(financialTrendMonthsBackProvider);

    if (_monthsBack == null) {
      throw StateError('monthsBack parameter is required');
    }

    final cache = ref.watch(financialTrendCacheProvider);
    final useCase = ref.watch(financialTrendUseCaseProvider);

    // Generate cache key based on months back parameter
    final now = DateTime.now();
    final cacheKey = 'financial_trend_${now.year}_${now.month}_$_monthsBack';

    // Check cache first
    final cached = cache.get(cacheKey);
    if (cached != null) {
      return cached;
    }

    // Watch transactions and rebuild when they change
    final transactionsAsync = ref.watch(allTransactionsProvider);

    return transactionsAsync.when(
      data: (transactions) async {
        try {
          final result = await useCase.getFinancialTrend(
            transactions: transactions,
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
      loading: () => throw StateError('Loading transactions'),
      error: (error, stack) => throw error,
    );
  }
}

/// Provider for months back parameter used by family provider
final financialTrendMonthsBackProvider = StateProvider<int>((ref) => 12);
