/// Data class for quick expense preferences
///
/// This class represents the data structure for storing
/// quick expense preferences in local storage.
class QuickExpensePreferences {
  final String lastUsedCategory;
  final DateTime lastUpdated;

  QuickExpensePreferences({
    required this.lastUsedCategory,
    required this.lastUpdated,
  });

  /// Create preferences with default values
  factory QuickExpensePreferences.defaults() {
    return QuickExpensePreferences(
      lastUsedCategory: 'Grocery',
      lastUpdated: DateTime.now(),
    );
  }

  /// Create a copy of the preferences with updated values
  QuickExpensePreferences copyWith({
    String? lastUsedCategory,
    DateTime? lastUpdated,
  }) {
    return QuickExpensePreferences(
      lastUsedCategory: lastUsedCategory ?? this.lastUsedCategory,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Convert to map for serialization
  Map<String, dynamic> toMap() {
    return {
      'lastUsedCategory': lastUsedCategory,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Create from map for deserialization
  factory QuickExpensePreferences.fromMap(Map<String, dynamic> map) {
    return QuickExpensePreferences(
      lastUsedCategory: map['lastUsedCategory'] as String,
      lastUpdated: DateTime.parse(map['lastUpdated'] as String),
    );
  }
}