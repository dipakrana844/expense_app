import 'app_categories.dart';

class AppConstants {
  // Hive Boxes
  static const String expensesBoxName = 'expenses_box';
  static const String settingsBoxName = 'settings_box';
  static const String budgetBoxName = 'budget_box';
  static const String scheduledExpensesBoxName = 'scheduled_expenses_box';
  static const String insightsBoxName = 'insights_box';

  // Date Formats
  static const String displayDateFormat = 'MMM d, y';
  static const String groupingDateFormat = 'yyyy-MM-dd';
  static const String monthYearFormat = 'MMMM y';

  // Formatting & Limits
  // Formatting & Limits
  static const String currencySymbol = '₹';
  static const double maxExpenseAmount = 1000000.0;
  static const int maxNoteLength = 500;

  // Categories & Icons
  static const List<String> expenseCategories =
      AppCategories.defaultExpenseCategories;
  static const Map<String, int> categoryIcons = AppCategories.categoryIcons;
}
