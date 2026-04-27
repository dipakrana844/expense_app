import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery_preferences.freezed.dart';

/// Grocery Preferences Model
///
/// Stores user preferences and recent data for grocery sessions:
/// - Last used store name
/// - Frequently purchased items
/// - User preferences for grocery behavior
@freezed
abstract class GroceryPreferences with _$GroceryPreferences {
  const factory GroceryPreferences({
    /// Last store name used in a grocery session
    String? lastStoreName,

    /// List of frequently purchased items (name only)
    @Default([]) List<String> frequentItems,

    /// Maximum number of frequent items to track
    @Default(20) int maxFrequentItems,

    /// Whether to save last store name between sessions
    @Default(true) bool saveLastStore,

    /// Whether to show frequent item suggestions
    @Default(true) bool showSuggestions,

    /// Whether to clear grocery session on app exit
    @Default(false) bool clearOnExit,

    /// Whether to confirm before submitting grocery session
    @Default(true) bool confirmSubmit,

    /// Timestamp of last update
    DateTime? lastUpdated,
  }) = _GroceryPreferences;
}
