import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'grocery_preferences.freezed.dart';
part 'grocery_preferences.g.dart';

/// Grocery Preferences Model
///
/// Stores user preferences and recent data for grocery sessions:
/// - Last used store name
/// - Frequently purchased items
/// - User preferences for grocery behavior
@freezed
@HiveType(typeId: 10)
class GroceryPreferences with _$GroceryPreferences {
  const factory GroceryPreferences({
    /// Last store name used in a grocery session
    @HiveField(0)
    String? lastStoreName,

    /// List of frequently purchased items (name only)
    @HiveField(1)
    @Default([])
    List<String> frequentItems,

    /// Maximum number of frequent items to track
    @HiveField(2)
    @Default(20)
    int maxFrequentItems,

    /// Whether to save last store name between sessions
    @HiveField(3)
    @Default(true)
    bool saveLastStore,

    /// Whether to show frequent item suggestions
    @HiveField(4)
    @Default(true)
    bool showSuggestions,

    /// Whether to clear grocery session on app exit
    @HiveField(5)
    @Default(false)
    bool clearOnExit,

    /// Whether to confirm before submitting grocery session
    @HiveField(6)
    @Default(true)
    bool confirmSubmit,

    /// Timestamp of last update
    @HiveField(7)
    DateTime? lastUpdated,
  }) = _GroceryPreferences;

  factory GroceryPreferences.fromJson(Map<String, dynamic> json) =>
      _$GroceryPreferencesFromJson(json);
}