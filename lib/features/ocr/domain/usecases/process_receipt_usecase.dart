import 'package:image_picker/image_picker.dart';
import '../repositories/ocr_repository.dart';
import 'scan_receipt_usecase.dart';
import '../../../grocery/domain/entities/grocery_item.dart';
import '../entities/ocr_result.dart';

class ProcessReceiptUseCase {
  final OCRRepository _repository;
  final ScanReceiptUseCase _parser;

  ProcessReceiptUseCase(this._repository, this._parser);

  Future<OCRResultWithItems> execute(XFile image) async {
    // 1. Scan image
    final ocrResult = await _repository.scanReceipt(image);
    
    if (!ocrResult.success) {
      return OCRResultWithItems(
        ocrResult: ocrResult,
        items: [],
      );
    }

    // 2. Parse text
    final items = _parser.execute(ocrResult.text);

    return OCRResultWithItems(
      ocrResult: ocrResult,
      items: items,
    );
  }
}

class OCRResultWithItems {
  final OCRResult ocrResult;
  final List<GroceryItem> items;

  OCRResultWithItems({required this.ocrResult, required this.items});
}
