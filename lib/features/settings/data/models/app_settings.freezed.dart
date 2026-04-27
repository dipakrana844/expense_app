// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettings {

// Expense Preferences
 String get defaultCurrency; String get defaultExpenseCategory; bool get enableQuickExpense; bool get enableGroceryOCR;// Grocery Settings
 bool get saveLastStoreName; bool get showFrequentItemSuggestions; bool get clearGrocerySessionOnExit; bool get confirmBeforeGrocerySubmit;// Smart Insights Controls
 bool get enableSpendingIntelligence; InsightFrequency get insightFrequency;// Security Settings
 bool get enableAppLock; AutoLockTimer get autoLockTimer; bool get requireAuthOnLaunch;// Data & Storage
 DateTime? get lastExportDate; int? get storageUsageBytes;// Metadata
 DateTime? get createdAt; DateTime? get lastModified; int get version;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency)&&(identical(other.defaultExpenseCategory, defaultExpenseCategory) || other.defaultExpenseCategory == defaultExpenseCategory)&&(identical(other.enableQuickExpense, enableQuickExpense) || other.enableQuickExpense == enableQuickExpense)&&(identical(other.enableGroceryOCR, enableGroceryOCR) || other.enableGroceryOCR == enableGroceryOCR)&&(identical(other.saveLastStoreName, saveLastStoreName) || other.saveLastStoreName == saveLastStoreName)&&(identical(other.showFrequentItemSuggestions, showFrequentItemSuggestions) || other.showFrequentItemSuggestions == showFrequentItemSuggestions)&&(identical(other.clearGrocerySessionOnExit, clearGrocerySessionOnExit) || other.clearGrocerySessionOnExit == clearGrocerySessionOnExit)&&(identical(other.confirmBeforeGrocerySubmit, confirmBeforeGrocerySubmit) || other.confirmBeforeGrocerySubmit == confirmBeforeGrocerySubmit)&&(identical(other.enableSpendingIntelligence, enableSpendingIntelligence) || other.enableSpendingIntelligence == enableSpendingIntelligence)&&(identical(other.insightFrequency, insightFrequency) || other.insightFrequency == insightFrequency)&&(identical(other.enableAppLock, enableAppLock) || other.enableAppLock == enableAppLock)&&(identical(other.autoLockTimer, autoLockTimer) || other.autoLockTimer == autoLockTimer)&&(identical(other.requireAuthOnLaunch, requireAuthOnLaunch) || other.requireAuthOnLaunch == requireAuthOnLaunch)&&(identical(other.lastExportDate, lastExportDate) || other.lastExportDate == lastExportDate)&&(identical(other.storageUsageBytes, storageUsageBytes) || other.storageUsageBytes == storageUsageBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCurrency,defaultExpenseCategory,enableQuickExpense,enableGroceryOCR,saveLastStoreName,showFrequentItemSuggestions,clearGrocerySessionOnExit,confirmBeforeGrocerySubmit,enableSpendingIntelligence,insightFrequency,enableAppLock,autoLockTimer,requireAuthOnLaunch,lastExportDate,storageUsageBytes,createdAt,lastModified,version);

