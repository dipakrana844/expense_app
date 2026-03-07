import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../data/repositories/transaction_repository.dart';

/// Provider: transactionRepositoryProvider
///
/// Lives in the presentation layer because it resolves the Riverpod DI graph.
/// The concrete [TransactionRepository] class remains pure (no Riverpod deps).
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final incomeDataSource = ref.watch(incomeLocalDataSourceProvider);
  final expenseDataSource = ref.watch(expenseLocalDataSourceProvider);

  return TransactionRepository(
    incomeDataSource: incomeDataSource,
    expenseDataSource: expenseDataSource,
  );
});
