import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_expense_tracker/core/presentation/screens/main_layout.dart';
import 'package:smart_expense_tracker/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:smart_expense_tracker/features/budget/presentation/screens/budget_screen.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/screens/expense_list_screen.dart';
import 'package:smart_expense_tracker/features/expenses/presentation/screens/add_edit_expense_screen.dart';
import 'package:smart_expense_tracker/features/settings/presentation/screens/settings_screen.dart';
import 'package:smart_expense_tracker/features/grocery/presentation/screens/grocery_session_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorExpenseKey = GlobalKey<NavigatorState>(
  debugLabel: 'expense',
);
final _shellNavigatorAnalyticsKey = GlobalKey<NavigatorState>(
  debugLabel: 'analytics',
);
final _shellNavigatorBudgetKey = GlobalKey<NavigatorState>(
  debugLabel: 'budget',
);
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
  debugLabel: 'settings',
);

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/expenses',
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
                path: '/expenses',
                name: 'expenses',
                builder: (context, state) => const ExpenseListScreen(),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: 'add-expense',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const AddEditExpenseScreen(),
                  ),
                  GoRoute(
                    path: 'edit/:id',
                    name: 'edit-expense',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      final extras = state.extra as Map<String, dynamic>? ?? {};
                      return AddEditExpenseScreen(
                        expenseId: id,
                        initialAmount: extras['amount'] as double?,
                        initialCategory: extras['category'] as String?,
                        initialDate: extras['date'] as DateTime?,
                        initialNote: extras['note'] as String?,
                      );
                    },
                  ),
                ],
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
        builder: (context, state) => const GrocerySessionScreen(),
      ),
    ],
  );
});
