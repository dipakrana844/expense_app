import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/grocery_preferences.dart';

/// Local Data Source for Grocery Preferences
///
/// Handles persistence of grocery user preferences and recent data
/// using Hive local storage.
class GroceryPreferencesLocalDataSource {
  late Box<GroceryPreferences> _preferencesBox;
  bool _isInitialized = false;
  static const String _boxName = 'grocery_preferences_box';
  static const String _preferencesKey = 'user_preferences';

  /// Initialize Hive and open preferences box
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Ensure Hive is initialized
      await Hive.initFlutter();

      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(10)) {
        Hive.registerAdapter(GroceryPreferencesAdapter());
      }

      // Open box
      _preferencesBox = await Hive.openBox<GroceryPreferences>(_boxName);

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Grocery Preferences Hive box: $e');
      rethrow;
    }
  }

  /// Get current grocery preferences
  ///
  /// Returns default preferences if none exist
  GroceryPreferences getPreferences() {
    _ensureInitialized();
    return _preferencesBox.get(_preferencesKey) ?? const GroceryPreferences();
  }

  /// Save grocery preferences
  Future<void> savePreferences(GroceryPreferences preferences) async {
    _ensureInitialized();
    try {
      final updated = preferences.copyWith(lastUpdated: DateTime.now());
      await _preferencesBox.put(_preferencesKey, updated);
    } catch (e) {
      throw Exception('Failed to save grocery preferences: $e');
    }
  }

  /// Update last store name
  Future<void> updateLastStoreName(String storeName) async {
    final current = getPreferences();
    if (current.saveLastStore) {
      final updated = current.copyWith(
        lastStoreName: storeName,
        lastUpdated: DateTime.now(),
      );
      await savePreferences(updated);
    }
  }

  /// Add item to frequent items list
  Future<void> addItemToFrequent(String itemName) async {
    final current = getPreferences();
    if (!current.showSuggestions) return;

    final currentItems = List<String>.from(current.frequentItems);
    
    // Remove if already exists to move to front
    currentItems.remove(itemName);
    
    // Add to front
    currentItems.insert(0, itemName);
    
    // Trim to max size
    if (currentItems.length > current.maxFrequentItems) {
      currentItems.removeRange(
        current.maxFrequentItems, 
        currentItems.length
      );
    }

    final updated = current.copyWith(
      frequentItems: currentItems,
      lastUpdated: DateTime.now(),
    );
    
    await savePreferences(updated);
  }

  /// Get suggested items (frequently purchased)
  List<String> getSuggestedItems() {
    final preferences = getPreferences();
    return preferences.showSuggestions ? preferences.frequentItems : [];
  }

  /// Reset all grocery preferences to defaults
  Future<void> resetToDefaults() async {
    _ensureInitialized();
    try {
      await _preferencesBox.delete(_preferencesKey);
    } catch (e) {
      throw Exception('Failed to reset grocery preferences: $e');
    }
  }

  /// Get storage usage information
  int getStorageSize() {
    _ensureInitialized();
    return _preferencesBox.length;
  }

  /// Close the Hive box
  Future<void> close() async {
    if (_isInitialized && _preferencesBox.isOpen) {
      await _preferencesBox.close();
      _isInitialized = false;
    }
  }

  /// Internal helper to ensure initialization
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'Grocery preferences data source not initialized. Call init() first.'
      );
    }
  }
}