import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../providers/ocr_provider.dart';
import '../../../grocery/presentation/providers/grocery_notifier.dart';
import '../../../grocery/domain/entities/grocery_item.dart';

/// OCR Scan Screen with robust error handling and fallback
///
/// Key features:
/// - Never blocks the user
/// - Shows raw text on parse failure for manual editing
/// - Clear error messages with retry options
/// - Smooth loading states
class OCRScanScreen extends ConsumerWidget {
  const OCRScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groceryOCRNotifierProvider);
    final notifier = ref.read(groceryOCRNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Receipt'),
        actions: [
          if (state.scannedItems.isNotEmpty)
            TextButton(
              onPressed: () => _confirmItems(context, ref, state.scannedItems),
              child: const Text(
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: state.isScanning
          ? _buildLoadingState(context)
          : state.scannedItems.isEmpty
          ? _buildEmptyState(context, notifier, state)
          : _buildReviewList(context, ref, state.scannedItems),
    );
  }

  /// Loading state with proper visual feedback
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 24),
          Text(
            'Scanning receipt...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This may take a few seconds',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// Empty state with scan options and error handling
  Widget _buildEmptyState(
    BuildContext context,
    GroceryOCRNotifier notifier,
    state,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Error display
          if (state.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Show raw text if available for manual reference
            if (state.extractedRawText != null &&
                state.extractedRawText!.isNotEmpty) ...[
              ExpansionTile(
                title: const Text('View Detected Text'),
                subtitle: const Text('Tap to expand and view raw OCR text'),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SelectableText(
                      state.extractedRawText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ] else ...[
            const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              'Scan a receipt to automatically extract items and prices.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
          ],
          // Scan buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                context,
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () => notifier.pickAndScanImage(ImageSource.camera),
              ),
              _buildActionButton(
                context,
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () => notifier.pickAndScanImage(ImageSource.gallery),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Manual add option - ALWAYS available as fallback
          FilledButton.tonal(
            onPressed: () => _showManualAddDialog(context, notifier),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text('Add Item Manually'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewList(
    BuildContext context,
    WidgetRef ref,
    List<GroceryItem> items,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
          child: Row(
            children: [
              const Icon(Icons.info_outline, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Review detected items. Tap to edit.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(item.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(
                          locale: 'en_IN',
                          decimalDigits: 2,
                        ).format(item.price),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20),
                        onPressed: () {
                          ref
                              .read(groceryOCRNotifierProvider.notifier)
                              .removeItem(item.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () => _showEditDialog(context, ref, item),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () =>
                    ref.read(groceryOCRNotifierProvider.notifier).clear(),
                icon: const Icon(Icons.refresh),
                label: const Text('Scan Again'),
              ),
              FilledButton.icon(
                onPressed: () => _confirmItems(context, ref, items),
                icon: const Icon(Icons.check),
                label: const Text('Add All'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmItems(
    BuildContext context,
    WidgetRef ref,
    List<GroceryItem> items,
  ) {
    ref.read(groceryNotifierProvider.notifier).addItems(items);
    ref.read(groceryOCRNotifierProvider.notifier).clear();
    context.pop();
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, GroceryItem item) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? item.price;

              if (name.isNotEmpty && price > 0) {
                ref
                    .read(groceryOCRNotifierProvider.notifier)
                    .updateItem(item.copyWith(name: name, price: price));
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showManualAddDialog(BuildContext context, GroceryOCRNotifier notifier) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item Manually'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                hintText: 'e.g., Milk',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixText: '₹ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text);

              if (name.isNotEmpty && price != null && price > 0) {
                notifier.addItem(
                  GroceryItem(id: const Uuid().v4(), name: name, price: price),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
