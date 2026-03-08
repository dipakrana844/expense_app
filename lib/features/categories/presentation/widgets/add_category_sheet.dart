import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_providers.dart';

/// Widget: AddCategorySheet
///
/// Reusable bottom-sheet for adding a new category or income source.
/// Extracted from both smart_entry_page.dart and form_fields.dart to
/// eliminate duplication and keep those widgets focused on layout.
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   showDragHandle: true,
///   builder: (_) => AddCategorySheet(transactionType: 'expense'),
/// );
/// ```
class AddCategorySheet extends ConsumerStatefulWidget {
  /// 'income' or 'expense'
  final String transactionType;

  const AddCategorySheet({super.key, required this.transactionType});

  @override
  ConsumerState<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends ConsumerState<AddCategorySheet> {
  final _nameController = TextEditingController();
  static const int _defaultIconCodePoint = 0xe5cc;
  static const int _defaultColorValue = 0xFF2196F3;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _label =>
      widget.transactionType == 'income' ? 'Source' : 'Category';

  Future<void> _submit() async {
    final normalizedName = _nameController.text.trim();
    if (normalizedName.isEmpty) return;

    // Duplicate check
    final existingCategories = await ref
        .read(getCategoriesUseCaseProvider)
        .call(type: widget.transactionType);

    final alreadyExists = existingCategories.any(
      (c) => c.name.trim().toLowerCase() == normalizedName.toLowerCase(),
    );

    if (alreadyExists) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$_label already exists')));
      return;
    }

    await ref
        .read(categoryControllerProvider.notifier)
        .addCategory(
          name: normalizedName,
          type: widget.transactionType,
          iconCodePoint: _defaultIconCodePoint,
          colorValue: _defaultColorValue,
        );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New $_label',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: '$_label Name',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text('Add $_label'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
