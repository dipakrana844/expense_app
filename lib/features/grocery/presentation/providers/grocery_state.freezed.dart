// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GrocerySessionState {

 List<GroceryItem> get items; double get totalAmount; bool get isSubmitting; String? get storeName; GrocerySessionMode get mode; String? get expenseId;
/// Create a copy of GrocerySessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GrocerySessionStateCopyWith<GrocerySessionState> get copyWith => _$GrocerySessionStateCopyWithImpl<GrocerySessionState>(this as GrocerySessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GrocerySessionState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalAmount,isSubmitting,storeName,mode,expenseId);

@override
String toString() {
  return 'GrocerySessionState(items: $items, totalAmount: $totalAmount, isSubmitting: $isSubmitting, storeName: $storeName, mode: $mode, expenseId: $expenseId)';
}


}

/// @nodoc
abstract mixin class $GrocerySessionStateCopyWith<$Res>  {
  factory $GrocerySessionStateCopyWith(GrocerySessionState value, $Res Function(GrocerySessionState) _then) = _$GrocerySessionStateCopyWithImpl;
@useResult
$Res call({
 List<GroceryItem> items, double totalAmount, bool isSubmitting, String? storeName, GrocerySessionMode mode, String? expenseId
});




}
/// @nodoc
class _$GrocerySessionStateCopyWithImpl<$Res>
    implements $GrocerySessionStateCopyWith<$Res> {
  _$GrocerySessionStateCopyWithImpl(this._self, this._then);

  final GrocerySessionState _self;
  final $Res Function(GrocerySessionState) _then;

/// Create a copy of GrocerySessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalAmount = null,Object? isSubmitting = null,Object? storeName = freezed,Object? mode = null,Object? expenseId = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GroceryItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GrocerySessionMode,expenseId: freezed == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GrocerySessionState].
extension GrocerySessionStatePatterns on GrocerySessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GrocerySessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GrocerySessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GrocerySessionState value)  $default,){
final _that = this;
switch (_that) {
case _GrocerySessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GrocerySessionState value)?  $default,){
final _that = this;
switch (_that) {
case _GrocerySessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GroceryItem> items,  double totalAmount,  bool isSubmitting,  String? storeName,  GrocerySessionMode mode,  String? expenseId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GrocerySessionState() when $default != null:
return $default(_that.items,_that.totalAmount,_that.isSubmitting,_that.storeName,_that.mode,_that.expenseId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GroceryItem> items,  double totalAmount,  bool isSubmitting,  String? storeName,  GrocerySessionMode mode,  String? expenseId)  $default,) {final _that = this;
switch (_that) {
case _GrocerySessionState():
return $default(_that.items,_that.totalAmount,_that.isSubmitting,_that.storeName,_that.mode,_that.expenseId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GroceryItem> items,  double totalAmount,  bool isSubmitting,  String? storeName,  GrocerySessionMode mode,  String? expenseId)?  $default,) {final _that = this;
switch (_that) {
case _GrocerySessionState() when $default != null:
return $default(_that.items,_that.totalAmount,_that.isSubmitting,_that.storeName,_that.mode,_that.expenseId);case _:
  return null;

}
}

}

/// @nodoc


class _GrocerySessionState extends GrocerySessionState {
  const _GrocerySessionState({final  List<GroceryItem> items = const [], this.totalAmount = 0.0, this.isSubmitting = false, this.storeName = '', this.mode = GrocerySessionMode.create, this.expenseId}): _items = items,super._();
  

 final  List<GroceryItem> _items;
@override@JsonKey() List<GroceryItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  double totalAmount;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  String? storeName;
@override@JsonKey() final  GrocerySessionMode mode;
@override final  String? expenseId;

/// Create a copy of GrocerySessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GrocerySessionStateCopyWith<_GrocerySessionState> get copyWith => __$GrocerySessionStateCopyWithImpl<_GrocerySessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GrocerySessionState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalAmount,isSubmitting,storeName,mode,expenseId);

@override
String toString() {
  return 'GrocerySessionState(items: $items, totalAmount: $totalAmount, isSubmitting: $isSubmitting, storeName: $storeName, mode: $mode, expenseId: $expenseId)';
}


}

/// @nodoc
abstract mixin class _$GrocerySessionStateCopyWith<$Res> implements $GrocerySessionStateCopyWith<$Res> {
  factory _$GrocerySessionStateCopyWith(_GrocerySessionState value, $Res Function(_GrocerySessionState) _then) = __$GrocerySessionStateCopyWithImpl;
@override @useResult
$Res call({
 List<GroceryItem> items, double totalAmount, bool isSubmitting, String? storeName, GrocerySessionMode mode, String? expenseId
});




}
/// @nodoc
class __$GrocerySessionStateCopyWithImpl<$Res>
    implements _$GrocerySessionStateCopyWith<$Res> {
  __$GrocerySessionStateCopyWithImpl(this._self, this._then);

  final _GrocerySessionState _self;
  final $Res Function(_GrocerySessionState) _then;

/// Create a copy of GrocerySessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalAmount = null,Object? isSubmitting = null,Object? storeName = freezed,Object? mode = null,Object? expenseId = freezed,}) {
  return _then(_GrocerySessionState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GroceryItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,storeName: freezed == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GrocerySessionMode,expenseId: freezed == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
