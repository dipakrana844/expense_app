import 'package:freezed_annotation/freezed_annotation.dart';

part 'quick_expense_state.freezed.dart';

/// State for Quick Expense bottom sheet
///
/// Manages the state of the quick expense addition flow
@freezed
class QuickExpenseState with _$QuickExpenseState {
  const factory QuickExpenseState({
    /// Current amount input
    @Default('') String amount,

    /// Selected category
    @Default('Grocery') String category,

    /// Optional note
    @Default('') String note,

    /// Whether the expense is being saved
    @Default(false) bool isSaving,

    /// Success flag for dismissing sheet
    @Default(false) bool isSuccess,

    /// Error message if save fails
    String? errorMessage,

    /// Last used category (for smart defaults)
    String? lastUsedCategory,
  }) = _QuickExpenseState;
}
