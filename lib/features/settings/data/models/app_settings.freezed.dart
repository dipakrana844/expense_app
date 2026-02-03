// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
// Expense Preferences
  @HiveField(0)
  String get defaultCurrency => throw _privateConstructorUsedError;
  @HiveField(1)
  String get defaultExpenseCategory => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get enableQuickExpense => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get enableGroceryOCR =>
      throw _privateConstructorUsedError; // Grocery Settings
  @HiveField(4)
  bool get saveLastStoreName => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get showFrequentItemSuggestions => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get clearGrocerySessionOnExit => throw _privateConstructorUsedError;
  @HiveField(7)
  bool get confirmBeforeGrocerySubmit =>
      throw _privateConstructorUsedError; // Smart Insights Controls
  @HiveField(8)
  bool get enableSpendingIntelligence => throw _privateConstructorUsedError;
  @HiveField(9)
  InsightFrequency get insightFrequency =>
      throw _privateConstructorUsedError; // Security Settings
  @HiveField(10)
  bool get enableAppLock => throw _privateConstructorUsedError;
  @HiveField(11)
  AutoLockTimer get autoLockTimer => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get requireAuthOnLaunch =>
      throw _privateConstructorUsedError; // Data & Storage
  @HiveField(13)
  DateTime? get lastExportDate => throw _privateConstructorUsedError;
  @HiveField(14)
  int? get storageUsageBytes => throw _privateConstructorUsedError; // Metadata
  @HiveField(15)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @HiveField(16)
  DateTime? get lastModified => throw _privateConstructorUsedError;
  @HiveField(17)
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {@HiveField(0) String defaultCurrency,
      @HiveField(1) String defaultExpenseCategory,
      @HiveField(2) bool enableQuickExpense,
      @HiveField(3) bool enableGroceryOCR,
      @HiveField(4) bool saveLastStoreName,
      @HiveField(5) bool showFrequentItemSuggestions,
      @HiveField(6) bool clearGrocerySessionOnExit,
      @HiveField(7) bool confirmBeforeGrocerySubmit,
      @HiveField(8) bool enableSpendingIntelligence,
      @HiveField(9) InsightFrequency insightFrequency,
      @HiveField(10) bool enableAppLock,
      @HiveField(11) AutoLockTimer autoLockTimer,
      @HiveField(12) bool requireAuthOnLaunch,
      @HiveField(13) DateTime? lastExportDate,
      @HiveField(14) int? storageUsageBytes,
      @HiveField(15) DateTime? createdAt,
      @HiveField(16) DateTime? lastModified,
      @HiveField(17) int version});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

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
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String defaultCurrency,
      @HiveField(1) String defaultExpenseCategory,
      @HiveField(2) bool enableQuickExpense,
      @HiveField(3) bool enableGroceryOCR,
      @HiveField(4) bool saveLastStoreName,
      @HiveField(5) bool showFrequentItemSuggestions,
      @HiveField(6) bool clearGrocerySessionOnExit,
      @HiveField(7) bool confirmBeforeGrocerySubmit,
      @HiveField(8) bool enableSpendingIntelligence,
      @HiveField(9) InsightFrequency insightFrequency,
      @HiveField(10) bool enableAppLock,
      @HiveField(11) AutoLockTimer autoLockTimer,
      @HiveField(12) bool requireAuthOnLaunch,
      @HiveField(13) DateTime? lastExportDate,
      @HiveField(14) int? storageUsageBytes,
      @HiveField(15) DateTime? createdAt,
      @HiveField(16) DateTime? lastModified,
      @HiveField(17) int version});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
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
    return _then(_$AppSettingsImpl(
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
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {@HiveField(0) this.defaultCurrency = '₹',
      @HiveField(1) this.defaultExpenseCategory = 'Others',
      @HiveField(2) this.enableQuickExpense = true,
      @HiveField(3) this.enableGroceryOCR = true,
      @HiveField(4) this.saveLastStoreName = true,
      @HiveField(5) this.showFrequentItemSuggestions = true,
      @HiveField(6) this.clearGrocerySessionOnExit = false,
      @HiveField(7) this.confirmBeforeGrocerySubmit = true,
      @HiveField(8) this.enableSpendingIntelligence = true,
      @HiveField(9) this.insightFrequency = InsightFrequency.weekly,
      @HiveField(10) this.enableAppLock = false,
      @HiveField(11) this.autoLockTimer = AutoLockTimer.thirtySeconds,
      @HiveField(12) this.requireAuthOnLaunch = true,
      @HiveField(13) this.lastExportDate,
      @HiveField(14) this.storageUsageBytes,
      @HiveField(15) this.createdAt,
      @HiveField(16) this.lastModified,
      @HiveField(17) this.version = 1});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

// Expense Preferences
  @override
  @JsonKey()
  @HiveField(0)
  final String defaultCurrency;
  @override
  @JsonKey()
  @HiveField(1)
  final String defaultExpenseCategory;
  @override
  @JsonKey()
  @HiveField(2)
  final bool enableQuickExpense;
  @override
  @JsonKey()
  @HiveField(3)
  final bool enableGroceryOCR;
// Grocery Settings
  @override
  @JsonKey()
  @HiveField(4)
  final bool saveLastStoreName;
  @override
  @JsonKey()
  @HiveField(5)
  final bool showFrequentItemSuggestions;
  @override
  @JsonKey()
  @HiveField(6)
  final bool clearGrocerySessionOnExit;
  @override
  @JsonKey()
  @HiveField(7)
  final bool confirmBeforeGrocerySubmit;
// Smart Insights Controls
  @override
  @JsonKey()
  @HiveField(8)
  final bool enableSpendingIntelligence;
  @override
  @JsonKey()
  @HiveField(9)
  final InsightFrequency insightFrequency;
// Security Settings
  @override
  @JsonKey()
  @HiveField(10)
  final bool enableAppLock;
  @override
  @JsonKey()
  @HiveField(11)
  final AutoLockTimer autoLockTimer;
  @override
  @JsonKey()
  @HiveField(12)
  final bool requireAuthOnLaunch;
// Data & Storage
  @override
  @HiveField(13)
  final DateTime? lastExportDate;
  @override
  @HiveField(14)
  final int? storageUsageBytes;
// Metadata
  @override
  @HiveField(15)
  final DateTime? createdAt;
  @override
  @HiveField(16)
  final DateTime? lastModified;
  @override
  @JsonKey()
  @HiveField(17)
  final int version;

  @override
  String toString() {
    return 'AppSettings(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
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

  @JsonKey(ignore: true)
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
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {@HiveField(0) final String defaultCurrency,
      @HiveField(1) final String defaultExpenseCategory,
      @HiveField(2) final bool enableQuickExpense,
      @HiveField(3) final bool enableGroceryOCR,
      @HiveField(4) final bool saveLastStoreName,
      @HiveField(5) final bool showFrequentItemSuggestions,
      @HiveField(6) final bool clearGrocerySessionOnExit,
      @HiveField(7) final bool confirmBeforeGrocerySubmit,
      @HiveField(8) final bool enableSpendingIntelligence,
      @HiveField(9) final InsightFrequency insightFrequency,
      @HiveField(10) final bool enableAppLock,
      @HiveField(11) final AutoLockTimer autoLockTimer,
      @HiveField(12) final bool requireAuthOnLaunch,
      @HiveField(13) final DateTime? lastExportDate,
      @HiveField(14) final int? storageUsageBytes,
      @HiveField(15) final DateTime? createdAt,
      @HiveField(16) final DateTime? lastModified,
      @HiveField(17) final int version}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override // Expense Preferences
  @HiveField(0)
  String get defaultCurrency;
  @override
  @HiveField(1)
  String get defaultExpenseCategory;
  @override
  @HiveField(2)
  bool get enableQuickExpense;
  @override
  @HiveField(3)
  bool get enableGroceryOCR;
  @override // Grocery Settings
  @HiveField(4)
  bool get saveLastStoreName;
  @override
  @HiveField(5)
  bool get showFrequentItemSuggestions;
  @override
  @HiveField(6)
  bool get clearGrocerySessionOnExit;
  @override
  @HiveField(7)
  bool get confirmBeforeGrocerySubmit;
  @override // Smart Insights Controls
  @HiveField(8)
  bool get enableSpendingIntelligence;
  @override
  @HiveField(9)
  InsightFrequency get insightFrequency;
  @override // Security Settings
  @HiveField(10)
  bool get enableAppLock;
  @override
  @HiveField(11)
  AutoLockTimer get autoLockTimer;
  @override
  @HiveField(12)
  bool get requireAuthOnLaunch;
  @override // Data & Storage
  @HiveField(13)
  DateTime? get lastExportDate;
  @override
  @HiveField(14)
  int? get storageUsageBytes;
  @override // Metadata
  @HiveField(15)
  DateTime? get createdAt;
  @override
  @HiveField(16)
  DateTime? get lastModified;
  @override
  @HiveField(17)
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
