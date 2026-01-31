// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quickExpenseSuccessHash() =>
    r'd9ad24f389757890d18438573898934a2b5e8e2a';

/// Provider to check if last save was successful
/// Useful for showing success feedback
///
/// Copied from [quickExpenseSuccess].
@ProviderFor(quickExpenseSuccess)
final quickExpenseSuccessProvider = AutoDisposeProvider<bool>.internal(
  quickExpenseSuccess,
  name: r'quickExpenseSuccessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickExpenseSuccessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuickExpenseSuccessRef = AutoDisposeProviderRef<bool>;
String _$quickExpenseNotifierHash() =>
    r'e0863005c6be7963cf66b1d8d42eea51b8096169';

/// Provider for quick expense functionality
///
/// Manages quick expense state and integrates with the existing
/// expense repository for persistence.
///
/// Copied from [QuickExpenseNotifier].
@ProviderFor(QuickExpenseNotifier)
final quickExpenseNotifierProvider = AutoDisposeNotifierProvider<
    QuickExpenseNotifier, QuickExpenseState>.internal(
  QuickExpenseNotifier.new,
  name: r'quickExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quickExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuickExpenseNotifier = AutoDisposeNotifier<QuickExpenseState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
