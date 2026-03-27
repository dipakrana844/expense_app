// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppSettingsEntity {
// Expense Preferences
  String get defaultCurrency => throw _privateConstructorUsedError;
  String get defaultExpenseCategory => throw _privateConstructorUsedError;
  bool get enableQuickExpense => throw _privateConstructorUsedError;
  bool get enableGroceryOCR =>
      throw _privateConstructorUsedError; // Grocery Settings
  bool get saveLastStoreName => throw _privateConstructorUsedError;
  bool get showFrequentItemSuggestions => throw _privateConstructorUsedError;
  bool get clearGrocerySessionOnExit => throw _privateConstructorUsedError;
  bool get confirmBeforeGrocerySubmit =>
      throw _privateConstructorUsedError; // Smart Insights Controls
  bool get enableSpendingIntelligence => throw _privateConstructorUsedError;
  InsightFrequency get insightFrequency =>
      throw _privateConstructorUsedError; // Security Settings
  bool get enableAppLock => throw _privateConstructorUsedError;
  AutoLockTimer get autoLockTimer => throw _privateConstructorUsedError;
  bool get requireAuthOnLaunch =>
      throw _privateConstructorUsedError; // Data & Storage
  DateTime? get lastExportDate => throw _privateConstructorUsedError;
  int? get storageUsageBytes => throw _privateConstructorUsedError; // Metadata
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppSettingsEntityCopyWith<AppSettingsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsEntityCopyWith<$Res> {
  factory $AppSettingsEntityCopyWith(
          AppSettingsEntity value, $Res Function(AppSettingsEntity) then) =
      _$AppSettingsEntityCopyWithImpl<$Res, AppSettingsEntity>;
  @useResult
  $Res call(
      {String defaultCurrency,
      String defaultExpenseCategory,
      bool enableQuickExpense,
      bool enableGroceryOCR,
      bool saveLastStoreName,
      bool showFrequentItemSuggestions,
      bool clearGrocerySessionOnExit,
      bool confirmBeforeGrocerySubmit,
      bool enableSpendingIntelligence,
      InsightFrequency insightFrequency,
      bool enableAppLock,
      AutoLockTimer autoLockTimer,
      bool requireAuthOnLaunch,
      DateTime? lastExportDate,
      int? storageUsageBytes,
      DateTime? createdAt,
      DateTime? lastModified,
      int version});
}

