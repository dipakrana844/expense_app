import '../../domain/entities/financial_trend_dto.dart';
import 'financial_trend_repository.dart';

/// Repository Implementation: Financial Trend Repository
///
/// Purpose: Concrete implementation for dependency injection
/// - Provides a injectable repository interface
/// - Delegates business logic to FinancialTrendUseCase
/// - Maintains clean architecture boundaries
///
/// Note: This repository is calculation-focused rather than data-access focused.
/// The actual transaction fetching and processing happens through Riverpod providers.
class FinancialTrendRepositoryImpl implements FinancialTrendRepository {
  @override
  Future<FinancialTrendDTO> getFinancialTrend({
    int monthsBack = 12,
  }) async {
    // This method is not used in the current architecture.
    // The financial trend calculations are performed through the provider chain:
    // financialTrendProvider → reads transactions via allTransactionsProvider
    throw UnimplementedError(
      'Direct repository access not supported. Use FinancialTrendProvider instead.',
    );
  }
}