import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/enums/category_type.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Data model for category persistence.
/// Uses Hive for local storage with type ID 14.
@freezed
@HiveType(typeId: 14)
class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2)
    required String type, // Stored as string for Hive compatibility
    @HiveField(3) required int iconCodePoint,
    @HiveField(4) required int colorValue,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default(false) bool isDeleted, // For soft delete
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
