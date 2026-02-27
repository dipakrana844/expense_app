// import 'package:flutter/material.dart' hide DateUtils;
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/utils/utils.dart';
// import '../../../categories/presentation/providers/category_providers.dart';
// import '../providers/expense_providers.dart';

// /// Add/Edit Expense Screen
// ///
// /// Handles both creating new expenses and editing existing ones
// /// Single screen for both operations (KISS principle)
// class AddEditExpenseScreen extends ConsumerStatefulWidget {
//   final String? expenseId;
//   final double? initialAmount;
//   final String? initialCategory;
//   final DateTime? initialDate;
//   final String? initialNote;
//   final Map<String, dynamic>? initialMetadata;

//   const AddEditExpenseScreen({
//     super.key,
//     this.expenseId,
//     this.initialAmount,
//     this.initialCategory,
//     this.initialDate,
//     this.initialNote,
//     this.initialMetadata,
//   });

//   bool get isEditing => expenseId != null;

//   @override
//   ConsumerState<AddEditExpenseScreen> createState() =>
//       _AddEditExpenseScreenState();
// }

// class _AddEditExpenseScreenState extends ConsumerState<AddEditExpenseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _noteController = TextEditingController();

//   String? _selectedCategory;
//   DateTime _selectedDate = DateTime.now();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize with provided values (for editing)
//     if (widget.initialAmount != null) {
//       _amountController.text = widget.initialAmount!.toStringAsFixed(2);
//     }
//     if (widget.initialCategory != null) {
//       final initialCategory = widget.initialCategory!.trim();
//       if (AppConstants.expenseCategories.contains(initialCategory)) {
//         _selectedCategory = initialCategory;
//       } else {
//         // Handle legacy/invalid categories by migrating them
//         switch (initialCategory) {
//           case 'Food':
//             _selectedCategory = 'Food & Dining';
//             break;
//           case 'Transport':
//             _selectedCategory = 'Transportation';
//             break;
//           case 'Health':
//             _selectedCategory = 'Healthcare';
//             break;
//           case 'Bills':
//             _selectedCategory = 'Bills & Utilities';
//             break;
//           default:
//             _selectedCategory = initialCategory;
//         }
//       }
//     }
//     if (widget.initialDate != null) {
//       _selectedDate = widget.initialDate!;
//     }
//     if (widget.initialNote != null) {
//       _noteController.text = widget.initialNote!;
//     }
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       helpText: 'Select expense date',
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   Future<void> _saveExpense() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (_selectedCategory == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please select a category')));
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final amount = double.parse(_amountController.text);
//       final note = _noteController.text.trim().isEmpty
//           ? null
//           : _noteController.text.trim();

//       final notifier = ref.read(expensesProvider.notifier);

//       if (widget.isEditing) {
//         // Update existing expense
//         await notifier.updateExpense(
//           id: widget.expenseId!,
//           amount: amount,
//           category: _selectedCategory!,
//           date: _selectedDate,
//           note: note,
//         );
//       } else {
//         // Create new expense
//         await notifier.addExpense(
//           amount: amount,
//           category: _selectedCategory!,
//           date: _selectedDate,
//           note: note,
//         );
//       }

//       if (mounted) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               widget.isEditing
//                   ? 'Expense updated successfully'
//                   : 'Expense added successfully',
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: ${e.toString()}'),
//             backgroundColor: Theme.of(context).colorScheme.error,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categoriesAsync = ref.watch(categoriesByTypeProvider('expense'));
//     final customCategories = categoriesAsync.maybeWhen(
//       data: (categories) => categories.map((c) => c.name.trim()).toList(),
//       orElse: () => const <String>[],
//     );
//     final categoryOptions = <String>{
//       ...AppConstants.expenseCategories,
//       ...customCategories,
//       if (_selectedCategory != null) _selectedCategory!,
//     }.where((name) => name.isNotEmpty).toList();
//     final selectedValue =
//         _selectedCategory != null && categoryOptions.contains(_selectedCategory)
//         ? _selectedCategory
//         : null;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.isEditing ? 'Edit Expense' : 'Add Expense'),
//         actions: [
//           if (_isLoading)
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // Amount Field
//             TextFormField(
//               controller: _amountController,
//               decoration: InputDecoration(
//                 labelText: 'Amount',
//                 prefixText: AppConstants.currencySymbol,
//                 border: const OutlineInputBorder(),
//                 filled: true,
//               ),
//               keyboardType: const TextInputType.numberWithOptions(
//                 decimal: true,
//               ),
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//               ],
//               validator: ValidationUtils.validateAmount,
//               autofocus: !widget.isEditing,
//             ),
//             const SizedBox(height: 16),

//             // Category Dropdown
//             DropdownButtonFormField<String>(
//               value: selectedValue,
//               decoration: const InputDecoration(
//                 labelText: 'Category',
//                 border: OutlineInputBorder(),
//                 filled: true,
//               ),
//               items: categoryOptions.map((category) {
//                 return DropdownMenuItem(
//                   value: category,
//                   child: Row(
//                     children: [
//                       Icon(
//                         IconData(
//                           AppConstants.categoryIcons[category] ?? 0xe5cc,
//                           fontFamily: 'MaterialIcons',
//                         ),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 12),
//                       Text(category),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCategory = value;
//                 });
//               },
//               validator: ValidationUtils.validateCategory,
//             ),
//             const SizedBox(height: 16),

//             // Date Picker
//             InkWell(
//               onTap: _selectDate,
//               borderRadius: BorderRadius.circular(4),
//               child: InputDecorator(
//                 decoration: const InputDecoration(
//                   labelText: 'Date',
//                   border: OutlineInputBorder(),
//                   filled: true,
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 child: Text(
//                   DateUtils.formatDate(_selectedDate),
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Note Field (Optional)
//             TextFormField(
//               controller: _noteController,
//               decoration: const InputDecoration(
//                 labelText: 'Note (Optional)',
//                 border: OutlineInputBorder(),
//                 filled: true,
//                 hintText: 'Add a note about this expense',
//               ),
//               maxLines: 3,
//               maxLength: AppConstants.maxNoteLength,
//               validator: ValidationUtils.validateNote,
//             ),
//             const SizedBox(height: 16),

//             if (widget.initialMetadata != null &&
//                 widget.initialMetadata!['items'] != null) ...[
//               const Text(
//                 'Grocery Items',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               const SizedBox(height: 8),
//               ...((widget.initialMetadata!['items'] as List).map((e) {
//                 final item = e as Map<String, dynamic>; // assuming Map
//                 // Depending on generic, might be casting issue if from JSON decode
//                 return Card(
//                   child: ListTile(
//                     dense: true,
//                     title: Text(item['name'] ?? 'Unknown'),
//                     trailing: Text('₹${item['price']}'),
//                   ),
//                 );
//               })),
//               const SizedBox(height: 16),
//             ],

//             // Save Button
//             FilledButton.icon(
//               onPressed: _isLoading ? null : _saveExpense,
//               icon: Icon(widget.isEditing ? Icons.save : Icons.add),
//               label: Text(widget.isEditing ? 'Update Expense' : 'Add Expense'),
//               style: FilledButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
