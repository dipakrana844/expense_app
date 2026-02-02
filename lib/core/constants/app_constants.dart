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
  static const List<String> expenseCategories = [
    'Grocery',
    'Food & Dining',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Education',
    'Travel',
    'Personal Care',
    'Others',
  ];

  static const Map<String, int> categoryIcons = {
    'Grocery': 0xe84f, // shopping_basket
    'Food & Dining': 0xe57f,
    'Transportation': 0xe531,
    'Shopping': 0xe59c,
    'Entertainment': 0xe30a,
    'Bills & Utilities': 0xe1db,
    'Healthcare': 0xe3af,
    'Education': 0xe80c,
    'Travel': 0xe539,
    'Personal Care': 0xe4da,
    'Others': 0xe5cc,
  };
}
