// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroceryOCRState {

/// Whether OCR is currently processing
 bool get isScanning;/// Raw text extracted from OCR (kept for fallback/manual editing)
 String? get extractedRawText;/// Parsed grocery items from OCR
 List<GroceryItem> get scannedItems;/// Error message to display to user (recoverable errors)
 String? get errorMessage;/// Whether the OCR completed but found no items
/// This is different from an error - the scan worked but parsing failed
 bool get noItemsDetected;
/// Create a copy of GroceryOCRState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroceryOCRStateCopyWith<GroceryOCRState> get copyWith => _$GroceryOCRStateCopyWithImpl<GroceryOCRState>(this as GroceryOCRState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroceryOCRState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.extractedRawText, extractedRawText) || other.extractedRawText == extractedRawText)&&const DeepCollectionEquality().equals(other.scannedItems, scannedItems)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.noItemsDetected, noItemsDetected) || other.noItemsDetected == noItemsDetected));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,extractedRawText,const DeepCollectionEquality().hash(scannedItems),errorMessage,noItemsDetected);

@override
String toString() {
  return 'GroceryOCRState(isScanning: $isScanning, extractedRawText: $extractedRawText, scannedItems: $scannedItems, errorMessage: $errorMessage, noItemsDetected: $noItemsDetected)';
}


}

/// @nodoc
abstract mixin class $GroceryOCRStateCopyWith<$Res>  {
  factory $GroceryOCRStateCopyWith(GroceryOCRState value, $Res Function(GroceryOCRState) _then) = _$GroceryOCRStateCopyWithImpl;
@useResult
$Res call({
 bool isScanning, String? extractedRawText, List<GroceryItem> scannedItems, String? errorMessage, bool noItemsDetected
});




}
/// @nodoc
class _$GroceryOCRStateCopyWithImpl<$Res>
    implements $GroceryOCRStateCopyWith<$Res> {
  _$GroceryOCRStateCopyWithImpl(this._self, this._then);

  final GroceryOCRState _self;
  final $Res Function(GroceryOCRState) _then;

/// Create a copy of GroceryOCRState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isScanning = null,Object? extractedRawText = freezed,Object? scannedItems = null,Object? errorMessage = freezed,Object? noItemsDetected = null,}) {
  return _then(_self.copyWith(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,extractedRawText: freezed == extractedRawText ? _self.extractedRawText : extractedRawText // ignore: cast_nullable_to_non_nullable
as String?,scannedItems: null == scannedItems ? _self.scannedItems : scannedItems // ignore: cast_nullable_to_non_nullable
as List<GroceryItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,noItemsDetected: null == noItemsDetected ? _self.noItemsDetected : noItemsDetected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GroceryOCRState].
extension GroceryOCRStatePatterns on GroceryOCRState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroceryOCRState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroceryOCRState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroceryOCRState value)  $default,){
final _that = this;
switch (_that) {
case _GroceryOCRState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroceryOCRState value)?  $default,){
final _that = this;
switch (_that) {
case _GroceryOCRState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isScanning,  String? extractedRawText,  List<GroceryItem> scannedItems,  String? errorMessage,  bool noItemsDetected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroceryOCRState() when $default != null:
return $default(_that.isScanning,_that.extractedRawText,_that.scannedItems,_that.errorMessage,_that.noItemsDetected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isScanning,  String? extractedRawText,  List<GroceryItem> scannedItems,  String? errorMessage,  bool noItemsDetected)  $default,) {final _that = this;
switch (_that) {
case _GroceryOCRState():
return $default(_that.isScanning,_that.extractedRawText,_that.scannedItems,_that.errorMessage,_that.noItemsDetected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isScanning,  String? extractedRawText,  List<GroceryItem> scannedItems,  String? errorMessage,  bool noItemsDetected)?  $default,) {final _that = this;
switch (_that) {
case _GroceryOCRState() when $default != null:
return $default(_that.isScanning,_that.extractedRawText,_that.scannedItems,_that.errorMessage,_that.noItemsDetected);case _:
  return null;

}
}

}

/// @nodoc


class _GroceryOCRState implements GroceryOCRState {
  const _GroceryOCRState({this.isScanning = false, this.extractedRawText, final  List<GroceryItem> scannedItems = const [], this.errorMessage, this.noItemsDetected = false}): _scannedItems = scannedItems;
  

/// Whether OCR is currently processing
@override@JsonKey() final  bool isScanning;
/// Raw text extracted from OCR (kept for fallback/manual editing)
@override final  String? extractedRawText;
/// Parsed grocery items from OCR
 final  List<GroceryItem> _scannedItems;
/// Parsed grocery items from OCR
@override@JsonKey() List<GroceryItem> get scannedItems {
  if (_scannedItems is EqualUnmodifiableListView) return _scannedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scannedItems);
}

/// Error message to display to user (recoverable errors)
@override final  String? errorMessage;
/// Whether the OCR completed but found no items
/// This is different from an error - the scan worked but parsing failed
@override@JsonKey() final  bool noItemsDetected;

/// Create a copy of GroceryOCRState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroceryOCRStateCopyWith<_GroceryOCRState> get copyWith => __$GroceryOCRStateCopyWithImpl<_GroceryOCRState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroceryOCRState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.extractedRawText, extractedRawText) || other.extractedRawText == extractedRawText)&&const DeepCollectionEquality().equals(other._scannedItems, _scannedItems)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.noItemsDetected, noItemsDetected) || other.noItemsDetected == noItemsDetected));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,extractedRawText,const DeepCollectionEquality().hash(_scannedItems),errorMessage,noItemsDetected);

@override
String toString() {
  return 'GroceryOCRState(isScanning: $isScanning, extractedRawText: $extractedRawText, scannedItems: $scannedItems, errorMessage: $errorMessage, noItemsDetected: $noItemsDetected)';
}


}

/// @nodoc
abstract mixin class _$GroceryOCRStateCopyWith<$Res> implements $GroceryOCRStateCopyWith<$Res> {
  factory _$GroceryOCRStateCopyWith(_GroceryOCRState value, $Res Function(_GroceryOCRState) _then) = __$GroceryOCRStateCopyWithImpl;
@override @useResult
$Res call({
 bool isScanning, String? extractedRawText, List<GroceryItem> scannedItems, String? errorMessage, bool noItemsDetected
});




}
/// @nodoc
class __$GroceryOCRStateCopyWithImpl<$Res>
    implements _$GroceryOCRStateCopyWith<$Res> {
  __$GroceryOCRStateCopyWithImpl(this._self, this._then);

  final _GroceryOCRState _self;
  final $Res Function(_GroceryOCRState) _then;

/// Create a copy of GroceryOCRState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isScanning = null,Object? extractedRawText = freezed,Object? scannedItems = null,Object? errorMessage = freezed,Object? noItemsDetected = null,}) {
  return _then(_GroceryOCRState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,extractedRawText: freezed == extractedRawText ? _self.extractedRawText : extractedRawText // ignore: cast_nullable_to_non_nullable
as String?,scannedItems: null == scannedItems ? _self._scannedItems : scannedItems // ignore: cast_nullable_to_non_nullable
as List<GroceryItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,noItemsDetected: null == noItemsDetected ? _self.noItemsDetected : noItemsDetected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
