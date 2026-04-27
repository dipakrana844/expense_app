import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/category_type.dart';

part 'category_entity.freezed.dart';

/// Domain entity representing a category.
/// Uses Freezed for immutability and value equality.
@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();

  const factory CategoryEntity({
    required String id,
    required String name,
    required CategoryType type,
    required int iconCodePoint,
    required int colorValue,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted, // For soft delete
  }) = _CategoryEntity;

  /// Returns true if this is an income category
  bool get isIncome => type == CategoryType.income;

  /// Returns true if this is an expense category
  bool get isExpense => type == CategoryType.expense;

  /// Returns the type as a lowercase string for backward compatibility
  String get typeString => type.toLowerCaseString();

  /// Returns the display name for the type
  String get typeDisplayName => type.displayName;

  /// Creates a copy with updated timestamp
  CategoryEntity withUpdatedTimestamp() {
    return copyWith(updatedAt: DateTime.now());
  }

  /// Creates a soft-deleted copy
  CategoryEntity withSoftDelete() {
    return copyWith(isDeleted: true, updatedAt: DateTime.now());
  }

  /// Creates a restored copy (undo soft delete)
  CategoryEntity withRestore() {
    return copyWith(isDeleted: false, updatedAt: DateTime.now());
  }
}
