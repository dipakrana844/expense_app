import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_expense_model.freezed.dart';

@freezed
abstract class ScheduledExpenseModel with _$ScheduledExpenseModel {
  factory ScheduledExpenseModel({
    required String id,
    required double amount,
    required String category,
    required int dayOfMonth, // e.g., 5th of every month
    required DateTime nextRunDate,
    String? note,
    @Default(true) bool isActive,
  }) = _ScheduledExpenseModel;

  const ScheduledExpenseModel._();
}
