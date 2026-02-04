import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/services/export_service.dart';
import 'package:smart_expense_tracker/core/services/security_service.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/providers/expense_providers.dart';
import '../providers/settings_providers.dart';
import '../widgets/setting_tiles.dart';
import '../../data/models/app_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsNotifierProvider);
    final settingsNotifier = ref.read(appSettingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
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
                items: const [
                  DropdownMenuItem(value: 'Grocery', child: Text('Grocery')),
                  DropdownMenuItem(
                    value: 'Food & Dining',
                    child: Text('Food & Dining'),
                  ),
                  DropdownMenuItem(
                    value: 'Transportation',
                    child: Text('Transportation'),
                  ),
                  DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
                  DropdownMenuItem(value: 'Others', child: Text('Others')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    settingsNotifier.updateSettings(
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
                  settingsNotifier.updateSettings(enableQuickExpense: value);
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

          // Grocery Settings Section
          const SettingSectionHeader(title: 'Grocery Settings'),
          SettingGroup(
            children: [
              SettingSwitchTile(
                title: 'Save Last Store',
                subtitle: 'Remember last used store name',
                icon: Icons.store,
                value: settings.saveLastStoreName,
                onChanged: (value) {
                  settingsNotifier.updateSettings(saveLastStoreName: value);
                },
              ),
              SettingSwitchTile(
                title: 'Item Suggestions',
                subtitle: 'Show frequently purchased items',
                icon: Icons.lightbulb,
                value: settings.showFrequentItemSuggestions,
                onChanged: (value) {
                  settingsNotifier.updateSettings(
                    showFrequentItemSuggestions: value,
                  );
                },
              ),
              SettingSwitchTile(
                title: 'Clear on Exit',
                subtitle: 'Clear grocery session when exiting app',
                icon: Icons.clear,
                value: settings.clearGrocerySessionOnExit,
                onChanged: (value) {
                  settingsNotifier.updateSettings(
                    clearGrocerySessionOnExit: value,
                  );
                },
              ),
              SettingSwitchTile(
                title: 'Confirm Submit',
                subtitle: 'Ask for confirmation before submitting',
                icon: Icons.check_circle,
                value: settings.confirmBeforeGrocerySubmit,
                onChanged: (value) {
                  settingsNotifier.updateSettings(
                    confirmBeforeGrocerySubmit: value,
                  );
                },
              ),
            ],
          ),

          // Smart Insights Section
          const SettingSectionHeader(title: 'Smart Insights'),
          SettingGroup(
            children: [
              SettingSwitchTile(
                title: 'AI Insights',
                subtitle: 'Enable spending intelligence analysis',
                icon: Icons.auto_graph,
                value: settings.enableSpendingIntelligence,
                onChanged: (value) {
                  settingsNotifier.updateSettings(
                    enableSpendingIntelligence: value,
                  );
                },
              ),
              SettingDropdownTile<InsightFrequency>(
                title: 'Insight Frequency',
                subtitle: 'How often to generate insights',
                icon: Icons.update,
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
                    settingsNotifier.updateSettings(insightFrequency: value);
                  }
                },
              ),
              SettingActionTile(
                title: 'Reset Insights Data',
                subtitle: 'Clear all collected insight data',
                icon: Icons.restart_alt,
                iconColor: Colors.red,
                onPressed: () =>
                    _showResetInsightsDialog(context, settingsNotifier),
              ),
            ],
          ),

          // Security Section
          const SettingSectionHeader(title: 'Security'),
          SettingGroup(
            children: [
              SettingSwitchTile(
                title: 'App Lock',
                subtitle: 'Require biometric authentication',
                icon: Icons.lock,
                value: settings.enableAppLock,
                onChanged: (value) {
                  if (value) {
                    _handleAppLockToggle(context, settingsNotifier, value);
                  } else {
                    settingsNotifier.updateSettings(enableAppLock: value);
                  }
                },
              ),
              SettingDropdownTile<AutoLockTimer>(
                title: 'Auto-Lock Timer',
                subtitle: 'Time before automatic lock',
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
                onChanged: settings.enableAppLock
                    ? (value) {
                        if (value != null) {
                          settingsNotifier.updateSettings(autoLockTimer: value);
                        }
                      }
                    : null,
              ),
              SettingSwitchTile(
                title: 'Auth on Launch',
                subtitle: 'Require authentication when opening app',
                icon: Icons.login,
                value: settings.requireAuthOnLaunch,
                onChanged: settings.enableAppLock
                    ? (value) {
                        settingsNotifier.updateSettings(requireAuthOnLaunch: value);
                      }
                    : null,
              ),
            ],
          ),

          // Data & Storage Section
          const SettingSectionHeader(title: 'Data & Storage'),
          SettingGroup(
            children: [
              SettingActionTile(
                title: 'Export Expenses',
                subtitle: 'Export all expenses as CSV file',
                icon: Icons.download,
                onPressed: () => _exportExpenses(context, ref),
              ),
              SettingInfoTile(
                title: 'Last Export',
                subtitle: settings.lastExportDate != null
                    ? 'Exported on ${_formatDate(settings.lastExportDate!)}'
                    : 'No exports yet',
                icon: Icons.history,
              ),
              SettingInfoTile(
                title: 'Storage Usage',
                subtitle: settings.storageUsageBytes != null
                    ? '${_formatBytes(settings.storageUsageBytes!)} used'
                    : 'Calculating...',
                icon: Icons.storage,
              ),
              SettingActionTile(
                title: 'Clear All Data',
                subtitle: 'Permanently delete all expenses and settings',
                icon: Icons.delete_forever,
                iconColor: Colors.red,
                onPressed: () => _showClearDataDialog(context, ref),
              ),
            ],
          ),

          // About Section
          const SettingSectionHeader(title: 'About'),
          SettingGroup(
            children: [
              const SettingInfoTile(
                title: 'App Version',
                value: '1.0.0 Pro',
                icon: Icons.info,
              ),
              SettingActionTile(
                title: 'Reset All Settings',
                subtitle: 'Restore all settings to default values',
                icon: Icons.settings_backup_restore,
                iconColor: Colors.orange,
                onPressed: () =>
                    _showResetSettingsDialog(context, settingsNotifier),
              ),
            ],
          ),

          // Debug Section (only in debug mode)
          if (kDebugMode) ...[
            const SettingSectionHeader(title: 'Debug'),
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
      ),
    );
  }

  // Helper Methods

  void _handleAppLockToggle(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
    bool value,
  ) {
    Future.microtask(() async {
      final success = await SecurityService().authenticate();
      if (success && context.mounted) {
        settingsNotifier.updateSettings(enableAppLock: value);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric authentication enabled')),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    });
  }

  Future<void> _exportExpenses(BuildContext context, WidgetRef ref) async {
    final expensesAsync = ref.read(expensesProvider);
    if (expensesAsync.hasValue && expensesAsync.value!.isNotEmpty) {
      try {
        await ExportService.exportExpensesToCSV(expensesAsync.value!);
        final settingsNotifier = ref.read(appSettingsNotifierProvider.notifier);
        await settingsNotifier.updateLastExportDate(DateTime.now());

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Expenses exported successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Export failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to export')),
        );
      }
    }
  }

  Future<void> _seedDummyData(BuildContext context, WidgetRef ref) async {
    try {
      final notifier = ref.read(expensesProvider.notifier);
      await notifier.seedDummyData();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dummy data added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add dummy data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showResetSettingsDialog(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Settings'),
        content: const Text(
          'This will restore all settings to their default values. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await settingsNotifier.resetToDefaults();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings reset to defaults'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all expenses, settings, and preferences. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              // TODO: Implement data clearing logic
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data clearing not yet implemented'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showResetInsightsDialog(
    BuildContext context,
    AppSettingsNotifier settingsNotifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Insights Data'),
        content: const Text(
          'This will clear all collected spending insight data. '
          'New insights will be generated from fresh data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              // TODO: Implement insights data reset
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Insights data reset not yet implemented'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
