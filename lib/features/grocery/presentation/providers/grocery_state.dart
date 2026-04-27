import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/grocery_item.dart';

part 'grocery_state.freezed.dart';

enum GrocerySessionMode { create, edit }

@freezed
abstract class GrocerySessionState with _$GrocerySessionState {
  const GrocerySessionState._();

  const factory GrocerySessionState({
    @Default([]) List<GroceryItem> items,
    @Default(0.0) double totalAmount,
    @Default(false) bool isSubmitting,
    @Default('') String? storeName,
    @Default(GrocerySessionMode.create) GrocerySessionMode mode,
    String? expenseId,
  }) = _GrocerySessionState;
}
