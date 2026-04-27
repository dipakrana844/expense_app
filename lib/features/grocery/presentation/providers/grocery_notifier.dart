import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import 'package:smart_expense_tracker/features/settings/data/models/app_settings.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import 'package:smart_expense_tracker/features/grocery/domain/entities/grocery_item.dart';
import 'package:smart_expense_tracker/features/grocery/domain/services/grocery_service.dart';
import 'package:smart_expense_tracker/features/grocery/data/local/grocery_preferences_local_data_source.dart';
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
    // Read global settings instead of local preferences
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull ?? const AppSettings();

    // Get grocery preferences for data, but use global settings for behavior
    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    final preferences = prefsDataSource.getPreferences();

    return GrocerySessionState(
      storeName: settings.saveLastStoreName ? preferences.lastStoreName : '',
    );
  }

  void updateStoreName(String name) {
    state = state.copyWith(storeName: name);

    // Save to preferences if enabled in global settings
    final settingsAsync = ref.read(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull ?? const AppSettings();
    if (settings.saveLastStoreName) {
      final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
      prefsDataSource.updateLastStoreName(name);
    }
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

    // Track frequent items if enabled in global settings
    final settingsAsync = ref.read(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull ?? const AppSettings();
    if (settings.showFrequentItemSuggestions) {
      final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
      prefsDataSource.addItemToFrequent(name);
    }
  }

  void initEditMode(String expenseId) {
    final repository = ref.read(expenseRepositoryProvider);
    final (expense, error) = repository.getExpenseById(expenseId);

    if (error != null || expense == null) return;

    final metadata = expense.metadata;
    if (metadata == null) return;

    final storeName = metadata['storeName'] as String? ?? '';
    final itemsList = metadata['items'] as List<dynamic>? ?? [];

    final items = itemsList.map((e) {
      final map = e as Map<dynamic, dynamic>;
      return GroceryItem(
        id: const Uuid().v4(),
        name: map['name'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    state = GrocerySessionState(
      expenseId: expenseId,
      mode: GrocerySessionMode.edit,
      storeName: storeName,
      items: items,
      totalAmount: _calculateTotal(items),
    );
  }

  void addItems(List<GroceryItem> newItems) {
    if (newItems.isEmpty) return;

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
      final service = ref.read(groceryServiceProvider);

      await service.submitGrocerySession(
        items: state.items,
        totalAmount: state.totalAmount,
        storeName: state.storeName ?? '',
        expenseId: state.expenseId,
        isEdit: state.mode == GrocerySessionMode.edit,
      );

      // On success, clear state
      state = const GrocerySessionState();
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  double _calculateTotal(List<GroceryItem> items) {
    return items.fold(0.0, (sum, item) => sum + item.price);
  }

  /// Get suggested items based on global settings
  List<String> getSuggestedItems() {
    final settingsAsync = ref.read(appSettingsNotifierProvider);
    final settings = settingsAsync.valueOrNull ?? const AppSettings();
    if (!settings.showFrequentItemSuggestions) return [];

    final prefsDataSource = ref.read(groceryPreferencesDataSourceProvider);
    return prefsDataSource.getSuggestedItems();
  }

  void resetSession() {
    state = const GrocerySessionState(
      mode: GrocerySessionMode.create,
      expenseId: null,
    );
  }
}
