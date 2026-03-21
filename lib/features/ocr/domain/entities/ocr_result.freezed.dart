// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OCRResult {
  String get text => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OCRResultCopyWith<OCRResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OCRResultCopyWith<$Res> {
  factory $OCRResultCopyWith(OCRResult value, $Res Function(OCRResult) then) =
      _$OCRResultCopyWithImpl<$Res, OCRResult>;
  @useResult
  $Res call({String text, bool success, String? errorMessage});
}

/// @nodoc
class _$OCRResultCopyWithImpl<$Res, $Val extends OCRResult>
    implements $OCRResultCopyWith<$Res> {
  _$OCRResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? success = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OCRResultImplCopyWith<$Res>
    implements $OCRResultCopyWith<$Res> {
  factory _$$OCRResultImplCopyWith(
          _$OCRResultImpl value, $Res Function(_$OCRResultImpl) then) =
      __$$OCRResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool success, String? errorMessage});
}

/// @nodoc
class __$$OCRResultImplCopyWithImpl<$Res>
    extends _$OCRResultCopyWithImpl<$Res, _$OCRResultImpl>
    implements _$$OCRResultImplCopyWith<$Res> {
  __$$OCRResultImplCopyWithImpl(
      _$OCRResultImpl _value, $Res Function(_$OCRResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? success = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$OCRResultImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OCRResultImpl implements _OCRResult {
  const _$OCRResultImpl(
      {required this.text, required this.success, this.errorMessage});

  @override
  final String text;
  @override
  final bool success;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'OCRResult(text: $text, success: $success, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRResultImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, success, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRResultImplCopyWith<_$OCRResultImpl> get copyWith =>
      __$$OCRResultImplCopyWithImpl<_$OCRResultImpl>(this, _$identity);
}

abstract class _OCRResult implements OCRResult {
  const factory _OCRResult(
      {required final String text,
      required final bool success,
      final String? errorMessage}) = _$OCRResultImpl;

  @override
  String get text;
  @override
  bool get success;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$OCRResultImplCopyWith<_$OCRResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
