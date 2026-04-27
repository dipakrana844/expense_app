// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(processReceiptUseCase)
final processReceiptUseCaseProvider = ProcessReceiptUseCaseProvider._();

final class ProcessReceiptUseCaseProvider
    extends
        $FunctionalProvider<
          ProcessReceiptUseCase,
          ProcessReceiptUseCase,
          ProcessReceiptUseCase
        >
    with $Provider<ProcessReceiptUseCase> {
  ProcessReceiptUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'processReceiptUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$processReceiptUseCaseHash();

  @$internal
  @override
  $ProviderElement<ProcessReceiptUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProcessReceiptUseCase create(Ref ref) {
    return processReceiptUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProcessReceiptUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProcessReceiptUseCase>(value),
    );
  }
}

String _$processReceiptUseCaseHash() =>
    r'315d9646757175540073e5507a23ebeb3f54ad88';

/// OCR Provider with robust error handling and fallback strategies
///
/// Flow:
/// UI → Pick Image → Validate Image → Start OCR → Await processImage()
/// → Parse text → Update provider state → Navigate to review screen
///
/// NEVER blocks the user - always provides a recovery path

@ProviderFor(GroceryOCRNotifier)
final groceryOCRProvider = GroceryOCRNotifierProvider._();

/// OCR Provider with robust error handling and fallback strategies
///
/// Flow:
/// UI → Pick Image → Validate Image → Start OCR → Await processImage()
/// → Parse text → Update provider state → Navigate to review screen
///
/// NEVER blocks the user - always provides a recovery path
final class GroceryOCRNotifierProvider
    extends $NotifierProvider<GroceryOCRNotifier, GroceryOCRState> {
  /// OCR Provider with robust error handling and fallback strategies
  ///
  /// Flow:
  /// UI → Pick Image → Validate Image → Start OCR → Await processImage()
  /// → Parse text → Update provider state → Navigate to review screen
  ///
  /// NEVER blocks the user - always provides a recovery path
  GroceryOCRNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groceryOCRProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groceryOCRNotifierHash();

  @$internal
  @override
  GroceryOCRNotifier create() => GroceryOCRNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroceryOCRState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroceryOCRState>(value),
    );
  }
}

String _$groceryOCRNotifierHash() =>
    r'37dd6084c976b454984f0ea473b6a3c7bb9d8522';

/// OCR Provider with robust error handling and fallback strategies
///
/// Flow:
/// UI → Pick Image → Validate Image → Start OCR → Await processImage()
/// → Parse text → Update provider state → Navigate to review screen
///
/// NEVER blocks the user - always provides a recovery path

abstract class _$GroceryOCRNotifier extends $Notifier<GroceryOCRState> {
  GroceryOCRState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GroceryOCRState, GroceryOCRState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GroceryOCRState, GroceryOCRState>,
              GroceryOCRState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
