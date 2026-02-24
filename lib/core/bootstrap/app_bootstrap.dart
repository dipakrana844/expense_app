import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../enums/environment.dart';
import '../../main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';
import '../../features/expenses/data/local/expense_local_data_source.dart';
import '../../features/income/data/local/income_local_data_source.dart';
import '../../features/grocery/data/local/grocery_preferences_local_data_source.dart';
import '../../features/settings/data/local/settings_local_data_source.dart';
import '../../features/daily_spend_guard/data/local/daily_spend_local_data_source.dart';
import '../../features/categories/data/datasource/category_local_data_source.dart';
import '../services/background_service.dart';
import '../../features/expenses/presentation/providers/expense_providers.dart';
import '../../features/income/presentation/providers/income_providers.dart';
import '../../features/grocery/presentation/providers/grocery_notifier.dart';
import '../../features/settings/presentation/providers/settings_providers.dart';
import '../../features/daily_spend_guard/presentation/providers/daily_spend_providers.dart';
import '../../features/categories/presentation/providers/category_providers.dart';

final appConfigProvider = Provider<AppConfig>((ref) => throw UnimplementedError('appConfigProvider must be overridden'));

Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.from(env);

  await setupDependencies(config);

  runApp(
    ProviderScope(
      overrides: [
        expenseLocalDataSourceProvider.overrideWithValue(_localDataSource),
        incomeLocalDataSourceProvider.overrideWithValue(_incomeDataSource),
        groceryPreferencesDataSourceProvider.overrideWithValue(
          _groceryPreferencesDataSource,
        ),
        settingsLocalDataSourceProvider.overrideWithValue(_settingsDataSource),
        dailySpendLocalDataSourceProvider.overrideWithValue(
          _dailySpendDataSource,
        ),
        categoryLocalDataSourceProvider.overrideWithValue(_categoryDataSource),
        appConfigProvider.overrideWithValue(config),
      ],
      observers: const [LoggerObserver()],
      child: MyApp(),
    ),
  );
}

// Store data source instances globally to be used in provider overrides
late ExpenseLocalDataSource _localDataSource;
late IncomeLocalDataSource _incomeDataSource;
late GroceryPreferencesLocalDataSource _groceryPreferencesDataSource;
late SettingsLocalDataSource _settingsDataSource;
late DailySpendLocalDataSource _dailySpendDataSource;
late CategoryLocalDataSource _categoryDataSource;

Future<void> setupDependencies(AppConfig config) async {
  // Initialize Background Service
  await BackgroundService.initialize();
  await BackgroundService.scheduleDailyJob();
  await BackgroundService.scheduleMidnightReset();

  // Initialize Data Sources (Handles Hive initialization and adapters internally)
  _localDataSource = ExpenseLocalDataSource();
  await _localDataSource.init();

  // Initialize Income Data Source
  _incomeDataSource = IncomeLocalDataSource();
  await _incomeDataSource.init();

  // Initialize Grocery Preferences Data Source
  _groceryPreferencesDataSource = GroceryPreferencesLocalDataSource();
  await _groceryPreferencesDataSource.init();

  // Initialize Settings Data Source
  _settingsDataSource = SettingsLocalDataSource();
  await _settingsDataSource.init();

  // Initialize Daily Spend Guard Data Source
  _dailySpendDataSource = DailySpendLocalDataSource();
  await _dailySpendDataSource.init();

  // Initialize Categories Data Source
  _categoryDataSource = CategoryLocalDataSource();
  await _categoryDataSource.init();

  // Open Budget Box
  await Hive.openBox(AppConstants.budgetBoxName);
}