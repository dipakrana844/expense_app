import 'package:image_picker/image_picker.dart';
import '../entities/ocr_result.dart';

abstract class OCRRepository {
  Future<OCRResult> scanReceipt(XFile image);
}
