import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_providers.dart';
import '../../domain/enums/category_type.dart';
import '../../domain/failures/category_failure.dart';

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
///   builder: (_) => AddCategorySheet(transactionType: CategoryType.expense),
/// );
/// ```
class AddCategorySheet extends ConsumerStatefulWidget {
  /// CategoryType.income or CategoryType.expense
  final CategoryType transactionType;

  const AddCategorySheet({super.key, required this.transactionType});

  @override
  ConsumerState<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends ConsumerState<AddCategorySheet> {
  final _nameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  static const int _defaultIconCodePoint = 0xe5cc;
  static const int _defaultColorValue = 0xFF2196F3;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _label =>
      widget.transactionType == CategoryType.income ? 'Source' : 'Category';

  Future<void> _submit() async {
    final normalizedName = _nameController.text.trim();
    if (normalizedName.isEmpty) {
      setState(() => _errorMessage = '$_label name cannot be empty');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check for duplicates using the use case
      final useCase = ref.read(getCategoriesUseCaseProvider);
      final result = await useCase.call(type: widget.transactionType);

      result.fold(
        onSuccess: (existingCategories) {
          final alreadyExists = existingCategories.any(
            (c) => c.name.trim().toLowerCase() == normalizedName.toLowerCase(),
          );

          if (alreadyExists) {
            setState(() {
              _errorMessage = '$_label already exists';
              _isLoading = false;
            });
            return;
          }

          // Add the category
          ref
              .read(categoryControllerProvider.notifier)
              .addCategory(
                name: normalizedName,
                type: widget.transactionType,
                iconCodePoint: _defaultIconCodePoint,
                colorValue: _defaultColorValue,
              );

          if (mounted) {
            Navigator.of(context).pop();
          }
        },
        onFailure: (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
        _isLoading = false;
      });
    }
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
              errorText: _errorMessage,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Add $_label'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
