/// Enum representing the type of category.
/// Provides type safety and compile-time checking.
enum CategoryType {
  income,
  expense;

  /// Converts string to CategoryType (case-insensitive)
  static CategoryType fromString(String value) {
    return CategoryType.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid category type: $value'),
    );
  }

  /// Converts CategoryType to lowercase string
  String toLowerCaseString() => name.toLowerCase();

  /// Display name for UI
  String get displayName => name[0].toUpperCase() + name.substring(1);
}
