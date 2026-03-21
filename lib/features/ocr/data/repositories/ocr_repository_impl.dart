import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/ocr_result.dart';
import '../../domain/repositories/ocr_repository.dart';
import '../ocr_data_source.dart';

part 'ocr_repository_impl.g.dart';

class OCRRepositoryImpl implements OCRRepository {
  final OCRDataSource _dataSource;

  OCRRepositoryImpl(this._dataSource);

  @override
  Future<OCRResult> scanReceipt(XFile image) async {
    return _dataSource.scanReceipt(image);
  }
}

@riverpod
OCRRepository ocrRepository(Ref ref) {
  return OCRRepositoryImpl(ref.watch(ocrDataSourceProvider));
}
