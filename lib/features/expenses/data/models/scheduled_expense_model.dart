import 'package:hive_flutter/hive_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_expense_model.freezed.dart';
part 'scheduled_expense_model.g.dart';

@freezed
class ScheduledExpenseModel with _$ScheduledExpenseModel {
  @HiveType(typeId: 1, adapterName: 'ScheduledExpenseModelAdapter')
  factory ScheduledExpenseModel({
    @HiveField(0) required String id,
    @HiveField(1) required double amount,
    @HiveField(2) required String category,
    @HiveField(3) required int dayOfMonth, // e.g., 5th of every month
    @HiveField(4) required DateTime nextRunDate,
    @HiveField(5) String? note,
    @HiveField(6) @Default(true) bool isActive,
  }) = _ScheduledExpenseModel;

  const ScheduledExpenseModel._();
}
