import '../constants/app_constants.dart';

class SmartParser {
  static ({double? amount, String? categoryOrSource, String? note}) parse(String input) {
    if (input.trim().isEmpty) return (amount: null, categoryOrSource: null, note: null);

    final parts = input.split(RegExp(r'\s+'));
    double? amount;
    String? categoryOrSource;
    final List<String> remainingParts = [];

    for (final part in parts) {
      // Clean part for numerical check
      final cleanPart = part.replaceAll(RegExp(r'[^\d.]'), '');
      final parsedAmount = double.tryParse(cleanPart);
      
      if (parsedAmount != null && amount == null && cleanPart.isNotEmpty) {
        amount = parsedAmount;
      } else {
        remainingParts.add(part);
      }
    }

    if (remainingParts.isNotEmpty) {
      // Try exact or fuzzy match for categories
      final firstWord = remainingParts[0].toLowerCase();
      String? matchedCategory;
      
      for (final cat in AppConstants.expenseCategories) {
        if (cat.toLowerCase() == firstWord) {
          matchedCategory = cat;
          break;
        }
      }
      
      categoryOrSource = matchedCategory ?? remainingParts[0];
    }

    String? note = remainingParts.length > 1 ? remainingParts.sublist(1).join(' ') : null;

    return (amount: amount, categoryOrSource: categoryOrSource, note: note);
  }
}
