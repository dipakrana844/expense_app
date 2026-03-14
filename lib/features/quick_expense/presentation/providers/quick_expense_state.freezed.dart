// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuickExpenseState {
  /// Current amount input
  String get amount => throw _privateConstructorUsedError;

  /// Selected category
  String get category => throw _privateConstructorUsedError;

  /// Optional note
  String get note => throw _privateConstructorUsedError;

  /// Whether the expense is being saved
  bool get isSaving => throw _privateConstructorUsedError;

  /// Success flag for dismissing sheet
  bool get isSuccess => throw _privateConstructorUsedError;

  /// Error message if save fails
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Last used category (for smart defaults)
  String? get lastUsedCategory => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuickExpenseStateCopyWith<QuickExpenseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickExpenseStateCopyWith<$Res> {
  factory $QuickExpenseStateCopyWith(
          QuickExpenseState value, $Res Function(QuickExpenseState) then) =
      _$QuickExpenseStateCopyWithImpl<$Res, QuickExpenseState>;
  @useResult
  $Res call(
      {String amount,
      String category,
      String note,
      bool isSaving,
      bool isSuccess,
      String? errorMessage,
      String? lastUsedCategory});
}

/// @nodoc
class _$QuickExpenseStateCopyWithImpl<$Res, $Val extends QuickExpenseState>
    implements $QuickExpenseStateCopyWith<$Res> {
  _$QuickExpenseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? category = null,
    Object? note = null,
    Object? isSaving = null,
    Object? isSuccess = null,
    Object? errorMessage = freezed,
    Object? lastUsedCategory = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsedCategory: freezed == lastUsedCategory
          ? _value.lastUsedCategory
          : lastUsedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickExpenseStateImplCopyWith<$Res>
    implements $QuickExpenseStateCopyWith<$Res> {
  factory _$$QuickExpenseStateImplCopyWith(_$QuickExpenseStateImpl value,
          $Res Function(_$QuickExpenseStateImpl) then) =
      __$$QuickExpenseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String amount,
      String category,
      String note,
      bool isSaving,
      bool isSuccess,
      String? errorMessage,
      String? lastUsedCategory});
}

/// @nodoc
class __$$QuickExpenseStateImplCopyWithImpl<$Res>
    extends _$QuickExpenseStateCopyWithImpl<$Res, _$QuickExpenseStateImpl>
    implements _$$QuickExpenseStateImplCopyWith<$Res> {
  __$$QuickExpenseStateImplCopyWithImpl(_$QuickExpenseStateImpl _value,
      $Res Function(_$QuickExpenseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? category = null,
    Object? note = null,
    Object? isSaving = null,
    Object? isSuccess = null,
    Object? errorMessage = freezed,
    Object? lastUsedCategory = freezed,
  }) {
    return _then(_$QuickExpenseStateImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsedCategory: freezed == lastUsedCategory
          ? _value.lastUsedCategory
          : lastUsedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QuickExpenseStateImpl implements _QuickExpenseState {
  const _$QuickExpenseStateImpl(
      {this.amount = '',
      this.category = 'Grocery',
      this.note = '',
      this.isSaving = false,
      this.isSuccess = false,
      this.errorMessage,
      this.lastUsedCategory});

  /// Current amount input
  @override
  @JsonKey()
  final String amount;

  /// Selected category
  @override
  @JsonKey()
  final String category;

  /// Optional note
  @override
  @JsonKey()
  final String note;

  /// Whether the expense is being saved
  @override
  @JsonKey()
  final bool isSaving;

  /// Success flag for dismissing sheet
  @override
  @JsonKey()
  final bool isSuccess;

  /// Error message if save fails
  @override
  final String? errorMessage;

  /// Last used category (for smart defaults)
  @override
  final String? lastUsedCategory;

  @override
  String toString() {
    return 'QuickExpenseState(amount: $amount, category: $category, note: $note, isSaving: $isSaving, isSuccess: $isSuccess, errorMessage: $errorMessage, lastUsedCategory: $lastUsedCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickExpenseStateImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastUsedCategory, lastUsedCategory) ||
                other.lastUsedCategory == lastUsedCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, category, note, isSaving,
      isSuccess, errorMessage, lastUsedCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickExpenseStateImplCopyWith<_$QuickExpenseStateImpl> get copyWith =>
      __$$QuickExpenseStateImplCopyWithImpl<_$QuickExpenseStateImpl>(
          this, _$identity);
}

abstract class _QuickExpenseState implements QuickExpenseState {
  const factory _QuickExpenseState(
      {final String amount,
      final String category,
      final String note,
      final bool isSaving,
      final bool isSuccess,
      final String? errorMessage,
      final String? lastUsedCategory}) = _$QuickExpenseStateImpl;

  @override

  /// Current amount input
  String get amount;
  @override

  /// Selected category
  String get category;
  @override

  /// Optional note
  String get note;
  @override

  /// Whether the expense is being saved
  bool get isSaving;
  @override

  /// Success flag for dismissing sheet
  bool get isSuccess;
  @override

  /// Error message if save fails
  String? get errorMessage;
  @override

  /// Last used category (for smart defaults)
  String? get lastUsedCategory;
  @override
  @JsonKey(ignore: true)
  _$$QuickExpenseStateImplCopyWith<_$QuickExpenseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
