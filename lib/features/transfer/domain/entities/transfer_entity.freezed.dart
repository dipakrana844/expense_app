// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransferEntity {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get fromAccount => throw _privateConstructorUsedError;
  String get toAccount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferEntityCopyWith<TransferEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferEntityCopyWith<$Res> {
  factory $TransferEntityCopyWith(
          TransferEntity value, $Res Function(TransferEntity) then) =
      _$TransferEntityCopyWithImpl<$Res, TransferEntity>;
  @useResult
  $Res call(
      {String id,
      double amount,
      String fromAccount,
      String toAccount,
      DateTime date,
      double fee,
      String? note,
      DateTime createdAt,
      DateTime? updatedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$TransferEntityCopyWithImpl<$Res, $Val extends TransferEntity>
    implements $TransferEntityCopyWith<$Res> {
  _$TransferEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? fromAccount = null,
    Object? toAccount = null,
    Object? date = null,
    Object? fee = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromAccount: null == fromAccount
          ? _value.fromAccount
          : fromAccount // ignore: cast_nullable_to_non_nullable
              as String,
      toAccount: null == toAccount
          ? _value.toAccount
          : toAccount // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferEntityImplCopyWith<$Res>
    implements $TransferEntityCopyWith<$Res> {
  factory _$$TransferEntityImplCopyWith(_$TransferEntityImpl value,
          $Res Function(_$TransferEntityImpl) then) =
      __$$TransferEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      String fromAccount,
      String toAccount,
      DateTime date,
      double fee,
      String? note,
      DateTime createdAt,
      DateTime? updatedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$TransferEntityImplCopyWithImpl<$Res>
    extends _$TransferEntityCopyWithImpl<$Res, _$TransferEntityImpl>
    implements _$$TransferEntityImplCopyWith<$Res> {
  __$$TransferEntityImplCopyWithImpl(
      _$TransferEntityImpl _value, $Res Function(_$TransferEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? fromAccount = null,
    Object? toAccount = null,
    Object? date = null,
    Object? fee = null,
    Object? note = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$TransferEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromAccount: null == fromAccount
          ? _value.fromAccount
          : fromAccount // ignore: cast_nullable_to_non_nullable
              as String,
      toAccount: null == toAccount
          ? _value.toAccount
          : toAccount // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$TransferEntityImpl extends _TransferEntity {
  const _$TransferEntityImpl(
      {required this.id,
      required this.amount,
      required this.fromAccount,
      required this.toAccount,
      required this.date,
      this.fee = 0.0,
      this.note,
      required this.createdAt,
      this.updatedAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  @override
  final String id;
  @override
  final double amount;
  @override
  final String fromAccount;
  @override
  final String toAccount;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final double fee;
  @override
  final String? note;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TransferEntity(id: $id, amount: $amount, fromAccount: $fromAccount, toAccount: $toAccount, date: $date, fee: $fee, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fromAccount, fromAccount) ||
                other.fromAccount == fromAccount) &&
            (identical(other.toAccount, toAccount) ||
                other.toAccount == toAccount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      fromAccount,
      toAccount,
      date,
      fee,
      note,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferEntityImplCopyWith<_$TransferEntityImpl> get copyWith =>
      __$$TransferEntityImplCopyWithImpl<_$TransferEntityImpl>(
          this, _$identity);
}

abstract class _TransferEntity extends TransferEntity {
  const factory _TransferEntity(
      {required final String id,
      required final double amount,
      required final String fromAccount,
      required final String toAccount,
      required final DateTime date,
      final double fee,
      final String? note,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final Map<String, dynamic>? metadata}) = _$TransferEntityImpl;
  const _TransferEntity._() : super._();

  @override
  String get id;
  @override
  double get amount;
  @override
  String get fromAccount;
  @override
  String get toAccount;
  @override
  DateTime get date;
  @override
  double get fee;
  @override
  String? get note;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$TransferEntityImplCopyWith<_$TransferEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
