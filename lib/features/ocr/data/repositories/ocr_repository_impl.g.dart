// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ocrRepository)
final ocrRepositoryProvider = OcrRepositoryProvider._();

final class OcrRepositoryProvider
    extends $FunctionalProvider<OCRRepository, OCRRepository, OCRRepository>
    with $Provider<OCRRepository> {
  OcrRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ocrRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ocrRepositoryHash();

  @$internal
  @override
  $ProviderElement<OCRRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OCRRepository create(Ref ref) {
    return ocrRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OCRRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OCRRepository>(value),
    );
  }
}

String _$ocrRepositoryHash() => r'b119a648c8a3709d0817164df1d7fce9d8d3d198';
