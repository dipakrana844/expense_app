import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../grocery/domain/entities/grocery_item.dart';

part 'scan_receipt_usecase.g.dart';

class ScanReceiptUseCase {
  List<GroceryItem> execute(String text) {
    final lines = text.split('\n');
    final items = <GroceryItem>[];

    // Regex to find price-like numbers (e.g., 40, 55.00, 120)
    // Supports optional currency symbol
    // Captures the numeric part
    final priceRegex = RegExp(r'(?:[₹$€£]\s?)?(\d+(?:\.\d{1,2})?)');

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      // Find all matches
      final matches = priceRegex.allMatches(line);
      if (matches.isEmpty) continue;

      // Heuristic: The price is usually the *last* number on the line
      // e.g. "Milk 2 x 20.00" (Total 40.00) or just "Milk 40"
      final lastMatch = matches.last;

      // Extract price string
      String priceString = lastMatch.group(1)!;
      double? price = double.tryParse(priceString);

      if (price == null || price <= 0) continue;

      // Extract Name
      // Everything before the price match start index
      String name = line.substring(0, lastMatch.start).trim();

      // Cleanup name
      // Remove trailing hyphens or symbols often found before price "Bread - "
      name = name.replaceAll(RegExp(r'[-:]$'), '').trim();

      if (name.isEmpty) {
        // Fallback: If name empty (e.g. line was "₹120"), maybe name detection failed or unavailable
        // We might validly skip, or label "Unknown Item"
        // User requirement: "₹120" -> should be handled.
        name = "Item (${items.length + 1})";
      }

      // Add item
      items.add(GroceryItem(id: const Uuid().v4(), name: name, price: price));
    }

    return items;
  }
}

@riverpod
ScanReceiptUseCase scanReceiptUseCase(Ref ref) {
  return ScanReceiptUseCase();
}
