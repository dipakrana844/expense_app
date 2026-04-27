import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/process_receipt_usecase.dart';
import '../../domain/usecases/scan_receipt_usecase.dart';
import '../../data/repositories/ocr_repository_impl.dart';
import '../../../grocery/domain/entities/grocery_item.dart';
import 'ocr_state.dart';

part 'ocr_provider.g.dart';

@riverpod
ProcessReceiptUseCase processReceiptUseCase(Ref ref) {
  return ProcessReceiptUseCase(
    ref.watch(ocrRepositoryProvider),
    ref.watch(scanReceiptUseCaseProvider),
  );
}

/// OCR Provider with robust error handling and fallback strategies
///
/// Flow:
/// UI → Pick Image → Validate Image → Start OCR → Await processImage()
/// → Parse text → Update provider state → Navigate to review screen
///
/// NEVER blocks the user - always provides a recovery path
@riverpod
class GroceryOCRNotifier extends _$GroceryOCRNotifier {
  @override
  GroceryOCRState build() {
    return const GroceryOCRState();
  }

  /// Pick image and perform OCR scanning
  ///
  /// This method:
  /// 1. Picks image from camera/gallery
  /// 2. Validates the image file
  /// 3. Performs OCR with proper error handling
  /// 4. Parses extracted text into grocery items
  /// 5. Always reaches completion (never hangs)
  Future<void> pickAndScanImage(ImageSource source) async {
    // Reset state but don't start loading yet (image picker handles its own UI)
    state = state.copyWith(errorMessage: null, noItemsDetected: false);

    try {
      // Step 1: Pick Image (UI handled by image_picker natively)
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: source,
        imageQuality: 85, // Good balance of quality and size
      );

      // Step 2: Handle user cancellation
      if (image == null) {
        // User cancelled - this is NOT an error, just return
        return;
      }

      // Step 3: Start loading state AFTER image is picked
      state = state.copyWith(isScanning: true);

      // Step 4: Perform OCR and Parse via UseCase
      final useCase = ref.read(processReceiptUseCaseProvider);
      final result = await useCase.execute(image);
      final ocrResult = result.ocrResult;
      final items = result.items;

      // Step 5: Handle OCR failure
      if (!ocrResult.success) {
        state = state.copyWith(
          isScanning: false,
          errorMessage: ocrResult.errorMessage ?? 'Failed to scan receipt',
        );
        return;
      }

      // Step 6: Handle empty results
      if (items.isEmpty) {
        state = state.copyWith(
          isScanning: false,
          extractedRawText: ocrResult.text,
          errorMessage: ocrResult.text.isEmpty
              ? 'No text detected in the image.'
              : 'Could not parse items automatically. You can add them manually.',
          noItemsDetected: true,
        );
      } else {
        // Step 7: Success! update state with results
        state = state.copyWith(
          isScanning: false,
          extractedRawText: ocrResult.text,
          scannedItems: items,
        );
      }
    } catch (e) {
      // Step 8: Handle unexpected errors
      state = state.copyWith(
        isScanning: false,
        errorMessage: 'Unexpected error: ${e.toString()}. Please try again.',
      );
    }
  }

  /// Update a scanned item (e.g., edit name or price)
  void updateItem(GroceryItem updatedItem) {
    state = state.copyWith(
      scannedItems: state.scannedItems.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList(),
    );
  }

  /// Remove a scanned item from the list
  void removeItem(String id) {
    state = state.copyWith(
      scannedItems: state.scannedItems.where((item) => item.id != id).toList(),
    );
  }

  /// Add a manually entered item
  void addItem(GroceryItem item) {
    state = state.copyWith(
      scannedItems: [...state.scannedItems, item],
      noItemsDetected: false,
    );
  }

  /// Clear OCR state completely
  /// Call this when:
  /// - User confirms items
  /// - User cancels the flow
  /// - User wants to scan again
  void clear() {
    state = const GroceryOCRState();
  }

  /// Clear only the error state (for retry)
  void clearError() {
    state = state.copyWith(errorMessage: null, noItemsDetected: false);
  }
}
