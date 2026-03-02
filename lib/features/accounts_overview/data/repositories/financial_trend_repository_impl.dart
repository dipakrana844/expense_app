import '../../../../core/domain/interfaces/transaction_interface.dart';
import '../../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../domain/entities/financial_trend_dto.dart';
import '../../domain/usecases/financial_trend_usecase.dart';
import 'financial_trend_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository Implementation: Financial Trend Repository
///
/// Purpose: Concrete implementation of financial trend data access
/// - Fetches transactions from data sources
/// - Delegates to FinancialTrendUseCase for business logic
/// - Acts as adapter between data layer and domain layer
/// - Maintains clean architecture boundaries
class FinancialTrendRepositoryImpl implements FinancialTrendRepository {
  final FinancialTrendUseCase _financialTrendUseCase;
  final Ref _ref;

  FinancialTrendRepositoryImpl({
    required FinancialTrendUseCase financialTrendUseCase,
    required Ref ref,
  })  : _financialTrendUseCase = financialTrendUseCase,
        _ref = ref;

  @override
  Future<FinancialTrendDTO> getFinancialTrend({
    int monthsBack = 12,
  }) async {
    // Fetch all transactions from the transaction provider
    final transactionsAsync = _ref.read(allTransactionsProvider);
    
    return transactionsAsync.when(
      data: (transactions) async {
        // Delegate to use case with fetched transactions
        return await _financialTrendUseCase.getFinancialTrend(
          transactions: transactions,
          monthsBack: monthsBack,
        );
      },
      loading: () => throw Exception('Loading transactions...'),
      error: (error, stack) => throw Exception('Failed to load transactions: $error'),
    );
  }
}