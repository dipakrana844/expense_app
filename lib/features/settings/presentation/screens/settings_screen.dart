import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/constants/app_categories.dart';
import 'package:smart_expense_tracker/core/constants/app_constants.dart';
import 'package:smart_expense_tracker/core/services/export_service.dart';
import 'package:smart_expense_tracker/core/services/security_service.dart';
import 'package:smart_expense_tracker/features/categories/presentation/providers/category_providers.dart';
import 'package:smart_expense_tracker/features/categories/domain/enums/category_type.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import '../providers/settings_providers.dart';
import '../widgets/setting_tiles.dart';
import '../../domain/entities/app_settings_entity.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Calculate storage usage when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recalculateStorageUsage();
    });
  }

  Future<void> _recalculateStorageUsage() async {
    // Check if already calculating to prevent duplicate calls
    if (ref.read(storageCalculationLoadingProvider)) return;

    // Set loading state
    ref.read(storageCalculationLoadingProvider.notifier).state = true;

    try {
      final settingsNotifier = ref.read(appSettingsNotifierProvider.notifier);
      await settingsNotifier.recalculateStorageUsage();
    } finally {
      // Reset loading state
      ref.read(storageCalculationLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsNotifierProvider);
    final settingsNotifier = ref.read(appSettingsNotifierProvider.notifier);
    final expenseCategoriesAsync = ref.watch(
      categoriesByTypeProvider(CategoryType.expense),
    );
    final dynamicCategories = expenseCategoriesAsync.maybeWhen(
      data: (categories) => categories.map((c) => c.name.trim()).toList(),
      orElse: () => const <String>[],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Failed to load settings: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => settingsNotifier.reload(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (settings) {
          final categoryOptions = <String>{
            ...AppConstants.expenseCategories,
            ...dynamicCategories,
            settings.defaultExpenseCategory,
          }.where((name) => name.isNotEmpty).toList();

          return ListView(
            children: [
              // Expense & Grocery Section
              const SettingSectionHeader(title: 'Expense & Grocery'),
              SettingGroup(
                children: [
                  SettingDropdownTile<String>(
                    title: 'Default Currency',
                    icon: Icons.currency_rupee,
                    value: settings.defaultCurrency,
                    items: const [
                      DropdownMenuItem(value: '₹', child: Text('Rupee (₹)')),
                      DropdownMenuItem(value: '\$', child: Text('Dollar (\$)')),
                      DropdownMenuItem(value: '€', child: Text('Euro (€)')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settingsNotifier.updateSettings(defaultCurrency: value);
                      }
                    },
                  ),
                  SettingDropdownTile<String>(
                    title: 'Default Category',
                    icon: Icons.category,
                    value: settings.defaultExpenseCategory,
                    items: [
                      ...categoryOptions.map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      ),
                      const DropdownMenuItem(
                        value: AppCategories.addCategoryActionValue,
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 18),
                            SizedBox(width: 8),
                            Text('Add Category'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) async {
                      if (value != null) {
                        if (value == AppCategories.addCategoryActionValue) {
                          await _showAddCategorySheet(
                            context,
                            settingsNotifier,
                          );
                          return;
                        }
                        await settingsNotifier.updateSettings(
                          defaultExpenseCategory: value,
                        );
                      }
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Quick Expense',
                    subtitle: 'Enable quick expense recording',
                    icon: Icons.flash_on,
                    value: settings.enableQuickExpense,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        enableQuickExpense: value,
                      );
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Grocery OCR',
                    subtitle: 'Enable receipt scanning for groceries',
                    icon: Icons.document_scanner,
                    value: settings.enableGroceryOCR,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(enableGroceryOCR: value);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Grocery Settings Section
              const SettingSectionHeader(title: 'Grocery Settings'),
              SettingGroup(
                children: [
                  SettingSwitchTile(
                    title: 'Save Store Name',
                    subtitle: 'Remember last used store name',
                    icon: Icons.store,
                    value: settings.saveLastStoreName,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(saveLastStoreName: value);
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Frequent Item Suggestions',
                    subtitle: 'Show suggestions based on history',
                    icon: Icons.history,
                    value: settings.showFrequentItemSuggestions,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        showFrequentItemSuggestions: value,
                      );
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Clear Session on Exit',
                    subtitle: 'Clear grocery items when leaving',
                    icon: Icons.exit_to_app,
                    value: settings.clearGrocerySessionOnExit,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        clearGrocerySessionOnExit: value,
                      );
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Confirm Before Submit',
                    subtitle: 'Show confirmation dialog before submitting',
                    icon: Icons.check_circle_outline,
                    value: settings.confirmBeforeGrocerySubmit,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        confirmBeforeGrocerySubmit: value,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Smart Insights Section
              const SettingSectionHeader(title: 'Smart Insights'),
              SettingGroup(
                children: [
                  SettingSwitchTile(
                    title: 'Spending Intelligence',
                    subtitle: 'Enable AI-powered spending insights',
                    icon: Icons.psychology,
                    value: settings.enableSpendingIntelligence,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        enableSpendingIntelligence: value,
                      );
                    },
                  ),
                  SettingDropdownTile<InsightFrequency>(
                    title: 'Insight Frequency',
                    icon: Icons.insights,
                    value: settings.insightFrequency,
                    items: const [
                      DropdownMenuItem(
                        value: InsightFrequency.daily,
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: InsightFrequency.weekly,
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: InsightFrequency.monthly,
                        child: Text('Monthly'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settingsNotifier.updateSettings(
                          insightFrequency: value,
                        );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Security Section
              const SettingSectionHeader(title: 'Security'),
              SettingGroup(
                children: [
                  SettingSwitchTile(
                    title: 'App Lock',
                    subtitle: 'Require authentication to open app',
                    icon: Icons.lock,
                    value: settings.enableAppLock,
                    isLoading: ref.watch(securitySettingsLoadingProvider),
                    onChanged: ref.watch(securitySettingsLoadingProvider)
                        ? null
                        : (value) {
                            _handleAppLockToggle(
                              context,
                              settingsNotifier,
                              value,
                            );
                          },
                  ),
                  SettingDropdownTile<AutoLockTimer>(
                    title: 'Auto Lock Timer',
                    icon: Icons.timer,
                    value: settings.autoLockTimer,
                    items: const [
                      DropdownMenuItem(
                        value: AutoLockTimer.immediate,
                        child: Text('Immediate'),
                      ),
                      DropdownMenuItem(
                        value: AutoLockTimer.thirtySeconds,
                        child: Text('30 Seconds'),
                      ),
                      DropdownMenuItem(
                        value: AutoLockTimer.oneMinute,
                        child: Text('1 Minute'),
                      ),
                      DropdownMenuItem(
                        value: AutoLockTimer.fiveMinutes,
                        child: Text('5 Minutes'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        settingsNotifier.updateSettings(autoLockTimer: value);
                      }
                    },
                  ),
                  SettingSwitchTile(
                    title: 'Require Auth on Launch',
                    subtitle: 'Authenticate when app starts',
                    icon: Icons.security,
                    value: settings.requireAuthOnLaunch,
                    onChanged: (value) {
                      settingsNotifier.updateSettings(
                        requireAuthOnLaunch: value,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Data & Storage Section
              const SettingSectionHeader(title: 'Data & Storage'),
              SettingGroup(
                children: [
                  SettingActionTile(
                    title: 'Export Data',
                    subtitle: settings.lastExportDate != null
                        ? 'Last exported: ${_formatDate(settings.lastExportDate!)}'
                        : 'Export all data to CSV',
                    icon: Icons.download,
                    iconColor: Colors.blue,
                    onPressed: () => _exportData(context, settingsNotifier),
                  ),
                  SettingActionTile(
                    title: 'Storage Usage',
                    subtitle: settings.storageUsageBytes != null
                        ? _formatBytes(settings.storageUsageBytes!)
                        : 'Tap to calculate',
                    icon: Icons.storage,
                    iconColor: Colors.purple,
                    isLoading: ref.watch(storageCalculationLoadingProvider),
                    onPressed: ref.watch(storageCalculationLoadingProvider)
                        ? null
                        : () => _recalculateStorageUsage(),
                  ),
                  SettingActionTile(
                    title: 'Reset All Settings',
                    subtitle: 'Restore default settings',
                    icon: Icons.restore,
                    iconColor: Colors.red,
                    onPressed: () =>
                        _showResetConfirmation(context, settingsNotifier),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Developer Section (only in debug mode)
              if (kDebugMode) ...[
                const SettingSectionHeader(title: 'Developer'),
                SettingGroup(
                  children: [
                    SettingActionTile(
                      title: 'Seed Dummy Data',
                      subtitle: 'Add sample expenses for testing',
                      icon: Icons.bug_report,
                      iconColor: Colors.orange,
                      onPressed: () => _seedDummyData(context, ref),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  // Helper Methods

  Future<void> _handleAppLockToggle(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
    bool value,
  ) async {
    // Set processing state to show loading indicator
    ref.read(securitySettingsLoadingProvider.notifier).state = true;

    try {
      // Check if biometric authentication is available
      final isAvailable = await SecurityService().isBiometricAvailable();

      if (!isAvailable) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Biometric authentication is not available on this device',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Perform authentication
      final success = await SecurityService().authenticate();

      if (success && context.mounted) {
        await settingsNotifier.updateSettings(enableAppLock: value);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometric authentication enabled successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else if (context.mounted) {
        // Show failure message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Authentication failed. App lock not enabled.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error enabling app lock: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Reset processing state
      ref.read(securitySettingsLoadingProvider.notifier).state = false;
    }
  }

  Future<void> _exportData(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
  ) async {
    try {
      // Get all expenses from the repository
      final expenseRepository = ref.read(expenseRepositoryProvider);
      final (expenses, failure) = await expenseRepository.getAllExpenses();

      if (failure != null || expenses == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to load expenses for export'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Export expenses to CSV
      await ExportService.exportExpensesToCSV(expenses);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data exported successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Update last export date
        await settingsNotifier.updateLastExportDate(DateTime.now());
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showResetConfirmation(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to defaults? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await settingsNotifier.resetToDefaults();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings reset to defaults'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _showAddCategorySheet(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
  ) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add New Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop(controller.text.trim());
                  }
                },
                child: const Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );

    if (result != null && context.mounted) {
      await settingsNotifier.updateSettings(defaultExpenseCategory: result);
    }
  }

  Future<void> _seedDummyData(BuildContext context, WidgetRef ref) async {
    // This would typically call a service to seed data
    // For now, just show a message
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dummy data seeding not implemented yet'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
