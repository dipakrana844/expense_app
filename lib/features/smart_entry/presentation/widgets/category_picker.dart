import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/features/categories/presentation/providers/category_providers.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';

class CategoryPicker extends ConsumerWidget {
  final String transactionType; // 'income' or 'expense'
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;
  final Function() onAddCategoryPressed;

  const CategoryPicker({
    super.key,
    required this.transactionType,
    this.selectedCategory,
    required this.onCategoryChanged,
    required this.onAddCategoryPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesByTypeProvider(transactionType));

    return categoriesAsync.when(
      data: (categories) {
        final categoryNames = categories.map((c) => c.name).toList();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: [
                ...categoryNames.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(
                          IconData(
                            AppConstants.categoryIcons[category] ?? 0xe5cc,
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                // Add category option at the bottom
                DropdownMenuItem(
                  value: '__ADD_CATEGORY__',
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 20),
                      const SizedBox(width: 12),
                      const Text('Add Category'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == '__ADD_CATEGORY__') {
                  onAddCategoryPressed();
                } else {
                  onCategoryChanged(value);
                }
              },
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: LinearProgressIndicator(),
      ),
      error: (error, stack) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Error loading categories: $error'),
      ),
    );
  }
}