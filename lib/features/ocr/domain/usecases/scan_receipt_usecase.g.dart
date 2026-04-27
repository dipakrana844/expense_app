// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_receipt_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanReceiptUseCase)
final scanReceiptUseCaseProvider = ScanReceiptUseCaseProvider._();

final class ScanReceiptUseCaseProvider
    extends
        $FunctionalProvider<
          ScanReceiptUseCase,
          ScanReceiptUseCase,
          ScanReceiptUseCase
        >
    with $Provider<ScanReceiptUseCase> {
  ScanReceiptUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanReceiptUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanReceiptUseCaseHash();

  @$internal
  @override
  $ProviderElement<ScanReceiptUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScanReceiptUseCase create(Ref ref) {
    return scanReceiptUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanReceiptUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanReceiptUseCase>(value),
    );
  }
}

String _$scanReceiptUseCaseHash() =>
    r'063bd3d87f7e153aa701438e14f2d0f615927e7f';