@override
String toString() {
  return 'AppSettings(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 String defaultCurrency, String defaultExpenseCategory, bool enableQuickExpense, bool enableGroceryOCR, bool saveLastStoreName, bool showFrequentItemSuggestions, bool clearGrocerySessionOnExit, bool confirmBeforeGrocerySubmit, bool enableSpendingIntelligence, InsightFrequency insightFrequency, bool enableAppLock, AutoLockTimer autoLockTimer, bool requireAuthOnLaunch, DateTime? lastExportDate, int? storageUsageBytes, DateTime? createdAt, DateTime? lastModified, int version
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultCurrency = null,Object? defaultExpenseCategory = null,Object? enableQuickExpense = null,Object? enableGroceryOCR = null,Object? saveLastStoreName = null,Object? showFrequentItemSuggestions = null,Object? clearGrocerySessionOnExit = null,Object? confirmBeforeGrocerySubmit = null,Object? enableSpendingIntelligence = null,Object? insightFrequency = null,Object? enableAppLock = null,Object? autoLockTimer = null,Object? requireAuthOnLaunch = null,Object? lastExportDate = freezed,Object? storageUsageBytes = freezed,Object? createdAt = freezed,Object? lastModified = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
defaultCurrency: null == defaultCurrency ? _self.defaultCurrency : defaultCurrency // ignore: cast_nullable_to_non_nullable
as String,defaultExpenseCategory: null == defaultExpenseCategory ? _self.defaultExpenseCategory : defaultExpenseCategory // ignore: cast_nullable_to_non_nullable
as String,enableQuickExpense: null == enableQuickExpense ? _self.enableQuickExpense : enableQuickExpense // ignore: cast_nullable_to_non_nullable
as bool,enableGroceryOCR: null == enableGroceryOCR ? _self.enableGroceryOCR : enableGroceryOCR // ignore: cast_nullable_to_non_nullable
as bool,saveLastStoreName: null == saveLastStoreName ? _self.saveLastStoreName : saveLastStoreName // ignore: cast_nullable_to_non_nullable
as bool,showFrequentItemSuggestions: null == showFrequentItemSuggestions ? _self.showFrequentItemSuggestions : showFrequentItemSuggestions // ignore: cast_nullable_to_non_nullable
as bool,clearGrocerySessionOnExit: null == clearGrocerySessionOnExit ? _self.clearGrocerySessionOnExit : clearGrocerySessionOnExit // ignore: cast_nullable_to_non_nullable
as bool,confirmBeforeGrocerySubmit: null == confirmBeforeGrocerySubmit ? _self.confirmBeforeGrocerySubmit : confirmBeforeGrocerySubmit // ignore: cast_nullable_to_non_nullable
as bool,enableSpendingIntelligence: null == enableSpendingIntelligence ? _self.enableSpendingIntelligence : enableSpendingIntelligence // ignore: cast_nullable_to_non_nullable
as bool,insightFrequency: null == insightFrequency ? _self.insightFrequency : insightFrequency // ignore: cast_nullable_to_non_nullable
as InsightFrequency,enableAppLock: null == enableAppLock ? _self.enableAppLock : enableAppLock // ignore: cast_nullable_to_non_nullable
as bool,autoLockTimer: null == autoLockTimer ? _self.autoLockTimer : autoLockTimer // ignore: cast_nullable_to_non_nullable
as AutoLockTimer,requireAuthOnLaunch: null == requireAuthOnLaunch ? _self.requireAuthOnLaunch : requireAuthOnLaunch // ignore: cast_nullable_to_non_nullable
as bool,lastExportDate: freezed == lastExportDate ? _self.lastExportDate : lastExportDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageUsageBytes: freezed == storageUsageBytes ? _self.storageUsageBytes : storageUsageBytes // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModified: freezed == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String defaultCurrency,  String defaultExpenseCategory,  bool enableQuickExpense,  bool enableGroceryOCR,  bool saveLastStoreName,  bool showFrequentItemSuggestions,  bool clearGrocerySessionOnExit,  bool confirmBeforeGrocerySubmit,  bool enableSpendingIntelligence,  InsightFrequency insightFrequency,  bool enableAppLock,  AutoLockTimer autoLockTimer,  bool requireAuthOnLaunch,  DateTime? lastExportDate,  int? storageUsageBytes,  DateTime? createdAt,  DateTime? lastModified,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.defaultCurrency,_that.defaultExpenseCategory,_that.enableQuickExpense,_that.enableGroceryOCR,_that.saveLastStoreName,_that.showFrequentItemSuggestions,_that.clearGrocerySessionOnExit,_that.confirmBeforeGrocerySubmit,_that.enableSpendingIntelligence,_that.insightFrequency,_that.enableAppLock,_that.autoLockTimer,_that.requireAuthOnLaunch,_that.lastExportDate,_that.storageUsageBytes,_that.createdAt,_that.lastModified,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String defaultCurrency,  String defaultExpenseCategory,  bool enableQuickExpense,  bool enableGroceryOCR,  bool saveLastStoreName,  bool showFrequentItemSuggestions,  bool clearGrocerySessionOnExit,  bool confirmBeforeGrocerySubmit,  bool enableSpendingIntelligence,  InsightFrequency insightFrequency,  bool enableAppLock,  AutoLockTimer autoLockTimer,  bool requireAuthOnLaunch,  DateTime? lastExportDate,  int? storageUsageBytes,  DateTime? createdAt,  DateTime? lastModified,  int version)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.defaultCurrency,_that.defaultExpenseCategory,_that.enableQuickExpense,_that.enableGroceryOCR,_that.saveLastStoreName,_that.showFrequentItemSuggestions,_that.clearGrocerySessionOnExit,_that.confirmBeforeGrocerySubmit,_that.enableSpendingIntelligence,_that.insightFrequency,_that.enableAppLock,_that.autoLockTimer,_that.requireAuthOnLaunch,_that.lastExportDate,_that.storageUsageBytes,_that.createdAt,_that.lastModified,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String defaultCurrency,  String defaultExpenseCategory,  bool enableQuickExpense,  bool enableGroceryOCR,  bool saveLastStoreName,  bool showFrequentItemSuggestions,  bool clearGrocerySessionOnExit,  bool confirmBeforeGrocerySubmit,  bool enableSpendingIntelligence,  InsightFrequency insightFrequency,  bool enableAppLock,  AutoLockTimer autoLockTimer,  bool requireAuthOnLaunch,  DateTime? lastExportDate,  int? storageUsageBytes,  DateTime? createdAt,  DateTime? lastModified,  int version)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.defaultCurrency,_that.defaultExpenseCategory,_that.enableQuickExpense,_that.enableGroceryOCR,_that.saveLastStoreName,_that.showFrequentItemSuggestions,_that.clearGrocerySessionOnExit,_that.confirmBeforeGrocerySubmit,_that.enableSpendingIntelligence,_that.insightFrequency,_that.enableAppLock,_that.autoLockTimer,_that.requireAuthOnLaunch,_that.lastExportDate,_that.storageUsageBytes,_that.createdAt,_that.lastModified,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppSettings implements AppSettings {
  const _AppSettings({this.defaultCurrency = '₹', this.defaultExpenseCategory = 'Others', this.enableQuickExpense = true, this.enableGroceryOCR = true, this.saveLastStoreName = true, this.showFrequentItemSuggestions = true, this.clearGrocerySessionOnExit = false, this.confirmBeforeGrocerySubmit = true, this.enableSpendingIntelligence = true, this.insightFrequency = InsightFrequency.weekly, this.enableAppLock = false, this.autoLockTimer = AutoLockTimer.thirtySeconds, this.requireAuthOnLaunch = true, this.lastExportDate, this.storageUsageBytes, this.createdAt, this.lastModified, this.version = 1});
  factory _AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

// Expense Preferences
@override@JsonKey() final  String defaultCurrency;
@override@JsonKey() final  String defaultExpenseCategory;
@override@JsonKey() final  bool enableQuickExpense;
@override@JsonKey() final  bool enableGroceryOCR;
// Grocery Settings
@override@JsonKey() final  bool saveLastStoreName;
@override@JsonKey() final  bool showFrequentItemSuggestions;
@override@JsonKey() final  bool clearGrocerySessionOnExit;
@override@JsonKey() final  bool confirmBeforeGrocerySubmit;
// Smart Insights Controls
@override@JsonKey() final  bool enableSpendingIntelligence;
@override@JsonKey() final  InsightFrequency insightFrequency;
// Security Settings
@override@JsonKey() final  bool enableAppLock;
@override@JsonKey() final  AutoLockTimer autoLockTimer;
@override@JsonKey() final  bool requireAuthOnLaunch;
// Data & Storage
@override final  DateTime? lastExportDate;
@override final  int? storageUsageBytes;
// Metadata
@override final  DateTime? createdAt;
@override final  DateTime? lastModified;
@override@JsonKey() final  int version;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency)&&(identical(other.defaultExpenseCategory, defaultExpenseCategory) || other.defaultExpenseCategory == defaultExpenseCategory)&&(identical(other.enableQuickExpense, enableQuickExpense) || other.enableQuickExpense == enableQuickExpense)&&(identical(other.enableGroceryOCR, enableGroceryOCR) || other.enableGroceryOCR == enableGroceryOCR)&&(identical(other.saveLastStoreName, saveLastStoreName) || other.saveLastStoreName == saveLastStoreName)&&(identical(other.showFrequentItemSuggestions, showFrequentItemSuggestions) || other.showFrequentItemSuggestions == showFrequentItemSuggestions)&&(identical(other.clearGrocerySessionOnExit, clearGrocerySessionOnExit) || other.clearGrocerySessionOnExit == clearGrocerySessionOnExit)&&(identical(other.confirmBeforeGrocerySubmit, confirmBeforeGrocerySubmit) || other.confirmBeforeGrocerySubmit == confirmBeforeGrocerySubmit)&&(identical(other.enableSpendingIntelligence, enableSpendingIntelligence) || other.enableSpendingIntelligence == enableSpendingIntelligence)&&(identical(other.insightFrequency, insightFrequency) || other.insightFrequency == insightFrequency)&&(identical(other.enableAppLock, enableAppLock) || other.enableAppLock == enableAppLock)&&(identical(other.autoLockTimer, autoLockTimer) || other.autoLockTimer == autoLockTimer)&&(identical(other.requireAuthOnLaunch, requireAuthOnLaunch) || other.requireAuthOnLaunch == requireAuthOnLaunch)&&(identical(other.lastExportDate, lastExportDate) || other.lastExportDate == lastExportDate)&&(identical(other.storageUsageBytes, storageUsageBytes) || other.storageUsageBytes == storageUsageBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,defaultCurrency,defaultExpenseCategory,enableQuickExpense,enableGroceryOCR,saveLastStoreName,showFrequentItemSuggestions,clearGrocerySessionOnExit,confirmBeforeGrocerySubmit,enableSpendingIntelligence,insightFrequency,enableAppLock,autoLockTimer,requireAuthOnLaunch,lastExportDate,storageUsageBytes,createdAt,lastModified,version);

