// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GroceryNotifier)
final groceryProvider = GroceryNotifierProvider._();

final class GroceryNotifierProvider
    extends $NotifierProvider<GroceryNotifier, GrocerySessionState> {
  GroceryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groceryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groceryNotifierHash();

  @$internal
  @override
  GroceryNotifier create() => GroceryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrocerySessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrocerySessionState>(value),
    );
  }
}

String _$groceryNotifierHash() => r'826674453b4e8934d560256d8c820f49fccdf7a5';

abstract class _$GroceryNotifier extends $Notifier<GrocerySessionState> {
  GrocerySessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GrocerySessionState, GrocerySessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GrocerySessionState, GrocerySessionState>,
              GrocerySessionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
