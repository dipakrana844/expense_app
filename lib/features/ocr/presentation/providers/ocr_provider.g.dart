// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$processReceiptUseCaseHash() =>
    r'315d9646757175540073e5507a23ebeb3f54ad88';

/// See also [processReceiptUseCase].
@ProviderFor(processReceiptUseCase)
final processReceiptUseCaseProvider =
    AutoDisposeProvider<ProcessReceiptUseCase>.internal(
  processReceiptUseCase,
  name: r'processReceiptUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$processReceiptUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProcessReceiptUseCaseRef
    = AutoDisposeProviderRef<ProcessReceiptUseCase>;
String _$groceryOCRNotifierHash() =>
    r'37dd6084c976b454984f0ea473b6a3c7bb9d8522';

/// OCR Provider with robust error handling and fallback strategies
///
/// Flow:
/// UI → Pick Image → Validate Image → Start OCR → Await processImage()
/// → Parse text → Update provider state → Navigate to review screen
///
/// NEVER blocks the user - always provides a recovery path
///
/// Copied from [GroceryOCRNotifier].
@ProviderFor(GroceryOCRNotifier)
final groceryOCRNotifierProvider =
    AutoDisposeNotifierProvider<GroceryOCRNotifier, GroceryOCRState>.internal(
  GroceryOCRNotifier.new,
  name: r'groceryOCRNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groceryOCRNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GroceryOCRNotifier = AutoDisposeNotifier<GroceryOCRState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