@override
String toString() {
  return 'AppSettings(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 String defaultCurrency, String defaultExpenseCategory, bool enableQuickExpense, bool enableGroceryOCR, bool saveLastStoreName, bool showFrequentItemSuggestions, bool clearGrocerySessionOnExit, bool confirmBeforeGrocerySubmit, bool enableSpendingIntelligence, InsightFrequency insightFrequency, bool enableAppLock, AutoLockTimer autoLockTimer, bool requireAuthOnLaunch, DateTime? lastExportDate, int? storageUsageBytes, DateTime? createdAt, DateTime? lastModified, int version
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultCurrency = null,Object? defaultExpenseCategory = null,Object? enableQuickExpense = null,Object? enableGroceryOCR = null,Object? saveLastStoreName = null,Object? showFrequentItemSuggestions = null,Object? clearGrocerySessionOnExit = null,Object? confirmBeforeGrocerySubmit = null,Object? enableSpendingIntelligence = null,Object? insightFrequency = null,Object? enableAppLock = null,Object? autoLockTimer = null,Object? requireAuthOnLaunch = null,Object? lastExportDate = freezed,Object? storageUsageBytes = freezed,Object? createdAt = freezed,Object? lastModified = freezed,Object? version = null,}) {
  return _then(_AppSettings(
defaultCurrency: null == defaultCurrency ? _self.defaultCurrency : defaultCurrency // ignore: cast_nullable_to_non_nullable
as String,defaultExpenseCategory: null == defaultExpenseCategory ? _self.defaultExpenseCategory : defaultExpenseCategory // ignore: cast_nullable_to_non_nullable
as String,enableQuickExpense: null == enableQuickExpense ? _self.enableQuickExpense : enableQuickExpense // ignore: cast_nullable_to_non_nullable
as bool,enableGroceryOCR: null == enableGroceryOCR ? _self.enableGroceryOCR : enableGroceryOCR // ignore: cast_nullable_to_non_nullable
as bool,saveLastStoreName: null == saveLastStoreName ? _self.saveLastStoreName : saveLastStoreName // ignore: cast_nullable_to_non_nullable
as bool,showFrequentItemSuggestions: null == showFrequentItemSuggestions ? _self.showFrequentItemSuggestions : showFrequentItemSuggestions // ignore: cast_nullable_to_non_nullable
as bool,clearGrocerySessionOnExit: null == clearGrocerySessionOnExit ? _self.clearGrocerySessionOnExit : clearGrocerySessionOnExit // ignore: cast_nullable_to_non_nullable
as bool,confirmBeforeGrocerySubmit: null == confirmBeforeGrocerySubmit ? _self.confirmBeforeGrocerySubmit : confirmBeforeGrocerySubmit // ignore: cast_nullable_to_non_nullable
as bool,enableSpendingIntelligence: null == enableSpendingIntelligence ? _self.enableSpendingIntelligence : enableSpendingIntelligence // ignore: cast_nullable_to_non_nullable
as bool,insightFrequency: null == insightFrequency ? _self.insightFrequency : insightFrequency // ignore: cast_nullable_to_non_nullable
as InsightFrequency,enableAppLock: null == enableAppLock ? _self.enableAppLock : enableAppLock // ignore: cast_nullable_to_non_nullable
as bool,autoLockTimer: null == autoLockTimer ? _self.autoLockTimer : autoLockTimer // ignore: cast_nullable_to_non_nullable
as AutoLockTimer,requireAuthOnLaunch: null == requireAuthOnLaunch ? _self.requireAuthOnLaunch : requireAuthOnLaunch // ignore: cast_nullable_to_non_nullable
as bool,lastExportDate: freezed == lastExportDate ? _self.lastExportDate : lastExportDate // ignore: cast_nullable_to_non_nullable
as DateTime?,storageUsageBytes: freezed == storageUsageBytes ? _self.storageUsageBytes : storageUsageBytes // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModified: freezed == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
