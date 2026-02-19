import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/category_entity.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
@HiveType(typeId: 14) // Assign a new unique typeId
class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String type, // 'income' or 'expense'
    @HiveField(3) required int iconCodePoint,
    @HiveField(4) required int colorValue,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default(false) bool isDeleted, // For soft delete
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  // Convert from entity
  factory CategoryModel.fromEntity(CategoryEntity entity) => CategoryModel(
        id: entity.id,
        name: entity.name,
        type: entity.type,
        iconCodePoint: entity.iconCodePoint,
        colorValue: entity.colorValue,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        isDeleted: entity.isDeleted,
      );

  // Convert to entity
  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        type: type,
        iconCodePoint: iconCodePoint,
        colorValue: colorValue,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isDeleted: isDeleted,
      );
}
