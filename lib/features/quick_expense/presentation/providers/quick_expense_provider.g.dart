// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for quick expense functionality
///
/// Manages quick expense state using clean architecture with
/// proper separation of concerns through use cases.

@ProviderFor(QuickExpenseNotifier)
final quickExpenseProvider = QuickExpenseNotifierProvider._();

/// Provider for quick expense functionality
///
/// Manages quick expense state using clean architecture with
/// proper separation of concerns through use cases.
final class QuickExpenseNotifierProvider
    extends $NotifierProvider<QuickExpenseNotifier, QuickExpenseState> {
  /// Provider for quick expense functionality
  ///
  /// Manages quick expense state using clean architecture with
  /// proper separation of concerns through use cases.
  QuickExpenseNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickExpenseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickExpenseNotifierHash();

  @$internal
  @override
  QuickExpenseNotifier create() => QuickExpenseNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuickExpenseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuickExpenseState>(value),
    );
  }
}

String _$quickExpenseNotifierHash() =>
    r'8277b00719af09856bb409bbfaa12b2c4a003ad2';

/// Provider for quick expense functionality
///
/// Manages quick expense state using clean architecture with
/// proper separation of concerns through use cases.

abstract class _$QuickExpenseNotifier extends $Notifier<QuickExpenseState> {
  QuickExpenseState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<QuickExpenseState, QuickExpenseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuickExpenseState, QuickExpenseState>,
              QuickExpenseState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider to check if last save was successful
/// Useful for showing success feedback

@ProviderFor(quickExpenseSuccess)
final quickExpenseSuccessProvider = QuickExpenseSuccessProvider._();

/// Provider to check if last save was successful
/// Useful for showing success feedback

final class QuickExpenseSuccessProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if last save was successful
  /// Useful for showing success feedback
  QuickExpenseSuccessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickExpenseSuccessProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickExpenseSuccessHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return quickExpenseSuccess(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$quickExpenseSuccessHash() =>
    r'd9ad24f389757890d18438573898934a2b5e8e2a';
