import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/utils/utils.dart';
import 'package:smart_expense_tracker/features/settings/presentation/providers/settings_providers.dart';
import '../providers/grocery_notifier.dart';
import '../providers/grocery_state.dart';
import '../../domain/entities/grocery_item.dart';

class GrocerySessionScreen extends ConsumerStatefulWidget {
  const GrocerySessionScreen({super.key});

  @override
  ConsumerState<GrocerySessionScreen> createState() =>
      _GrocerySessionScreenState();
}

class _GrocerySessionScreenState extends ConsumerState<GrocerySessionScreen> {
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _itemNameFocus = FocusNode();
  final _itemPriceFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize store name if not already set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(groceryNotifierProvider);
      if (state.storeName != null) {
        _storeNameController.text = state.storeName!;
      }
    });
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _storeNameController.dispose();
    _itemNameFocus.dispose();
    _itemPriceFocus.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_formKey.currentState!.validate()) {
      final name = _itemNameController.text;
      final price = double.tryParse(_itemPriceController.text) ?? 0.0;

      ref.read(groceryNotifierProvider.notifier).addItem(name, price);

      _itemNameController.clear();
      _itemPriceController.clear();

      // Keep focus on item name for rapid entry
      _itemNameFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groceryNotifierProvider);
    final settings = ref.watch(appSettingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Grocery Session')),
      body: Column(
        children: [
          // Sticky Header - Store Info
          _buildStickyHeader(state),

          // Item List (Expanded)
          Expanded(child: _buildItemList(state)),

          // Sticky Footer - Total and Actions
          _buildStickyFooter(state, settings.confirmBeforeGrocerySubmit),
        ],
      ),
      floatingActionButton: settings.enableGroceryOCR
          ? FloatingActionButton.extended(
              onPressed: () {
                context.pushNamed('grocery-ocr');
              },
              icon: const Icon(Icons.document_scanner_outlined),
              label: const Text('Scan Receipt'),
            )
          : null,
    );
  }

  void _showEditItemDialog(BuildContext context, GroceryItem item) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());
    final editFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Item'),
        content: Form(
          key: editFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (editFormKey.currentState!.validate()) {
                final newName = nameController.text;
                final newPrice = double.parse(priceController.text);

                ref
                    .read(groceryNotifierProvider.notifier)
                    .updateItem(item.id, newName, newPrice);

                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyHeader(GrocerySessionState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _storeNameController,
            decoration: const InputDecoration(
              labelText: 'Store Name (Optional)',
              prefixIcon: Icon(Icons.store_outlined),
            ),
            onChanged: (value) {
              ref.read(groceryNotifierProvider.notifier).updateStoreName(value);
            },
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _itemNameController,
                    focusNode: _itemNameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      hintText: 'Milk, Bread...',
                    ),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_itemPriceFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _itemPriceController,
                    focusNode: _itemPriceFocus,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      prefixText: '₹ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Invalid';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filled(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(GrocerySessionState state) {
    if (state.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your list is empty',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add items using the form above or scan a receipt to get started.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.4),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return _buildGroceryItemCard(item);
      },
    );
  }

  Widget _buildGroceryItemCard(GroceryItem item) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (direction) {
        final removedItem = item;
        ref.read(groceryNotifierProvider.notifier).removeItem(item.id);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${removedItem.name} removed'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                ref
                    .read(groceryNotifierProvider.notifier)
                    .addItem(removedItem.name, removedItem.price);
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => _showEditItemDialog(context, item),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Grocery Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),

                // Item Name
                Expanded(
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyUtils.formatAmount(item.price),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      onPressed: () => _showEditItemDialog(context, item),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStickyFooter(GrocerySessionState state, bool confirmRequired) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Items',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      '${state.items.length}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total Amount',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      CurrencyUtils.formatAmount(state.totalAmount),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: (state.items.isEmpty || state.isSubmitting)
                    ? null
                    : () => _handleCompletePurchase(confirmRequired),
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Complete Purchase',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCompletePurchase(bool confirmRequired) async {
    if (confirmRequired) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Complete Purchase'),
          content: const Text(
            'Are you sure you want to save this grocery session?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      if (confirm != true) return;
    }

    try {
      await ref.read(groceryNotifierProvider.notifier).submitSession();
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Grocery session saved successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
