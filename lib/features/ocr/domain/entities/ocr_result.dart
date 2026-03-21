import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_result.freezed.dart';

@freezed
class OCRResult with _$OCRResult {
  const factory OCRResult({
    required String text,
    required bool success,
    String? errorMessage,
  }) = _OCRResult;

  factory OCRResult.success(String text) =>
      OCRResult(text: text, success: true);

  factory OCRResult.failure(String error) =>
      OCRResult(text: '', success: false, errorMessage: error);

  factory OCRResult.empty() => const OCRResult(
    text: '',
    success: true,
    errorMessage: 'No text detected in image',
  );
}
