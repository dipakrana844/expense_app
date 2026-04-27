// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OCRResult {

 String get text; bool get success; String? get errorMessage;
/// Create a copy of OCRResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OCRResultCopyWith<OCRResult> get copyWith => _$OCRResultCopyWithImpl<OCRResult>(this as OCRResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OCRResult&&(identical(other.text, text) || other.text == text)&&(identical(other.success, success) || other.success == success)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,text,success,errorMessage);

@override
String toString() {
  return 'OCRResult(text: $text, success: $success, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $OCRResultCopyWith<$Res>  {
  factory $OCRResultCopyWith(OCRResult value, $Res Function(OCRResult) _then) = _$OCRResultCopyWithImpl;
@useResult
$Res call({
 String text, bool success, String? errorMessage
});




}
/// @nodoc
class _$OCRResultCopyWithImpl<$Res>
    implements $OCRResultCopyWith<$Res> {
  _$OCRResultCopyWithImpl(this._self, this._then);

  final OCRResult _self;
  final $Res Function(OCRResult) _then;

/// Create a copy of OCRResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? success = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OCRResult].
extension OCRResultPatterns on OCRResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OCRResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OCRResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OCRResult value)  $default,){
final _that = this;
switch (_that) {
case _OCRResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OCRResult value)?  $default,){
final _that = this;
switch (_that) {
case _OCRResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  bool success,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OCRResult() when $default != null:
return $default(_that.text,_that.success,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  bool success,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OCRResult():
return $default(_that.text,_that.success,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  bool success,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OCRResult() when $default != null:
return $default(_that.text,_that.success,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OCRResult implements OCRResult {
  const _OCRResult({required this.text, required this.success, this.errorMessage});
  

@override final  String text;
@override final  bool success;
@override final  String? errorMessage;

/// Create a copy of OCRResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OCRResultCopyWith<_OCRResult> get copyWith => __$OCRResultCopyWithImpl<_OCRResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OCRResult&&(identical(other.text, text) || other.text == text)&&(identical(other.success, success) || other.success == success)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,text,success,errorMessage);

@override
String toString() {
  return 'OCRResult(text: $text, success: $success, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OCRResultCopyWith<$Res> implements $OCRResultCopyWith<$Res> {
  factory _$OCRResultCopyWith(_OCRResult value, $Res Function(_OCRResult) _then) = __$OCRResultCopyWithImpl;
@override @useResult
$Res call({
 String text, bool success, String? errorMessage
});




}
/// @nodoc
class __$OCRResultCopyWithImpl<$Res>
    implements _$OCRResultCopyWith<$Res> {
  __$OCRResultCopyWithImpl(this._self, this._then);

  final _OCRResult _self;
  final $Res Function(_OCRResult) _then;

/// Create a copy of OCRResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? success = null,Object? errorMessage = freezed,}) {
  return _then(_OCRResult(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
