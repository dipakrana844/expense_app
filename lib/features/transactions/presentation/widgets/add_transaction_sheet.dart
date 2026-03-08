import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget: AddTransactionSheet
///
/// Bottom sheet that presents the user with options to add a new
/// transaction — either via Smart Entry (with optional OCR) or via
/// a Grocery session. Extracted from TransactionsPage to keep the
/// screen's build() method lean and the sheet independently testable.
class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              title: const Text('Smart Entry'),
              subtitle: const Text('Add via smart form or OCR'),
              onTap: () {
                Navigator.pop(context);
                context.push('/smart-entry');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              title: const Text('Add Grocery'),
              subtitle: const Text('Track items in a grocery session'),
              onTap: () {
                Navigator.pop(context);
                context.push('/grocery/add');
              },
            ),
          ],
        ),
      ),
    );
  }
}
