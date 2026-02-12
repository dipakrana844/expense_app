import '../../../../core/domain/interfaces/transaction_interface.dart';
import '../../domain/entities/financial_trend_dto.dart';

/// Repository Interface: Financial Trend Repository
///
/// Purpose: Abstract interface for financial trend data access
/// - Defines contract for financial trend data retrieval
/// - Enables dependency inversion principle
/// - Supports multiple data source implementations
abstract class FinancialTrendRepository {
  /// Get financial trend analysis for specified period
  ///
  /// Parameters:
  /// - transactions: Unified list of income and expense transactions
  /// - monthsBack: Number of months to analyze (default: 12)
  ///
  /// Returns: Complete financial trend data including trends, comparisons, and insights
  Future<FinancialTrendDTO> getFinancialTrend({
    required List<TransactionInterface> transactions,
    int monthsBack = 12,
  });
}