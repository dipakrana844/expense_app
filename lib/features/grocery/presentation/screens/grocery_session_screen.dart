import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/grocery_notifier.dart';
import '../providers/grocery_state.dart';
import '../../domain/entities/grocery_item.dart';
import '../../core/grocery_theme.dart';

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
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: 'en_IN',
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: GroceryTheme.getAppBar(context, 'New Grocery Session'),
      body: Column(
        children: [
          // Sticky Header - Store Info
          _buildStickyHeader(state),
          
          // Item List (Expanded)
          Expanded(
            child: _buildItemList(state, currencyFormat),
          ),
          
          // Sticky Footer - Total and Actions
          _buildStickyFooter(state, currencyFormat),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to OCR Scan
          context.pushNamed('grocery-ocr');
        },
        icon: const Icon(Icons.document_scanner_outlined),
        label: const Text('Scan Receipt'),
        backgroundColor: GroceryTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
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

  /// Build sticky header with store info and add item form
  Widget _buildStickyHeader(GrocerySessionState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GroceryTheme.cardBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: GroceryTheme.primaryColor.withOpacity(0.2),
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
              prefixIcon: Icon(Icons.store),
            ),
            onChanged: (value) {
              ref
                  .read(groceryNotifierProvider.notifier)
                  .updateStoreName(value);
            },
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _itemNameController,
                    focusNode: _itemNameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      hintText: 'e.g., Milk, Bread...',
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
                  flex: 1,
                  child: TextFormField(
                    controller: _itemPriceController,
                    focusNode: _itemPriceFocus,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      prefixText: '₹',
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
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: GroceryTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build item list with empty state
  Widget _buildItemList(GrocerySessionState state, NumberFormat currencyFormat) {
    if (state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: GroceryTheme.hintColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: GroceryTheme.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add items using the form above or scan a receipt',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: GroceryTheme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = state.items[index];
        return _buildGroceryItemTile(item, currencyFormat);
      },
    );
  }

  /// Build individual grocery item tile with swipe actions
  Widget _buildGroceryItemTile(GroceryItem item, NumberFormat currencyFormat) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        color: GroceryTheme.errorColor,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: GroceryTheme.warningColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Left to right - Edit
          _showEditItemDialog(context, item);
          return false; // Don't dismiss
        } else {
          // Right to left - Delete
          return await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Item'),
                  content: Text('Remove ${item.name} from your list?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ) ??
              false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // Delete action
          ref.read(groceryNotifierProvider.notifier).removeItem(item.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.name} removed'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  ref.read(groceryNotifierProvider.notifier).addItem(item.name, item.price);
                },
              ),
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 1,
        color: GroceryTheme.cardBackgroundColor,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: GroceryTheme.primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.local_grocery_store,
              color: GroceryTheme.primaryColor,
            ),
          ),
          title: Text(
            item.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: Text(
            currencyFormat.format(item.price),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: GroceryTheme.primaryColor,
            ),
          ),
          onTap: () => _showEditItemDialog(context, item),
        ),
      ),
    );
  }

  /// Build sticky footer with totals and submit button
  Widget _buildStickyFooter(GrocerySessionState state, NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items: ${state.items.length}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: GroceryTheme.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Total: ${currencyFormat.format(state.totalAmount)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: GroceryTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: (state.items.isEmpty || state.isSubmitting)
                    ? null
                    : () async {
                        try {
                          await ref
                              .read(groceryNotifierProvider.notifier)
                              .submitSession();
                          if (context.mounted) {
                            context.pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Grocery session saved!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: GroceryTheme.errorColor,
                              ),
                            );
                          }
                        }
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: GroceryTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: state.isSubmitting
                    ? const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      )
                    : const Text(
                        'Complete Purchase',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}