import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../grocery/domain/entities/grocery_item.dart';

part 'ocr_state.freezed.dart';

/// OCR State with mandatory fields for robust scanning
///
/// Key state properties:
/// - isScanning: Loading indicator during OCR process
/// - extractedRawText: Raw text from OCR (for fallback manual selection)
/// - scannedItems: Parsed grocery items from OCR text
/// - errorMessage: User-friendly error messages
@freezed
class GroceryOCRState with _$GroceryOCRState {
  const factory GroceryOCRState({
    /// Whether OCR is currently processing
    @Default(false) bool isScanning,

    /// Raw text extracted from OCR (kept for fallback/manual editing)
    String? extractedRawText,

    /// Parsed grocery items from OCR
    @Default([]) List<GroceryItem> scannedItems,

    /// Error message to display to user (recoverable errors)
    String? errorMessage,

    /// Whether the OCR completed but found no items
    /// This is different from an error - the scan worked but parsing failed
    @Default(false) bool noItemsDetected,
  }) = _GroceryOCRState;
}
