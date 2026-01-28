import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _storeNameController.dispose();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groceryNotifierProvider);
    final currencyFormat = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(title: const Text('New Grocery Session')),
      body: Column(
        children: [
          // 1. Store Details & Add Item Form
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                            decoration: const InputDecoration(
                              labelText: 'Item Name',
                            ),
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
                            decoration: const InputDecoration(
                              labelText: 'Price',
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Required';
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
            ),
          ),

          // 2. Item List
          Expanded(
            child: state.items.isEmpty
                ? Center(
                    child: Text(
                      'No items added yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: state.items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Dismissible(
                        key: ValueKey(item.id),
                        background: Container(
                          color: Theme.of(context).colorScheme.error,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ref
                              .read(groceryNotifierProvider.notifier)
                              .removeItem(item.id);
                        },
                        child: ListTile(
                          title: Text(item.name),
                          trailing: Text(
                            currencyFormat.format(item.price),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onTap: () => _showEditItemDialog(context, item),
                        ),
                      );
                    },
                  ),
          ),

          // 3. Total & Submit
          Container(
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
                        'Total Items: ${state.items.length}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'Total: ${currencyFormat.format(state.totalAmount)}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.items.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(groceryNotifierProvider.notifier)
                                      .submitSession();
                                  if (context.mounted) {
                                    context.pop(); // Go back to expense list
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Grocery session saved!'),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
                                }
                              },
                        child: state.isSubmitting
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              )
                            : const Text('Complete Purchase'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
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
}
