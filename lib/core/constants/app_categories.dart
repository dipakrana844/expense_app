class AppCategories {
  const AppCategories._();

  static const String addCategoryActionValue = '__ADD_CATEGORY__';

  // Curated default categories for this app's primary expense use-cases.
  static const List<String> defaultExpenseCategories = [
    'Grocery',
    'Food & Dining',
    'Transportation',
    'Bills & Utilities',
    'Rent & Housing',
    'Healthcare',
    'Education',
    'Shopping',
    'Entertainment',
    'Travel',
    'Personal Care',
    'EMI & Loans',
    'Insurance',
    'Subscriptions',
    'Savings & Investment',
    'Gifts & Donations',
    'Others',
  ];

  static const Map<String, int> categoryIcons = {
    'Grocery': 0xe84f, // shopping_basket
    'Food & Dining': 0xe57f, // restaurant
    'Transportation': 0xe531, // directions_car
    'Bills & Utilities': 0xe1db, // receipt_long
    'Rent & Housing': 0xe88a, // home
    'Healthcare': 0xe3af, // local_hospital
    'Education': 0xe80c, // school
    'Shopping': 0xe59c, // shopping_bag
    'Entertainment': 0xe30a, // movie
    'Travel': 0xe539, // flight
    'Personal Care': 0xe4da, // spa
    'EMI & Loans': 0xe263, // account_balance
    'Insurance': 0xe8e8, // verified_user
    'Subscriptions': 0xe065, // subscriptions
    'Savings & Investment': 0xe227, // trending_up
    'Gifts & Donations': 0xe8f6, // card_giftcard
    'Others': 0xe5cc, // category
  };
}
