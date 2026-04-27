import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/enums/category_type.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Data model for category persistence.
/// Uses Hive for local storage with type ID 14.
@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    required String id,
    required String name,
    required String type, // Stored as string for Hive compatibility
    required int iconCodePoint,
    required int colorValue,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted, // For soft delete
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Converts from domain entity to data model
  factory CategoryModel.fromEntity(CategoryEntity entity) => CategoryModel(
    id: entity.id,
    name: entity.name,
    type: entity.type.toLowerCaseString(),
    iconCodePoint: entity.iconCodePoint,
    colorValue: entity.colorValue,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    isDeleted: entity.isDeleted,
  );

  /// Converts to domain entity
  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    name: name,
    type: CategoryType.fromString(type),
    iconCodePoint: iconCodePoint,
    colorValue: colorValue,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isDeleted: isDeleted,
  );

  /// Creates a copy with updated timestamp
  CategoryModel withUpdatedTimestamp() {
    return copyWith(updatedAt: DateTime.now());
  }

  /// Creates a soft-deleted copy
  CategoryModel withSoftDelete() {
    return copyWith(isDeleted: true, updatedAt: DateTime.now());
  }

  /// Creates a restored copy (undo soft delete)
  CategoryModel withRestore() {
    return copyWith(isDeleted: false, updatedAt: DateTime.now());
  }
}
