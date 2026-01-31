// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groceryOCRNotifierHash() =>
    r'158f661698dac3e166161550661512a06262f7ff';

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
