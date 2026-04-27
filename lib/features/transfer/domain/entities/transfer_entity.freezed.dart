// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransferEntity {

 String get id; double get amount; String get fromAccount; String get toAccount; DateTime get date; double get fee; String? get note; DateTime get createdAt; DateTime? get updatedAt; Map<String, dynamic>? get metadata;
/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferEntityCopyWith<TransferEntity> get copyWith => _$TransferEntityCopyWithImpl<TransferEntity>(this as TransferEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromAccount, fromAccount) || other.fromAccount == fromAccount)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount)&&(identical(other.date, date) || other.date == date)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,fromAccount,toAccount,date,fee,note,createdAt,updatedAt,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'TransferEntity(id: $id, amount: $amount, fromAccount: $fromAccount, toAccount: $toAccount, date: $date, fee: $fee, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $TransferEntityCopyWith<$Res>  {
  factory $TransferEntityCopyWith(TransferEntity value, $Res Function(TransferEntity) _then) = _$TransferEntityCopyWithImpl;
@useResult
$Res call({
 String id, double amount, String fromAccount, String toAccount, DateTime date, double fee, String? note, DateTime createdAt, DateTime? updatedAt, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$TransferEntityCopyWithImpl<$Res>
    implements $TransferEntityCopyWith<$Res> {
  _$TransferEntityCopyWithImpl(this._self, this._then);

  final TransferEntity _self;
  final $Res Function(TransferEntity) _then;

/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? fromAccount = null,Object? toAccount = null,Object? date = null,Object? fee = null,Object? note = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fromAccount: null == fromAccount ? _self.fromAccount : fromAccount // ignore: cast_nullable_to_non_nullable
as String,toAccount: null == toAccount ? _self.toAccount : toAccount // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferEntity].
extension TransferEntityPatterns on TransferEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransferEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double amount,  String fromAccount,  String toAccount,  DateTime date,  double fee,  String? note,  DateTime createdAt,  DateTime? updatedAt,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
return $default(_that.id,_that.amount,_that.fromAccount,_that.toAccount,_that.date,_that.fee,_that.note,_that.createdAt,_that.updatedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double amount,  String fromAccount,  String toAccount,  DateTime date,  double fee,  String? note,  DateTime createdAt,  DateTime? updatedAt,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _TransferEntity():
return $default(_that.id,_that.amount,_that.fromAccount,_that.toAccount,_that.date,_that.fee,_that.note,_that.createdAt,_that.updatedAt,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double amount,  String fromAccount,  String toAccount,  DateTime date,  double fee,  String? note,  DateTime createdAt,  DateTime? updatedAt,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
return $default(_that.id,_that.amount,_that.fromAccount,_that.toAccount,_that.date,_that.fee,_that.note,_that.createdAt,_that.updatedAt,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _TransferEntity extends TransferEntity {
  const _TransferEntity({required this.id, required this.amount, required this.fromAccount, required this.toAccount, required this.date, this.fee = 0.0, this.note, required this.createdAt, this.updatedAt, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  

@override final  String id;
@override final  double amount;
@override final  String fromAccount;
@override final  String toAccount;
@override final  DateTime date;
@override@JsonKey() final  double fee;
@override final  String? note;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferEntityCopyWith<_TransferEntity> get copyWith => __$TransferEntityCopyWithImpl<_TransferEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fromAccount, fromAccount) || other.fromAccount == fromAccount)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount)&&(identical(other.date, date) || other.date == date)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,fromAccount,toAccount,date,fee,note,createdAt,updatedAt,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'TransferEntity(id: $id, amount: $amount, fromAccount: $fromAccount, toAccount: $toAccount, date: $date, fee: $fee, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$TransferEntityCopyWith<$Res> implements $TransferEntityCopyWith<$Res> {
  factory _$TransferEntityCopyWith(_TransferEntity value, $Res Function(_TransferEntity) _then) = __$TransferEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, double amount, String fromAccount, String toAccount, DateTime date, double fee, String? note, DateTime createdAt, DateTime? updatedAt, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$TransferEntityCopyWithImpl<$Res>
    implements _$TransferEntityCopyWith<$Res> {
  __$TransferEntityCopyWithImpl(this._self, this._then);

  final _TransferEntity _self;
  final $Res Function(_TransferEntity) _then;

/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? fromAccount = null,Object? toAccount = null,Object? date = null,Object? fee = null,Object? note = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? metadata = freezed,}) {
  return _then(_TransferEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fromAccount: null == fromAccount ? _self.fromAccount : fromAccount // ignore: cast_nullable_to_non_nullable
as String,toAccount: null == toAccount ? _self.toAccount : toAccount // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
