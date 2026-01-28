import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../domain/entities/grocery_item.dart';
import 'grocery_state.dart';

part 'grocery_notifier.g.dart';

@riverpod
class GroceryNotifier extends _$GroceryNotifier {
  @override
  GrocerySessionState build() {
    return const GrocerySessionState();
  }

  void updateStoreName(String name) {
    state = state.copyWith(storeName: name);
  }

  void addItem(String name, double price) {
    if (name.isEmpty || price <= 0) return;

    final newItem = GroceryItem(
      id: const Uuid().v4(),
      name: name,
      price: price,
    );

    final updatedList = [...state.items, newItem];
    state = state.copyWith(
      items: updatedList,
      totalAmount: _calculateTotal(updatedList),
    );
  }

  void removeItem(String id) {
    final updatedList = state.items.where((item) => item.id != id).toList();
    state = state.copyWith(
      items: updatedList,
      totalAmount: _calculateTotal(updatedList),
    );
  }

  void updateItem(String id, String name, double price) {
    if (name.isEmpty || price <= 0) return;

    final updatedList = state.items.map((item) {
      if (item.id == id) {
        return item.copyWith(name: name, price: price);
      }
      return item;
    }).toList();

    state = state.copyWith(
      items: updatedList,
      totalAmount: _calculateTotal(updatedList),
    );
  }

  Future<void> submitSession() async {
    if (state.items.isEmpty) return;
    if (state.isSubmitting) return;

    state = state.copyWith(isSubmitting: true);

    try {
      final repository = ref.read(expenseRepositoryProvider);

      final storeName =
          (state.storeName == null || state.storeName!.trim().isEmpty)
          ? 'Local Store'
          : state.storeName!.trim();

      // Create metadata logic
      final metadata = {
        'numberOfItems': state.items.length,
        'items': state.items
            .map((e) => {'name': e.name, 'price': e.price})
            .toList(),
      };

      final noteString = "Grocery - $storeName\n\n${jsonEncode(metadata)}";

      // Although the prompt says "metadata (optional): itemBreakdown (optional JSON/string)"
      // and "title: Grocery - <Local Store Name>", I am encoding it in the note.
      // If simply "Grocery - StoreName" is preferred as the 'title' equivalent, I'll put that in the note's first line.

      await repository.createExpense(
        amount: state.totalAmount,
        category: 'Grocery',
        date: DateTime.now(),
        note: noteString,
      );

      // On success, clear state
      state = const GrocerySessionState();

      // Navigation should be handled by the UI listener, or we can trigger a side effect.
      // But typically state reset is enough here.
    } catch (e) {
      // Handle error (maybe set an error state if I had one)
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  double _calculateTotal(List<GroceryItem> items) {
    return items.fold(0.0, (sum, item) => sum + item.price);
  }
}
