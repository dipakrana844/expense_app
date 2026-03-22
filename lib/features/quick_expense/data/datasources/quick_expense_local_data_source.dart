import 'package:hive_flutter/hive_flutter.dart';
import '../models/quick_expense_preferences_model.dart';

/// Local data source for quick expense operations
///
/// Handles all local storage operations for quick expense preferences
/// using Hive as the storage backend.
class QuickExpenseLocalDataSource {
  static const String _preferencesBoxName = 'quick_expense_prefs';
  static const String _lastCategoryKey = 'last_quick_expense_category';

  /// Initialize the data source
  ///
  /// Opens the preferences box
  Future<void> initialize() async {
    await Hive.openBox<Map<String, dynamic>>(_preferencesBoxName);
  }

  /// Get the last used category
  ///
  /// Returns [Future<String?>] the last used category or null if not set
  Future<String?> getLastUsedCategory() async {
    try {
      final box = await Hive.openBox<Map<String, dynamic>>(_preferencesBoxName);
      final preferencesMap = box.get(_lastCategoryKey);
      if (preferencesMap != null) {
        final preferences = QuickExpensePreferences.fromMap(preferencesMap);
        return preferences.lastUsedCategory;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Save the last used category
  ///
  /// [category]: The category to save as last used
  /// Returns [Future<void>]
  Future<void> saveLastUsedCategory(String category) async {
    try {
      final box = await Hive.openBox<Map<String, dynamic>>(_preferencesBoxName);
      final preferences = QuickExpensePreferences(
        lastUsedCategory: category,
        lastUpdated: DateTime.now(),
      );
      await box.put(_lastCategoryKey, preferences.toMap());
    } catch (_) {
      // Ignore storage errors for preferences
    }
  }

  /// Close the data source
  ///
  /// Closes the Hive box to free resources
  Future<void> close() async {
    try {
      final box = Hive.box<Map<String, dynamic>>(_preferencesBoxName);
      await box.close();
    } catch (_) {
      // Ignore errors during close
    }
  }
}