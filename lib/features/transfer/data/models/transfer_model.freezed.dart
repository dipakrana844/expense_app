// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferModel _$TransferModelFromJson(Map<String, dynamic> json) {
  return _TransferModel.fromJson(json);
}

/// @nodoc
mixin _$TransferModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  double get amount => throw _privateConstructorUsedError;
  @HiveField(2)
  String get fromAccount => throw _privateConstructorUsedError;
  @HiveField(3)
  String get toAccount => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(5)
  double get fee => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get note => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @HiveField(9)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferModelCopyWith<TransferModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferModelCopyWith<$Res> {
  factory $TransferModelCopyWith(
          TransferModel value, $Res Function(TransferModel) then) =
      _$TransferModelCopyWithImpl<$Res, TransferModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) String fromAccount,
      @HiveField(3) String toAccount,
      @HiveField(4) DateTime date,
      @HiveField(5) double fee,
      @HiveField(6) String? note,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) Map<String, dynamic>? metadata});
}

/// @nodoc
class _$TransferModelCopyWithImpl<$Res, $Val extends TransferModel>
    implements $TransferModelCopyWith<$Res> {
  _$TransferModelCopyWithImpl(this._value, this._then);

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
abstract class _$$TransferModelImplCopyWith<$Res>
    implements $TransferModelCopyWith<$Res> {
  factory _$$TransferModelImplCopyWith(
          _$TransferModelImpl value, $Res Function(_$TransferModelImpl) then) =
      __$$TransferModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) String fromAccount,
      @HiveField(3) String toAccount,
      @HiveField(4) DateTime date,
      @HiveField(5) double fee,
      @HiveField(6) String? note,
      @HiveField(7) DateTime createdAt,
      @HiveField(8) DateTime? updatedAt,
      @HiveField(9) Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$TransferModelImplCopyWithImpl<$Res>
    extends _$TransferModelCopyWithImpl<$Res, _$TransferModelImpl>
    implements _$$TransferModelImplCopyWith<$Res> {
  __$$TransferModelImplCopyWithImpl(
      _$TransferModelImpl _value, $Res Function(_$TransferModelImpl) _then)
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
    return _then(_$TransferModelImpl(
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
@JsonSerializable()
class _$TransferModelImpl extends _TransferModel {
  const _$TransferModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.amount,
      @HiveField(2) required this.fromAccount,
      @HiveField(3) required this.toAccount,
      @HiveField(4) required this.date,
      @HiveField(5) this.fee = 0.0,
      @HiveField(6) this.note,
      @HiveField(7) required this.createdAt,
      @HiveField(8) this.updatedAt,
      @HiveField(9) final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  factory _$TransferModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final double amount;
  @override
  @HiveField(2)
  final String fromAccount;
  @override
  @HiveField(3)
  final String toAccount;
  @override
  @HiveField(4)
  final DateTime date;
  @override
  @JsonKey()
  @HiveField(5)
  final double fee;
  @override
  @HiveField(6)
  final String? note;
  @override
  @HiveField(7)
  final DateTime createdAt;
  @override
  @HiveField(8)
  final DateTime? updatedAt;
  final Map<String, dynamic>? _metadata;
  @override
  @HiveField(9)
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TransferModel(id: $id, amount: $amount, fromAccount: $fromAccount, toAccount: $toAccount, date: $date, fee: $fee, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferModelImpl &&
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

  @JsonKey(ignore: true)
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
  _$$TransferModelImplCopyWith<_$TransferModelImpl> get copyWith =>
      __$$TransferModelImplCopyWithImpl<_$TransferModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferModelImplToJson(
      this,
    );
  }
}

abstract class _TransferModel extends TransferModel {
  const factory _TransferModel(
          {@HiveField(0) required final String id,
          @HiveField(1) required final double amount,
          @HiveField(2) required final String fromAccount,
          @HiveField(3) required final String toAccount,
          @HiveField(4) required final DateTime date,
          @HiveField(5) final double fee,
          @HiveField(6) final String? note,
          @HiveField(7) required final DateTime createdAt,
          @HiveField(8) final DateTime? updatedAt,
          @HiveField(9) final Map<String, dynamic>? metadata}) =
      _$TransferModelImpl;
  const _TransferModel._() : super._();

  factory _TransferModel.fromJson(Map<String, dynamic> json) =
      _$TransferModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  double get amount;
  @override
  @HiveField(2)
  String get fromAccount;
  @override
  @HiveField(3)
  String get toAccount;
  @override
  @HiveField(4)
  DateTime get date;
  @override
  @HiveField(5)
  double get fee;
  @override
  @HiveField(6)
  String? get note;
  @override
  @HiveField(7)
  DateTime get createdAt;
  @override
  @HiveField(8)
  DateTime? get updatedAt;
  @override
  @HiveField(9)
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$TransferModelImplCopyWith<_$TransferModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
