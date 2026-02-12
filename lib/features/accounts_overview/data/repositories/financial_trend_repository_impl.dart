import '../../../../core/domain/interfaces/transaction_interface.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../../domain/usecases/financial_trend_usecase.dart';
import 'financial_trend_repository.dart';

/// Repository Implementation: Financial Trend Repository
///
/// Purpose: Concrete implementation of financial trend data access
/// - Delegates to FinancialTrendUseCase for business logic
/// - Acts as adapter between data layer and domain layer
/// - Maintains clean architecture boundaries
class FinancialTrendRepositoryImpl implements FinancialTrendRepository {
  final FinancialTrendUseCase _financialTrendUseCase;

  FinancialTrendRepositoryImpl({required FinancialTrendUseCase financialTrendUseCase})
      : _financialTrendUseCase = financialTrendUseCase;

  @override
  Future<FinancialTrendDTO> getFinancialTrend({
    required List<TransactionInterface> transactions,
    int monthsBack = 12,
  }) async {
    // Delegate to use case - this repository acts as an adapter
    // that translates between data layer concerns and domain layer operations
    return await _financialTrendUseCase.getFinancialTrend(
      transactions: transactions,
      monthsBack: monthsBack,
    );
  }
}