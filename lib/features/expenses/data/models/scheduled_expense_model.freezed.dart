// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduledExpenseModel {

 String get id; double get amount; String get category; int get dayOfMonth;// e.g., 5th of every month
 DateTime get nextRunDate; String? get note; bool get isActive;
/// Create a copy of ScheduledExpenseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledExpenseModelCopyWith<ScheduledExpenseModel> get copyWith => _$ScheduledExpenseModelCopyWithImpl<ScheduledExpenseModel>(this as ScheduledExpenseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.nextRunDate, nextRunDate) || other.nextRunDate == nextRunDate)&&(identical(other.note, note) || other.note == note)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,category,dayOfMonth,nextRunDate,note,isActive);

@override
String toString() {
  return 'ScheduledExpenseModel(id: $id, amount: $amount, category: $category, dayOfMonth: $dayOfMonth, nextRunDate: $nextRunDate, note: $note, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ScheduledExpenseModelCopyWith<$Res>  {
  factory $ScheduledExpenseModelCopyWith(ScheduledExpenseModel value, $Res Function(ScheduledExpenseModel) _then) = _$ScheduledExpenseModelCopyWithImpl;
@useResult
$Res call({
 String id, double amount, String category, int dayOfMonth, DateTime nextRunDate, String? note, bool isActive
});




}
/// @nodoc
class _$ScheduledExpenseModelCopyWithImpl<$Res>
    implements $ScheduledExpenseModelCopyWith<$Res> {
  _$ScheduledExpenseModelCopyWithImpl(this._self, this._then);

  final ScheduledExpenseModel _self;
  final $Res Function(ScheduledExpenseModel) _then;

/// Create a copy of ScheduledExpenseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? dayOfMonth = null,Object? nextRunDate = null,Object? note = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,dayOfMonth: null == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int,nextRunDate: null == nextRunDate ? _self.nextRunDate : nextRunDate // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledExpenseModel].
extension ScheduledExpenseModelPatterns on ScheduledExpenseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledExpenseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledExpenseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledExpenseModel value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledExpenseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledExpenseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledExpenseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double amount,  String category,  int dayOfMonth,  DateTime nextRunDate,  String? note,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledExpenseModel() when $default != null:
return $default(_that.id,_that.amount,_that.category,_that.dayOfMonth,_that.nextRunDate,_that.note,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double amount,  String category,  int dayOfMonth,  DateTime nextRunDate,  String? note,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ScheduledExpenseModel():
return $default(_that.id,_that.amount,_that.category,_that.dayOfMonth,_that.nextRunDate,_that.note,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double amount,  String category,  int dayOfMonth,  DateTime nextRunDate,  String? note,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledExpenseModel() when $default != null:
return $default(_that.id,_that.amount,_that.category,_that.dayOfMonth,_that.nextRunDate,_that.note,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduledExpenseModel extends ScheduledExpenseModel {
   _ScheduledExpenseModel({required this.id, required this.amount, required this.category, required this.dayOfMonth, required this.nextRunDate, this.note, this.isActive = true}): super._();
  

@override final  String id;
@override final  double amount;
@override final  String category;
@override final  int dayOfMonth;
// e.g., 5th of every month
@override final  DateTime nextRunDate;
@override final  String? note;
@override@JsonKey() final  bool isActive;

/// Create a copy of ScheduledExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledExpenseModelCopyWith<_ScheduledExpenseModel> get copyWith => __$ScheduledExpenseModelCopyWithImpl<_ScheduledExpenseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.nextRunDate, nextRunDate) || other.nextRunDate == nextRunDate)&&(identical(other.note, note) || other.note == note)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,category,dayOfMonth,nextRunDate,note,isActive);

@override
String toString() {
  return 'ScheduledExpenseModel(id: $id, amount: $amount, category: $category, dayOfMonth: $dayOfMonth, nextRunDate: $nextRunDate, note: $note, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ScheduledExpenseModelCopyWith<$Res> implements $ScheduledExpenseModelCopyWith<$Res> {
  factory _$ScheduledExpenseModelCopyWith(_ScheduledExpenseModel value, $Res Function(_ScheduledExpenseModel) _then) = __$ScheduledExpenseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, double amount, String category, int dayOfMonth, DateTime nextRunDate, String? note, bool isActive
});




}
/// @nodoc
class __$ScheduledExpenseModelCopyWithImpl<$Res>
    implements _$ScheduledExpenseModelCopyWith<$Res> {
  __$ScheduledExpenseModelCopyWithImpl(this._self, this._then);

  final _ScheduledExpenseModel _self;
  final $Res Function(_ScheduledExpenseModel) _then;

/// Create a copy of ScheduledExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? dayOfMonth = null,Object? nextRunDate = null,Object? note = freezed,Object? isActive = null,}) {
  return _then(_ScheduledExpenseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,dayOfMonth: null == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int,nextRunDate: null == nextRunDate ? _self.nextRunDate : nextRunDate // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