/// @nodoc
class _$AppSettingsEntityCopyWithImpl<$Res, $Val extends AppSettingsEntity>
    implements $AppSettingsEntityCopyWith<$Res> {
  _$AppSettingsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultCurrency = null,
    Object? defaultExpenseCategory = null,
    Object? enableQuickExpense = null,
    Object? enableGroceryOCR = null,
    Object? saveLastStoreName = null,
    Object? showFrequentItemSuggestions = null,
    Object? clearGrocerySessionOnExit = null,
    Object? confirmBeforeGrocerySubmit = null,
    Object? enableSpendingIntelligence = null,
    Object? insightFrequency = null,
    Object? enableAppLock = null,
    Object? autoLockTimer = null,
    Object? requireAuthOnLaunch = null,
    Object? lastExportDate = freezed,
    Object? storageUsageBytes = freezed,
    Object? createdAt = freezed,
    Object? lastModified = freezed,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      defaultCurrency: null == defaultCurrency
          ? _value.defaultCurrency
          : defaultCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      defaultExpenseCategory: null == defaultExpenseCategory
          ? _value.defaultExpenseCategory
          : defaultExpenseCategory // ignore: cast_nullable_to_non_nullable
              as String,
      enableQuickExpense: null == enableQuickExpense
          ? _value.enableQuickExpense
          : enableQuickExpense // ignore: cast_nullable_to_non_nullable
              as bool,
      enableGroceryOCR: null == enableGroceryOCR
          ? _value.enableGroceryOCR
          : enableGroceryOCR // ignore: cast_nullable_to_non_nullable
              as bool,
      saveLastStoreName: null == saveLastStoreName
          ? _value.saveLastStoreName
          : saveLastStoreName // ignore: cast_nullable_to_non_nullable
              as bool,
      showFrequentItemSuggestions: null == showFrequentItemSuggestions
          ? _value.showFrequentItemSuggestions
          : showFrequentItemSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
      clearGrocerySessionOnExit: null == clearGrocerySessionOnExit
          ? _value.clearGrocerySessionOnExit
          : clearGrocerySessionOnExit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmBeforeGrocerySubmit: null == confirmBeforeGrocerySubmit
          ? _value.confirmBeforeGrocerySubmit
          : confirmBeforeGrocerySubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSpendingIntelligence: null == enableSpendingIntelligence
          ? _value.enableSpendingIntelligence
          : enableSpendingIntelligence // ignore: cast_nullable_to_non_nullable
              as bool,
      insightFrequency: null == insightFrequency
          ? _value.insightFrequency
          : insightFrequency // ignore: cast_nullable_to_non_nullable
              as InsightFrequency,
      enableAppLock: null == enableAppLock
          ? _value.enableAppLock
          : enableAppLock // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockTimer: null == autoLockTimer
          ? _value.autoLockTimer
          : autoLockTimer // ignore: cast_nullable_to_non_nullable
              as AutoLockTimer,
      requireAuthOnLaunch: null == requireAuthOnLaunch
          ? _value.requireAuthOnLaunch
          : requireAuthOnLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExportDate: freezed == lastExportDate
          ? _value.lastExportDate
          : lastExportDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      storageUsageBytes: freezed == storageUsageBytes
          ? _value.storageUsageBytes
          : storageUsageBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsEntityImplCopyWith<$Res>
    implements $AppSettingsEntityCopyWith<$Res> {
  factory _$$AppSettingsEntityImplCopyWith(_$AppSettingsEntityImpl value,
          $Res Function(_$AppSettingsEntityImpl) then) =
      __$$AppSettingsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String defaultCurrency,
      String defaultExpenseCategory,
      bool enableQuickExpense,
      bool enableGroceryOCR,
      bool saveLastStoreName,
      bool showFrequentItemSuggestions,
      bool clearGrocerySessionOnExit,
      bool confirmBeforeGrocerySubmit,
      bool enableSpendingIntelligence,
      InsightFrequency insightFrequency,
      bool enableAppLock,
      AutoLockTimer autoLockTimer,
      bool requireAuthOnLaunch,
      DateTime? lastExportDate,
      int? storageUsageBytes,
      DateTime? createdAt,
      DateTime? lastModified,
      int version});
}

