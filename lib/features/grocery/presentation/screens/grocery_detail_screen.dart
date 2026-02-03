import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../expenses/domain/entities/expense_entity.dart';
import '../../core/grocery_theme.dart';

/// Grocery Expense Detail Screen
///
/// Displays detailed breakdown of grocery expenses including:
/// - Store name
/// - Itemized list with prices
/// - Total amount and item count
/// - Gracefully handles legacy expenses without metadata
class GroceryDetailScreen extends ConsumerWidget {
  final ExpenseEntity expense;

  const GroceryDetailScreen({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: 'en_IN',
      decimalDigits: 2,
    );

    // Extract grocery metadata
    final metadata = expense.metadata;
    final storeName = metadata?['storeName'] as String?;
    final items = (metadata?['items'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
    
    // Calculate derived values
    final itemCount = items.length;
    final hasMetadata = storeName != null || items.isNotEmpty;

    return Scaffold(
      appBar: GroceryTheme.getAppBar(context, 'Grocery Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with Summary
            _buildSummaryCard(storeName, itemCount, currencyFormat),
            
            const SizedBox(height: 24),
            
            // Items Section
            if (hasMetadata) ...[
              _buildItemsSection(items, currencyFormat),
              const SizedBox(height: 24),
            ] else ...[
              _buildLegacyFallback(currencyFormat),
              const SizedBox(height: 24),
            ],
            
            // Expense Metadata
            _buildExpenseMetadata(currencyFormat),
          ],
        ),
      ),
    );
  }

  /// Build summary card showing store, items count, and total
  Widget _buildSummaryCard(String? storeName, int itemCount, NumberFormat currencyFormat) {
    return Card(
      color: GroceryTheme.cardBackgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (storeName != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.store,
                    color: GroceryTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    storeName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: GroceryTheme.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Items', '$itemCount', Icons.shopping_basket),
                _buildStatItem(
                  'Total', 
                  currencyFormat.format(expense.amount), 
                  Icons.attach_money
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual stat item
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: GroceryTheme.primaryColor,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: GroceryTheme.primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: GroceryTheme.hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Build items section with list
  Widget _buildItemsSection(List<Map<String, dynamic>> items, NumberFormat currencyFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Purchased Items',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: GroceryTheme.textColor,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: GroceryTheme.primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.local_grocery_store,
                      color: GroceryTheme.primaryColor,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    items[i]['name'] as String? ?? 'Unknown Item',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    currencyFormat.format(
                      (items[i]['price'] as num?)?.toDouble() ?? 0.0,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: GroceryTheme.primaryColor,
                    ),
                  ),
                ),
                if (i < items.length - 1)
                  const Divider(height: 1, indent: 72),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Build fallback for legacy expenses without grocery metadata
  Widget _buildLegacyFallback(NumberFormat currencyFormat) {
    return Card(
      color: GroceryTheme.lightBackgroundColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: GroceryTheme.hintColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Detailed item information not available',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: GroceryTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'This expense was recorded before detailed grocery tracking was enabled.',
              style: TextStyle(
                fontSize: 14,
                color: GroceryTheme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: GroceryTheme.primaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.money,
                    color: GroceryTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Amount: ${currencyFormat.format(expense.amount)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GroceryTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build expense metadata section
  Widget _buildExpenseMetadata(NumberFormat currencyFormat) {
    final dateFormat = DateFormat('MMM d, yyyy \'at\' h:mm a');
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: GroceryTheme.textColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildMetadataRow('Category', expense.category, Icons.category),
            _buildMetadataRow(
              'Date', 
              dateFormat.format(expense.date), 
              Icons.calendar_today
            ),
            if (expense.note != null)
              _buildMetadataRow('Note', expense.note!, Icons.note),
            _buildMetadataRow(
              'Recorded', 
              dateFormat.format(expense.createdAt), 
              Icons.access_time
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual metadata row
  Widget _buildMetadataRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: GroceryTheme.hintColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: GroceryTheme.hintColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}