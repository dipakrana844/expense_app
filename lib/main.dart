import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_expense_tracker/core/router/app_router.dart';
import 'package:smart_expense_tracker/core/services/background_service.dart';
import 'package:smart_expense_tracker/core/theme/app_theme.dart';
import 'features/expenses/data/local/expense_local_data_source.dart';
import 'features/expenses/presentation/providers/expense_providers.dart';
import 'features/grocery/data/local/grocery_preferences_local_data_source.dart';
import 'features/grocery/presentation/providers/grocery_notifier.dart';
import 'features/settings/data/local/settings_local_data_source.dart';
import 'features/settings/presentation/providers/settings_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Background Service
  await BackgroundService.initialize();
  await BackgroundService.scheduleDailyJob();

  // Initialize Data Sources (Handles Hive initialization and adapters internally)
  final localDataSource = ExpenseLocalDataSource();
  await localDataSource.init();
  
  // Initialize Grocery Preferences Data Source
  final groceryPreferencesDataSource = GroceryPreferencesLocalDataSource();
  await groceryPreferencesDataSource.init();
  
  // Initialize Settings Data Source
  final settingsDataSource = SettingsLocalDataSource();
  await settingsDataSource.init();

  runApp(
    ProviderScope(
      overrides: [
        expenseLocalDataSourceProvider.overrideWithValue(localDataSource),
        groceryPreferencesDataSourceProvider.overrideWithValue(groceryPreferencesDataSource),
        settingsLocalDataSourceProvider.overrideWithValue(settingsDataSource),
      ],
      observers: const [LoggerObserver()],
      child: const SmartExpenseTrackerApp(),
    ),
  );
}

class LoggerObserver extends ProviderObserver {
  const LoggerObserver();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('State change in ${provider.name ?? provider.runtimeType}');
  }
}

class SmartExpenseTrackerApp extends ConsumerWidget {
  const SmartExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Smart Expense Tracker Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
