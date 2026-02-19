import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();

  const factory CategoryEntity({
    required String id,
    required String name,
    required String type, // 'income' or 'expense'
    required int iconCodePoint,
    required int colorValue,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isDeleted, // For soft delete
  }) = _CategoryEntity;

  bool get isIncome => type.toLowerCase() == 'income';
  bool get isExpense => type.toLowerCase() == 'expense';
}