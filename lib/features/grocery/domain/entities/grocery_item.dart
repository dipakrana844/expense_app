import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery_item.freezed.dart';

@freezed
class GroceryItem with _$GroceryItem {
  const factory GroceryItem({
    required String id,
    required String name,
    required double price,
  }) = _GroceryItem;
}
