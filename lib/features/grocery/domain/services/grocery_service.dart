import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import '../entities/grocery_item.dart';

/// Domain Service: GroceryService
///
/// Orchestrates complex business logic and repository interactions for groceries.
/// This keeps the presentation Notifiers lean and focused strictly on UI state.
class GroceryService {
  final Ref _ref;

  GroceryService(this._ref);

  Future<void> submitGrocerySession({
    required List<GroceryItem> items,
    required double totalAmount,
    required String storeName,
    String? expenseId,
    bool isEdit = false,
  }) async {
    final repository = _ref.read(expenseRepositoryProvider);

    final store = storeName.trim().isEmpty ? 'Local Store' : storeName.trim();

    final metadata = {
      'storeName': store,
      'numberOfItems': items.length,
      'items': items.map((e) => {'name': e.name, 'price': e.price}).toList(),
    };

    if (isEdit && expenseId != null) {
      await repository.updateExpense(
        id: expenseId,
        amount: totalAmount,
        category: 'Grocery',
        date: DateTime.now(),
        note: "Grocery at $store",
        metadata: metadata,
      );
    } else {
      await repository.createExpense(
        amount: totalAmount,
        category: 'Grocery',
        date: DateTime.now(),
        note: "Grocery at $store",
        metadata: metadata,
      );
    }
  }
}

final groceryServiceProvider = Provider((ref) => GroceryService(ref));
