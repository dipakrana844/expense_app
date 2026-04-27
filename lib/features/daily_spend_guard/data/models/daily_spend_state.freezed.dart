// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_spend_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailySpendState {

 double get todaySpent; double get dailyLimit; double get remaining; SpendStatus get status; DateTime get lastUpdated;
/// Create a copy of DailySpendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailySpendStateCopyWith<DailySpendState> get copyWith => _$DailySpendStateCopyWithImpl<DailySpendState>(this as DailySpendState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySpendState&&(identical(other.todaySpent, todaySpent) || other.todaySpent == todaySpent)&&(identical(other.dailyLimit, dailyLimit) || other.dailyLimit == dailyLimit)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,todaySpent,dailyLimit,remaining,status,lastUpdated);

@override
String toString() {
  return 'DailySpendState(todaySpent: $todaySpent, dailyLimit: $dailyLimit, remaining: $remaining, status: $status, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $DailySpendStateCopyWith<$Res>  {
  factory $DailySpendStateCopyWith(DailySpendState value, $Res Function(DailySpendState) _then) = _$DailySpendStateCopyWithImpl;
@useResult
$Res call({
 double todaySpent, double dailyLimit, double remaining, SpendStatus status, DateTime lastUpdated
});




}
/// @nodoc
class _$DailySpendStateCopyWithImpl<$Res>
    implements $DailySpendStateCopyWith<$Res> {
  _$DailySpendStateCopyWithImpl(this._self, this._then);

  final DailySpendState _self;
  final $Res Function(DailySpendState) _then;

/// Create a copy of DailySpendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todaySpent = null,Object? dailyLimit = null,Object? remaining = null,Object? status = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
todaySpent: null == todaySpent ? _self.todaySpent : todaySpent // ignore: cast_nullable_to_non_nullable
as double,dailyLimit: null == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpendStatus,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DailySpendState].
extension DailySpendStatePatterns on DailySpendState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailySpendState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailySpendState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailySpendState value)  $default,){
final _that = this;
switch (_that) {
case _DailySpendState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailySpendState value)?  $default,){
final _that = this;
switch (_that) {
case _DailySpendState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double todaySpent,  double dailyLimit,  double remaining,  SpendStatus status,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailySpendState() when $default != null:
return $default(_that.todaySpent,_that.dailyLimit,_that.remaining,_that.status,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double todaySpent,  double dailyLimit,  double remaining,  SpendStatus status,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _DailySpendState():
return $default(_that.todaySpent,_that.dailyLimit,_that.remaining,_that.status,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double todaySpent,  double dailyLimit,  double remaining,  SpendStatus status,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _DailySpendState() when $default != null:
return $default(_that.todaySpent,_that.dailyLimit,_that.remaining,_that.status,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _DailySpendState extends DailySpendState {
  const _DailySpendState({required this.todaySpent, required this.dailyLimit, required this.remaining, required this.status, required this.lastUpdated}): super._();
  

@override final  double todaySpent;
@override final  double dailyLimit;
@override final  double remaining;
@override final  SpendStatus status;
@override final  DateTime lastUpdated;

/// Create a copy of DailySpendState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailySpendStateCopyWith<_DailySpendState> get copyWith => __$DailySpendStateCopyWithImpl<_DailySpendState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySpendState&&(identical(other.todaySpent, todaySpent) || other.todaySpent == todaySpent)&&(identical(other.dailyLimit, dailyLimit) || other.dailyLimit == dailyLimit)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,todaySpent,dailyLimit,remaining,status,lastUpdated);

@override
String toString() {
  return 'DailySpendState(todaySpent: $todaySpent, dailyLimit: $dailyLimit, remaining: $remaining, status: $status, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$DailySpendStateCopyWith<$Res> implements $DailySpendStateCopyWith<$Res> {
  factory _$DailySpendStateCopyWith(_DailySpendState value, $Res Function(_DailySpendState) _then) = __$DailySpendStateCopyWithImpl;
@override @useResult
$Res call({
 double todaySpent, double dailyLimit, double remaining, SpendStatus status, DateTime lastUpdated
});




}
/// @nodoc
class __$DailySpendStateCopyWithImpl<$Res>
    implements _$DailySpendStateCopyWith<$Res> {
  __$DailySpendStateCopyWithImpl(this._self, this._then);

  final _DailySpendState _self;
  final $Res Function(_DailySpendState) _then;

/// Create a copy of DailySpendState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todaySpent = null,Object? dailyLimit = null,Object? remaining = null,Object? status = null,Object? lastUpdated = null,}) {
  return _then(_DailySpendState(
todaySpent: null == todaySpent ? _self.todaySpent : todaySpent // ignore: cast_nullable_to_non_nullable
as double,dailyLimit: null == dailyLimit ? _self.dailyLimit : dailyLimit // ignore: cast_nullable_to_non_nullable
as double,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpendStatus,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
