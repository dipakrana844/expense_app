// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ocrDataSource)
final ocrDataSourceProvider = OcrDataSourceProvider._();

final class OcrDataSourceProvider
    extends $FunctionalProvider<OCRDataSource, OCRDataSource, OCRDataSource>
    with $Provider<OCRDataSource> {
  OcrDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ocrDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ocrDataSourceHash();

  @$internal
  @override
  $ProviderElement<OCRDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OCRDataSource create(Ref ref) {
    return ocrDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OCRDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OCRDataSource>(value),
    );
  }
}

String _$ocrDataSourceHash() => r'd4c3ce4e8ad0be256ff66e7a28423a87f068963d';
