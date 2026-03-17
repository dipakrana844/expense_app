import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/presentation/screens/main_layout.dart';
import 'package:smart_expense_tracker/features/accounts_overview/presentation/screens/accounts_overview_screen.dart';
import 'package:smart_expense_tracker/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:smart_expense_tracker/features/budget/presentation/screens/budget_screen.dart';
import 'package:smart_expense_tracker/features/grocery/presentation/pages/grocery_session_page.dart';
import 'package:smart_expense_tracker/features/income/presentation/screens/add_edit_income_screen.dart';
import 'package:smart_expense_tracker/features/ocr/presentation/screens/ocr_scan_screen.dart';
import 'package:smart_expense_tracker/features/settings/presentation/screens/settings_screen.dart';
import 'package:smart_expense_tracker/features/smart_entry/presentation/providers/smart_entry_controller.dart';
import 'package:smart_expense_tracker/features/smart_entry/presentation/pages/smart_entry_page.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/pages/transactions_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorExpenseKey = GlobalKey<NavigatorState>(
  debugLabel: 'expense',
);
final _shellNavigatorAnalyticsKey = GlobalKey<NavigatorState>(
  debugLabel: 'analytics',
);
final _shellNavigatorNetWorthKey = GlobalKey<NavigatorState>(
  debugLabel: 'networth',
);
// final _shellNavigatorIncomeKey = GlobalKey<NavigatorState>(
//   debugLabel: 'income',
// );
final _shellNavigatorBudgetKey = GlobalKey<NavigatorState>(
  debugLabel: 'budget',
);
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'settings',
);

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/transactions',
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // Branch Expenses
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExpenseKey,
            routes: [
              GoRoute(
                path: '/transactions',
                name: 'transactions',
                builder: (context, state) => const TransactionsPage(),
              ),
            ],
          ),

          // Branch Analytics
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAnalyticsKey,
            routes: [
              GoRoute(
                path: '/analytics',
                name: 'analytics',
                builder: (context, state) => const AnalyticsScreen(),
              ),
            ],
          ),

          // Branch Net Worth
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNetWorthKey,
            routes: [
              GoRoute(
                path: '/accounts-overview',
                name: 'accounts-overview',
                builder: (context, state) => const AccountsOverviewScreen(),
              ),
            ],
          ),


          // Branch Budget
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBudgetKey,
            routes: [
              GoRoute(
                path: '/budget',
                name: 'budget',
                builder: (context, state) => const BudgetScreen(),
              ),
            ],
          ),

          // Branch Settings
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // Grocery Session Route
      GoRoute(
        path: '/grocery/add',
        name: 'add-grocery',
        builder: (context, state) {
          final expenseId = state.extra as String?;
          return GrocerySessionPage(expenseId: expenseId);
        },
        routes: [
          GoRoute(
            path: 'ocr',
            name: 'grocery-ocr',
            builder: (context, state) => const OCRScanScreen(),
          ),
        ],
      ),
      // OCR Scan Route
      GoRoute(
        path: '/ocr/scan',
        name: 'ocr-scan',
        builder: (context, state) => const OCRScanScreen(),
      ),
      // Income Routes
      GoRoute(
        path: '/income/add',
        name: 'add-income',
        builder: (context, state) => const AddEditIncomeScreen(),
      ),
      GoRoute(
        path: '/income/edit/:id',
        name: 'edit-income',
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          // For simplicity, we'll pass the income data through extras
          // In a real app, you'd fetch the income by ID
          final extras = state.extra as Map<String, dynamic>? ?? {};
          return AddEditIncomeScreen(
            income: extras['income'] as dynamic, // Will need proper casting
          );
        },
      ),
      // Smart Entry Routes
      GoRoute(
        path: '/smart-entry',
        name: 'smart-entry',
        builder: (context, state) => const SmartEntryPage(),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'smart-entry-edit',
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>? ?? {};
              return SmartEntryPage(initialEditData: extras);
            },
          ),
          GoRoute(
            path: 'income',
            name: 'smart-entry-income',
            builder: (context, state) =>
                const SmartEntryPage(initialMode: TransactionMode.income),
          ),
          GoRoute(
            path: 'expense',
            name: 'smart-entry-expense',
            builder: (context, state) =>
                const SmartEntryPage(initialMode: TransactionMode.expense),
          ),
          GoRoute(
            path: 'transfer',
            name: 'smart-entry-transfer',
            builder: (context, state) =>
                const SmartEntryPage(initialMode: TransactionMode.transfer),
          ),
        ],
      ),
    ],
  );
});
