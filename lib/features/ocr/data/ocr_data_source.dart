import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ocr_data_source.g.dart';

/// Result class for OCR scanning
class OCRResult {
  final String text;
  final bool success;
  final String? errorMessage;

  const OCRResult({
    required this.text,
    required this.success,
    this.errorMessage,
  });

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

abstract class OCRDataSource {
  Future<OCRResult> scanReceipt(XFile image);
  Future<void> close();
}

/// Production implementation of OCR Data Source
///
/// Key fixes for ML Kit OCR:
/// 1. Creates new TextRecognizer for each scan to prevent stuck states
/// 2. Always closes TextRecognizer after use to prevent memory leaks
/// 3. Validates file exists before processing
/// 4. Proper error handling with detailed messages
class OCRDataSourceImpl implements OCRDataSource {
  @override
  Future<OCRResult> scanReceipt(XFile image) async {
    // Create a new TextRecognizer for each scan
    // This prevents stuck states and memory leaks
    TextRecognizer? textRecognizer;

    try {
      // Step 1: Validate file exists
      final file = File(image.path);
      if (!await file.exists()) {
        return OCRResult.failure('Image file not found: ${image.path}');
      }

      // Step 2: Validate file is not empty
      final fileSize = await file.length();
      if (fileSize == 0) {
        return OCRResult.failure('Image file is empty');
      }

      // Step 3: Create TextRecognizer for this scan
      textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

      // Step 4: Create InputImage from file path (best practice)
      final inputImage = InputImage.fromFilePath(image.path);

      // Step 5: Process image with timeout protection
      final recognizedText = await textRecognizer
          .processImage(inputImage)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw Exception('OCR processing timed out'),
          );

      // Step 6: Check if any text was detected
      if (recognizedText.text.isEmpty) {
        return OCRResult.empty();
      }

      return OCRResult.success(recognizedText.text);
    } on Exception catch (e) {
      return OCRResult.failure('OCR failed: ${e.toString()}');
    } finally {
      // Always close the TextRecognizer to free resources
      await textRecognizer?.close();
    }
  }

  @override
  Future<void> close() async {
    // No persistent resources to close in this implementation
    // Each scan creates and disposes its own TextRecognizer
  }
}

@riverpod
OCRDataSource ocrDataSource(Ref ref) {
  final source = OCRDataSourceImpl();
  ref.onDispose(() => source.close());
  return source;
}