/// @nodoc
class __$$AppSettingsEntityImplCopyWithImpl<$Res>
    extends _$AppSettingsEntityCopyWithImpl<$Res, _$AppSettingsEntityImpl>
    implements _$$AppSettingsEntityImplCopyWith<$Res> {
  __$$AppSettingsEntityImplCopyWithImpl(_$AppSettingsEntityImpl _value,
      $Res Function(_$AppSettingsEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultCurrency = null,
    Object? defaultExpenseCategory = null,
    Object? enableQuickExpense = null,
    Object? enableGroceryOCR = null,
    Object? saveLastStoreName = null,
    Object? showFrequentItemSuggestions = null,
    Object? clearGrocerySessionOnExit = null,
    Object? confirmBeforeGrocerySubmit = null,
    Object? enableSpendingIntelligence = null,
    Object? insightFrequency = null,
    Object? enableAppLock = null,
    Object? autoLockTimer = null,
    Object? requireAuthOnLaunch = null,
    Object? lastExportDate = freezed,
    Object? storageUsageBytes = freezed,
    Object? createdAt = freezed,
    Object? lastModified = freezed,
    Object? version = null,
  }) {
    return _then(_$AppSettingsEntityImpl(
      defaultCurrency: null == defaultCurrency
          ? _value.defaultCurrency
          : defaultCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      defaultExpenseCategory: null == defaultExpenseCategory
          ? _value.defaultExpenseCategory
          : defaultExpenseCategory // ignore: cast_nullable_to_non_nullable
              as String,
      enableQuickExpense: null == enableQuickExpense
          ? _value.enableQuickExpense
          : enableQuickExpense // ignore: cast_nullable_to_non_nullable
              as bool,
      enableGroceryOCR: null == enableGroceryOCR
          ? _value.enableGroceryOCR
          : enableGroceryOCR // ignore: cast_nullable_to_non_nullable
              as bool,
      saveLastStoreName: null == saveLastStoreName
          ? _value.saveLastStoreName
          : saveLastStoreName // ignore: cast_nullable_to_non_nullable
              as bool,
      showFrequentItemSuggestions: null == showFrequentItemSuggestions
          ? _value.showFrequentItemSuggestions
          : showFrequentItemSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
      clearGrocerySessionOnExit: null == clearGrocerySessionOnExit
          ? _value.clearGrocerySessionOnExit
          : clearGrocerySessionOnExit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmBeforeGrocerySubmit: null == confirmBeforeGrocerySubmit
          ? _value.confirmBeforeGrocerySubmit
          : confirmBeforeGrocerySubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      enableSpendingIntelligence: null == enableSpendingIntelligence
          ? _value.enableSpendingIntelligence
          : enableSpendingIntelligence // ignore: cast_nullable_to_non_nullable
              as bool,
      insightFrequency: null == insightFrequency
          ? _value.insightFrequency
          : insightFrequency // ignore: cast_nullable_to_non_nullable
              as InsightFrequency,
      enableAppLock: null == enableAppLock
          ? _value.enableAppLock
          : enableAppLock // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLockTimer: null == autoLockTimer
          ? _value.autoLockTimer
          : autoLockTimer // ignore: cast_nullable_to_non_nullable
              as AutoLockTimer,
      requireAuthOnLaunch: null == requireAuthOnLaunch
          ? _value.requireAuthOnLaunch
          : requireAuthOnLaunch // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExportDate: freezed == lastExportDate
          ? _value.lastExportDate
          : lastExportDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      storageUsageBytes: freezed == storageUsageBytes
          ? _value.storageUsageBytes
          : storageUsageBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AppSettingsEntityImpl extends _AppSettingsEntity {
  const _$AppSettingsEntityImpl(
      {required this.defaultCurrency,
      required this.defaultExpenseCategory,
      required this.enableQuickExpense,
      required this.enableGroceryOCR,
      required this.saveLastStoreName,
      required this.showFrequentItemSuggestions,
      required this.clearGrocerySessionOnExit,
      required this.confirmBeforeGrocerySubmit,
      required this.enableSpendingIntelligence,
      required this.insightFrequency,
      required this.enableAppLock,
      required this.autoLockTimer,
      required this.requireAuthOnLaunch,
      this.lastExportDate,
      this.storageUsageBytes,
      this.createdAt,
      this.lastModified,
      required this.version})
      : super._();

// Expense Preferences
  @override
  final String defaultCurrency;
  @override
  final String defaultExpenseCategory;
  @override
  final bool enableQuickExpense;
  @override
  final bool enableGroceryOCR;
// Grocery Settings
  @override
  final bool saveLastStoreName;
  @override
  final bool showFrequentItemSuggestions;
  @override
  final bool clearGrocerySessionOnExit;
  @override
  final bool confirmBeforeGrocerySubmit;
// Smart Insights Controls
  @override
  final bool enableSpendingIntelligence;
  @override
  final InsightFrequency insightFrequency;
// Security Settings
  @override
  final bool enableAppLock;
  @override
  final AutoLockTimer autoLockTimer;
  @override
  final bool requireAuthOnLaunch;
// Data & Storage
  @override
  final DateTime? lastExportDate;
  @override
  final int? storageUsageBytes;
// Metadata
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastModified;
  @override
  final int version;

  @override
  String toString() {
    return 'AppSettingsEntity(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsEntityImpl &&
            (identical(other.defaultCurrency, defaultCurrency) ||
                other.defaultCurrency == defaultCurrency) &&
            (identical(other.defaultExpenseCategory, defaultExpenseCategory) ||
                other.defaultExpenseCategory == defaultExpenseCategory) &&
            (identical(other.enableQuickExpense, enableQuickExpense) ||
                other.enableQuickExpense == enableQuickExpense) &&
            (identical(other.enableGroceryOCR, enableGroceryOCR) ||
                other.enableGroceryOCR == enableGroceryOCR) &&
            (identical(other.saveLastStoreName, saveLastStoreName) ||
                other.saveLastStoreName == saveLastStoreName) &&
            (identical(other.showFrequentItemSuggestions,
                    showFrequentItemSuggestions) ||
                other.showFrequentItemSuggestions ==
                    showFrequentItemSuggestions) &&
            (identical(other.clearGrocerySessionOnExit, clearGrocerySessionOnExit) ||
                other.clearGrocerySessionOnExit == clearGrocerySessionOnExit) &&
            (identical(other.confirmBeforeGrocerySubmit, confirmBeforeGrocerySubmit) ||
                other.confirmBeforeGrocerySubmit ==
                    confirmBeforeGrocerySubmit) &&
            (identical(other.enableSpendingIntelligence,
                    enableSpendingIntelligence) ||
                other.enableSpendingIntelligence ==
                    enableSpendingIntelligence) &&
            (identical(other.insightFrequency, insightFrequency) ||
                other.insightFrequency == insightFrequency) &&
            (identical(other.enableAppLock, enableAppLock) ||
                other.enableAppLock == enableAppLock) &&
            (identical(other.autoLockTimer, autoLockTimer) ||
                other.autoLockTimer == autoLockTimer) &&
            (identical(other.requireAuthOnLaunch, requireAuthOnLaunch) ||
                other.requireAuthOnLaunch == requireAuthOnLaunch) &&
            (identical(other.lastExportDate, lastExportDate) ||
                other.lastExportDate == lastExportDate) &&
            (identical(other.storageUsageBytes, storageUsageBytes) ||
                other.storageUsageBytes == storageUsageBytes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.version, version) || other.version == version));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultCurrency,
      defaultExpenseCategory,
      enableQuickExpense,
      enableGroceryOCR,
      saveLastStoreName,
      showFrequentItemSuggestions,
      clearGrocerySessionOnExit,
      confirmBeforeGrocerySubmit,
      enableSpendingIntelligence,
      insightFrequency,
      enableAppLock,
      autoLockTimer,
      requireAuthOnLaunch,
      lastExportDate,
      storageUsageBytes,
      createdAt,
      lastModified,
      version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsEntityImplCopyWith<_$AppSettingsEntityImpl> get copyWith =>
      __$$AppSettingsEntityImplCopyWithImpl<_$AppSettingsEntityImpl>(
          this, _$identity);
}

abstract class _AppSettingsEntity extends AppSettingsEntity {
  const factory _AppSettingsEntity(
      {required final String defaultCurrency,
      required final String defaultExpenseCategory,
      required final bool enableQuickExpense,
      required final bool enableGroceryOCR,
      required final bool saveLastStoreName,
      required final bool showFrequentItemSuggestions,
      required final bool clearGrocerySessionOnExit,
      required final bool confirmBeforeGrocerySubmit,
      required final bool enableSpendingIntelligence,
      required final InsightFrequency insightFrequency,
      required final bool enableAppLock,
      required final AutoLockTimer autoLockTimer,
      required final bool requireAuthOnLaunch,
      final DateTime? lastExportDate,
      final int? storageUsageBytes,
      final DateTime? createdAt,
      final DateTime? lastModified,
      required final int version}) = _$AppSettingsEntityImpl;
  const _AppSettingsEntity._() : super._();

  @override // Expense Preferences
  String get defaultCurrency;
  @override
  String get defaultExpenseCategory;
  @override
  bool get enableQuickExpense;
  @override
  bool get enableGroceryOCR;
  @override // Grocery Settings
  bool get saveLastStoreName;
  @override
  bool get showFrequentItemSuggestions;
  @override
  bool get clearGrocerySessionOnExit;
  @override
  bool get confirmBeforeGrocerySubmit;
  @override // Smart Insights Controls
  bool get enableSpendingIntelligence;
  @override
  InsightFrequency get insightFrequency;
  @override // Security Settings
  bool get enableAppLock;
  @override
  AutoLockTimer get autoLockTimer;
  @override
  bool get requireAuthOnLaunch;
  @override // Data & Storage
  DateTime? get lastExportDate;
  @override
  int? get storageUsageBytes;
  @override // Metadata
  DateTime? get createdAt;
  @override
  DateTime? get lastModified;
  @override
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsEntityImplCopyWith<_$AppSettingsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
