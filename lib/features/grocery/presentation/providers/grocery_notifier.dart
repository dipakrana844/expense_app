import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../expenses/presentation/providers/expense_providers.dart';
import '../../domain/entities/grocery_item.dart';
import '../../data/local/grocery_preferences_local_data_source.dart';
import 'grocery_state.dart';

part 'grocery_notifier.g.dart';

/// Provider for Grocery Preferences Data Source
final groceryPreferencesDataSourceProvider = Provider((ref) {
  final dataSource = GroceryPreferencesLocalDataSource();
  dataSource.init();
  return dataSource;
});

@riverpod
class GroceryNotifier extends _$GroceryNotifier {
  @override
  GrocerySessionState build() {
    // Initialize with last store name if preference is enabled
    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    final preferences = prefsDataSource.getPreferences();
    
    return GrocerySessionState(
      storeName: preferences.saveLastStore ? preferences.lastStoreName : '',
    );
  }

  void updateStoreName(String name) {
    state = state.copyWith(storeName: name);
    
    // Save to preferences if enabled
    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    prefsDataSource.updateLastStoreName(name);
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
    
    // Track frequent items
    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    prefsDataSource.addItemToFrequent(name);
  }

  void addItems(List<GroceryItem> newItems) {
    if (newItems.isEmpty) return;

    // Assign new IDs if necessary or trust incoming (OCR generates IDs)
    // Here we assume OCR IDs are temporary but valid UUIDs.

    final updatedList = [...state.items, ...newItems];
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

      await repository.createExpense(
        amount: state.totalAmount,
        category: 'Grocery',
        date: DateTime.now(),
        note: "Grocery at $storeName",
        metadata: metadata,
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

  /// Get suggested items based on user preferences
  List<String> getSuggestedItems() {
    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    return prefsDataSource.getSuggestedItems();
  }

  /// Reset grocery session state
  void resetSession() {
    state = const GrocerySessionState();
  }
}
