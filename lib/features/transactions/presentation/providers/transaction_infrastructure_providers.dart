import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../../income/presentation/providers/income_providers.dart';
import '../../../transfer/presentation/providers/transfer_providers.dart';
import '../../data/repositories/transaction_repository.dart';

/// Provider: transactionRepositoryProvider
///
/// Lives in the presentation layer because it resolves the Riverpod DI graph.
/// The concrete [TransactionRepository] class remains pure (no Riverpod deps).
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final incomeDataSource = ref.watch(incomeLocalDataSourceProvider);
  final expenseDataSource = ref.watch(expenseLocalDataSourceProvider);
  final transferDataSource = ref.watch(transferLocalDataSourceProvider);

  return TransactionRepository(
    incomeDataSource: incomeDataSource,
    expenseDataSource: expenseDataSource,
    transferDataSource: transferDataSource,
  );
});
