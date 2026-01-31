// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroceryOCRState {
  /// Whether OCR is currently processing
  bool get isScanning => throw _privateConstructorUsedError;

  /// Raw text extracted from OCR (kept for fallback/manual editing)
  String? get extractedRawText => throw _privateConstructorUsedError;

  /// Parsed grocery items from OCR
  List<GroceryItem> get scannedItems => throw _privateConstructorUsedError;

  /// Error message to display to user (recoverable errors)
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Whether the OCR completed but found no items
  /// This is different from an error - the scan worked but parsing failed
  bool get noItemsDetected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroceryOCRStateCopyWith<GroceryOCRState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryOCRStateCopyWith<$Res> {
  factory $GroceryOCRStateCopyWith(
          GroceryOCRState value, $Res Function(GroceryOCRState) then) =
      _$GroceryOCRStateCopyWithImpl<$Res, GroceryOCRState>;
  @useResult
  $Res call(
      {bool isScanning,
      String? extractedRawText,
      List<GroceryItem> scannedItems,
      String? errorMessage,
      bool noItemsDetected});
}

/// @nodoc
class _$GroceryOCRStateCopyWithImpl<$Res, $Val extends GroceryOCRState>
    implements $GroceryOCRStateCopyWith<$Res> {
  _$GroceryOCRStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isScanning = null,
    Object? extractedRawText = freezed,
    Object? scannedItems = null,
    Object? errorMessage = freezed,
    Object? noItemsDetected = null,
  }) {
    return _then(_value.copyWith(
      isScanning: null == isScanning
          ? _value.isScanning
          : isScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      extractedRawText: freezed == extractedRawText
          ? _value.extractedRawText
          : extractedRawText // ignore: cast_nullable_to_non_nullable
              as String?,
      scannedItems: null == scannedItems
          ? _value.scannedItems
          : scannedItems // ignore: cast_nullable_to_non_nullable
              as List<GroceryItem>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noItemsDetected: null == noItemsDetected
          ? _value.noItemsDetected
          : noItemsDetected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroceryOCRStateImplCopyWith<$Res>
    implements $GroceryOCRStateCopyWith<$Res> {
  factory _$$GroceryOCRStateImplCopyWith(_$GroceryOCRStateImpl value,
          $Res Function(_$GroceryOCRStateImpl) then) =
      __$$GroceryOCRStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isScanning,
      String? extractedRawText,
      List<GroceryItem> scannedItems,
      String? errorMessage,
      bool noItemsDetected});
}

/// @nodoc
class __$$GroceryOCRStateImplCopyWithImpl<$Res>
    extends _$GroceryOCRStateCopyWithImpl<$Res, _$GroceryOCRStateImpl>
    implements _$$GroceryOCRStateImplCopyWith<$Res> {
  __$$GroceryOCRStateImplCopyWithImpl(
      _$GroceryOCRStateImpl _value, $Res Function(_$GroceryOCRStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isScanning = null,
    Object? extractedRawText = freezed,
    Object? scannedItems = null,
    Object? errorMessage = freezed,
    Object? noItemsDetected = null,
  }) {
    return _then(_$GroceryOCRStateImpl(
      isScanning: null == isScanning
          ? _value.isScanning
          : isScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      extractedRawText: freezed == extractedRawText
          ? _value.extractedRawText
          : extractedRawText // ignore: cast_nullable_to_non_nullable
              as String?,
      scannedItems: null == scannedItems
          ? _value._scannedItems
          : scannedItems // ignore: cast_nullable_to_non_nullable
              as List<GroceryItem>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noItemsDetected: null == noItemsDetected
          ? _value.noItemsDetected
          : noItemsDetected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GroceryOCRStateImpl implements _GroceryOCRState {
  const _$GroceryOCRStateImpl(
      {this.isScanning = false,
      this.extractedRawText,
      final List<GroceryItem> scannedItems = const [],
      this.errorMessage,
      this.noItemsDetected = false})
      : _scannedItems = scannedItems;

  /// Whether OCR is currently processing
  @override
  @JsonKey()
  final bool isScanning;

  /// Raw text extracted from OCR (kept for fallback/manual editing)
  @override
  final String? extractedRawText;

  /// Parsed grocery items from OCR
  final List<GroceryItem> _scannedItems;

  /// Parsed grocery items from OCR
  @override
  @JsonKey()
  List<GroceryItem> get scannedItems {
    if (_scannedItems is EqualUnmodifiableListView) return _scannedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scannedItems);
  }

  /// Error message to display to user (recoverable errors)
  @override
  final String? errorMessage;

  /// Whether the OCR completed but found no items
  /// This is different from an error - the scan worked but parsing failed
  @override
  @JsonKey()
  final bool noItemsDetected;

  @override
  String toString() {
    return 'GroceryOCRState(isScanning: $isScanning, extractedRawText: $extractedRawText, scannedItems: $scannedItems, errorMessage: $errorMessage, noItemsDetected: $noItemsDetected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryOCRStateImpl &&
            (identical(other.isScanning, isScanning) ||
                other.isScanning == isScanning) &&
            (identical(other.extractedRawText, extractedRawText) ||
                other.extractedRawText == extractedRawText) &&
            const DeepCollectionEquality()
                .equals(other._scannedItems, _scannedItems) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noItemsDetected, noItemsDetected) ||
                other.noItemsDetected == noItemsDetected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isScanning,
      extractedRawText,
      const DeepCollectionEquality().hash(_scannedItems),
      errorMessage,
      noItemsDetected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryOCRStateImplCopyWith<_$GroceryOCRStateImpl> get copyWith =>
      __$$GroceryOCRStateImplCopyWithImpl<_$GroceryOCRStateImpl>(
          this, _$identity);
}

abstract class _GroceryOCRState implements GroceryOCRState {
  const factory _GroceryOCRState(
      {final bool isScanning,
      final String? extractedRawText,
      final List<GroceryItem> scannedItems,
      final String? errorMessage,
      final bool noItemsDetected}) = _$GroceryOCRStateImpl;

  @override

  /// Whether OCR is currently processing
  bool get isScanning;
  @override

  /// Raw text extracted from OCR (kept for fallback/manual editing)
  String? get extractedRawText;
  @override

  /// Parsed grocery items from OCR
  List<GroceryItem> get scannedItems;
  @override

  /// Error message to display to user (recoverable errors)
  String? get errorMessage;
  @override

  /// Whether the OCR completed but found no items
  /// This is different from an error - the scan worked but parsing failed
  bool get noItemsDetected;
  @override
  @JsonKey(ignore: true)
  _$$GroceryOCRStateImplCopyWith<_$GroceryOCRStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
