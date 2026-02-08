// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_spend_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailySpendState {
  @HiveField(0)
  double get todaySpent => throw _privateConstructorUsedError;
  @HiveField(1)
  double get dailyLimit => throw _privateConstructorUsedError;
  @HiveField(2)
  double get remaining => throw _privateConstructorUsedError;
  @HiveField(3)
  SpendStatus get status => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailySpendStateCopyWith<DailySpendState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpendStateCopyWith<$Res> {
  factory $DailySpendStateCopyWith(
          DailySpendState value, $Res Function(DailySpendState) then) =
      _$DailySpendStateCopyWithImpl<$Res, DailySpendState>;
  @useResult
  $Res call(
      {@HiveField(0) double todaySpent,
      @HiveField(1) double dailyLimit,
      @HiveField(2) double remaining,
      @HiveField(3) SpendStatus status,
      @HiveField(4) DateTime lastUpdated});
}

/// @nodoc
class _$DailySpendStateCopyWithImpl<$Res, $Val extends DailySpendState>
    implements $DailySpendStateCopyWith<$Res> {
  _$DailySpendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todaySpent = null,
    Object? dailyLimit = null,
    Object? remaining = null,
    Object? status = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      todaySpent: null == todaySpent
          ? _value.todaySpent
          : todaySpent // ignore: cast_nullable_to_non_nullable
              as double,
      dailyLimit: null == dailyLimit
          ? _value.dailyLimit
          : dailyLimit // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SpendStatus,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailySpendStateImplCopyWith<$Res>
    implements $DailySpendStateCopyWith<$Res> {
  factory _$$DailySpendStateImplCopyWith(_$DailySpendStateImpl value,
          $Res Function(_$DailySpendStateImpl) then) =
      __$$DailySpendStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double todaySpent,
      @HiveField(1) double dailyLimit,
      @HiveField(2) double remaining,
      @HiveField(3) SpendStatus status,
      @HiveField(4) DateTime lastUpdated});
}

/// @nodoc
class __$$DailySpendStateImplCopyWithImpl<$Res>
    extends _$DailySpendStateCopyWithImpl<$Res, _$DailySpendStateImpl>
    implements _$$DailySpendStateImplCopyWith<$Res> {
  __$$DailySpendStateImplCopyWithImpl(
      _$DailySpendStateImpl _value, $Res Function(_$DailySpendStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todaySpent = null,
    Object? dailyLimit = null,
    Object? remaining = null,
    Object? status = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$DailySpendStateImpl(
      todaySpent: null == todaySpent
          ? _value.todaySpent
          : todaySpent // ignore: cast_nullable_to_non_nullable
              as double,
      dailyLimit: null == dailyLimit
          ? _value.dailyLimit
          : dailyLimit // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SpendStatus,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DailySpendStateImpl extends _DailySpendState {
  const _$DailySpendStateImpl(
      {@HiveField(0) required this.todaySpent,
      @HiveField(1) required this.dailyLimit,
      @HiveField(2) required this.remaining,
      @HiveField(3) required this.status,
      @HiveField(4) required this.lastUpdated})
      : super._();

  @override
  @HiveField(0)
  final double todaySpent;
  @override
  @HiveField(1)
  final double dailyLimit;
  @override
  @HiveField(2)
  final double remaining;
  @override
  @HiveField(3)
  final SpendStatus status;
  @override
  @HiveField(4)
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'DailySpendState(todaySpent: $todaySpent, dailyLimit: $dailyLimit, remaining: $remaining, status: $status, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySpendStateImpl &&
            (identical(other.todaySpent, todaySpent) ||
                other.todaySpent == todaySpent) &&
            (identical(other.dailyLimit, dailyLimit) ||
                other.dailyLimit == dailyLimit) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, todaySpent, dailyLimit, remaining, status, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySpendStateImplCopyWith<_$DailySpendStateImpl> get copyWith =>
      __$$DailySpendStateImplCopyWithImpl<_$DailySpendStateImpl>(
          this, _$identity);
}

abstract class _DailySpendState extends DailySpendState {
  const factory _DailySpendState(
          {@HiveField(0) required final double todaySpent,
          @HiveField(1) required final double dailyLimit,
          @HiveField(2) required final double remaining,
          @HiveField(3) required final SpendStatus status,
          @HiveField(4) required final DateTime lastUpdated}) =
      _$DailySpendStateImpl;
  const _DailySpendState._() : super._();

  @override
  @HiveField(0)
  double get todaySpent;
  @override
  @HiveField(1)
  double get dailyLimit;
  @override
  @HiveField(2)
  double get remaining;
  @override
  @HiveField(3)
  SpendStatus get status;
  @override
  @HiveField(4)
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$DailySpendStateImplCopyWith<_$DailySpendStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
