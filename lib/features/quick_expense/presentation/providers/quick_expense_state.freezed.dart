// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuickExpenseState {

/// Current amount input
 String get amount;/// Selected category
 String get category;/// Optional note
 String get note;/// Whether the expense is being saved
 bool get isSaving;/// Success flag for dismissing sheet
 bool get isSuccess;/// Error message if save fails
 String? get errorMessage;/// Last used category (for smart defaults)
 String? get lastUsedCategory;
/// Create a copy of QuickExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickExpenseStateCopyWith<QuickExpenseState> get copyWith => _$QuickExpenseStateCopyWithImpl<QuickExpenseState>(this as QuickExpenseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickExpenseState&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastUsedCategory, lastUsedCategory) || other.lastUsedCategory == lastUsedCategory));
}


@override
int get hashCode => Object.hash(runtimeType,amount,category,note,isSaving,isSuccess,errorMessage,lastUsedCategory);

@override
String toString() {
  return 'QuickExpenseState(amount: $amount, category: $category, note: $note, isSaving: $isSaving, isSuccess: $isSuccess, errorMessage: $errorMessage, lastUsedCategory: $lastUsedCategory)';
}


}

/// @nodoc
abstract mixin class $QuickExpenseStateCopyWith<$Res>  {
  factory $QuickExpenseStateCopyWith(QuickExpenseState value, $Res Function(QuickExpenseState) _then) = _$QuickExpenseStateCopyWithImpl;
@useResult
$Res call({
 String amount, String category, String note, bool isSaving, bool isSuccess, String? errorMessage, String? lastUsedCategory
});




}
/// @nodoc
class _$QuickExpenseStateCopyWithImpl<$Res>
    implements $QuickExpenseStateCopyWith<$Res> {
  _$QuickExpenseStateCopyWithImpl(this._self, this._then);

  final QuickExpenseState _self;
  final $Res Function(QuickExpenseState) _then;

/// Create a copy of QuickExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? category = null,Object? note = null,Object? isSaving = null,Object? isSuccess = null,Object? errorMessage = freezed,Object? lastUsedCategory = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastUsedCategory: freezed == lastUsedCategory ? _self.lastUsedCategory : lastUsedCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickExpenseState].
extension QuickExpenseStatePatterns on QuickExpenseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickExpenseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickExpenseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickExpenseState value)  $default,){
final _that = this;
switch (_that) {
case _QuickExpenseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickExpenseState value)?  $default,){
final _that = this;
switch (_that) {
case _QuickExpenseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amount,  String category,  String note,  bool isSaving,  bool isSuccess,  String? errorMessage,  String? lastUsedCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickExpenseState() when $default != null:
return $default(_that.amount,_that.category,_that.note,_that.isSaving,_that.isSuccess,_that.errorMessage,_that.lastUsedCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amount,  String category,  String note,  bool isSaving,  bool isSuccess,  String? errorMessage,  String? lastUsedCategory)  $default,) {final _that = this;
switch (_that) {
case _QuickExpenseState():
return $default(_that.amount,_that.category,_that.note,_that.isSaving,_that.isSuccess,_that.errorMessage,_that.lastUsedCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amount,  String category,  String note,  bool isSaving,  bool isSuccess,  String? errorMessage,  String? lastUsedCategory)?  $default,) {final _that = this;
switch (_that) {
case _QuickExpenseState() when $default != null:
return $default(_that.amount,_that.category,_that.note,_that.isSaving,_that.isSuccess,_that.errorMessage,_that.lastUsedCategory);case _:
  return null;

}
}

}

/// @nodoc


class _QuickExpenseState implements QuickExpenseState {
  const _QuickExpenseState({this.amount = '', this.category = 'Grocery', this.note = '', this.isSaving = false, this.isSuccess = false, this.errorMessage, this.lastUsedCategory});
  

/// Current amount input
@override@JsonKey() final  String amount;
/// Selected category
@override@JsonKey() final  String category;
/// Optional note
@override@JsonKey() final  String note;
/// Whether the expense is being saved
@override@JsonKey() final  bool isSaving;
/// Success flag for dismissing sheet
@override@JsonKey() final  bool isSuccess;
/// Error message if save fails
@override final  String? errorMessage;
/// Last used category (for smart defaults)
@override final  String? lastUsedCategory;

/// Create a copy of QuickExpenseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickExpenseStateCopyWith<_QuickExpenseState> get copyWith => __$QuickExpenseStateCopyWithImpl<_QuickExpenseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickExpenseState&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.note, note) || other.note == note)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.lastUsedCategory, lastUsedCategory) || other.lastUsedCategory == lastUsedCategory));
}


@override
int get hashCode => Object.hash(runtimeType,amount,category,note,isSaving,isSuccess,errorMessage,lastUsedCategory);

@override
String toString() {
  return 'QuickExpenseState(amount: $amount, category: $category, note: $note, isSaving: $isSaving, isSuccess: $isSuccess, errorMessage: $errorMessage, lastUsedCategory: $lastUsedCategory)';
}


}

/// @nodoc
abstract mixin class _$QuickExpenseStateCopyWith<$Res> implements $QuickExpenseStateCopyWith<$Res> {
  factory _$QuickExpenseStateCopyWith(_QuickExpenseState value, $Res Function(_QuickExpenseState) _then) = __$QuickExpenseStateCopyWithImpl;
@override @useResult
$Res call({
 String amount, String category, String note, bool isSaving, bool isSuccess, String? errorMessage, String? lastUsedCategory
});




}
/// @nodoc
class __$QuickExpenseStateCopyWithImpl<$Res>
    implements _$QuickExpenseStateCopyWith<$Res> {
  __$QuickExpenseStateCopyWithImpl(this._self, this._then);

  final _QuickExpenseState _self;
  final $Res Function(_QuickExpenseState) _then;

/// Create a copy of QuickExpenseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? category = null,Object? note = null,Object? isSaving = null,Object? isSuccess = null,Object? errorMessage = freezed,Object? lastUsedCategory = freezed,}) {
  return _then(_QuickExpenseState(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastUsedCategory: freezed == lastUsedCategory ? _self.lastUsedCategory : lastUsedCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
