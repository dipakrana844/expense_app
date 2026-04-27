// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettingsEntity {

// Expense Preferences
 String get defaultCurrency; String get defaultExpenseCategory; bool get enableQuickExpense; bool get enableGroceryOCR;// Grocery Settings
 bool get saveLastStoreName; bool get showFrequentItemSuggestions; bool get clearGrocerySessionOnExit; bool get confirmBeforeGrocerySubmit;// Smart Insights Controls
 bool get enableSpendingIntelligence; InsightFrequency get insightFrequency;// Security Settings
 bool get enableAppLock; AutoLockTimer get autoLockTimer; bool get requireAuthOnLaunch;// Data & Storage
 DateTime? get lastExportDate; int? get storageUsageBytes;// Metadata
 DateTime? get createdAt; DateTime? get lastModified; int get version;
/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsEntityCopyWith<AppSettingsEntity> get copyWith => _$AppSettingsEntityCopyWithImpl<AppSettingsEntity>(this as AppSettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettingsEntity&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency)&&(identical(other.defaultExpenseCategory, defaultExpenseCategory) || other.defaultExpenseCategory == defaultExpenseCategory)&&(identical(other.enableQuickExpense, enableQuickExpense) || other.enableQuickExpense == enableQuickExpense)&&(identical(other.enableGroceryOCR, enableGroceryOCR) || other.enableGroceryOCR == enableGroceryOCR)&&(identical(other.saveLastStoreName, saveLastStoreName) || other.saveLastStoreName == saveLastStoreName)&&(identical(other.showFrequentItemSuggestions, showFrequentItemSuggestions) || other.showFrequentItemSuggestions == showFrequentItemSuggestions)&&(identical(other.clearGrocerySessionOnExit, clearGrocerySessionOnExit) || other.clearGrocerySessionOnExit == clearGrocerySessionOnExit)&&(identical(other.confirmBeforeGrocerySubmit, confirmBeforeGrocerySubmit) || other.confirmBeforeGrocerySubmit == confirmBeforeGrocerySubmit)&&(identical(other.enableSpendingIntelligence, enableSpendingIntelligence) || other.enableSpendingIntelligence == enableSpendingIntelligence)&&(identical(other.insightFrequency, insightFrequency) || other.insightFrequency == insightFrequency)&&(identical(other.enableAppLock, enableAppLock) || other.enableAppLock == enableAppLock)&&(identical(other.autoLockTimer, autoLockTimer) || other.autoLockTimer == autoLockTimer)&&(identical(other.requireAuthOnLaunch, requireAuthOnLaunch) || other.requireAuthOnLaunch == requireAuthOnLaunch)&&(identical(other.lastExportDate, lastExportDate) || other.lastExportDate == lastExportDate)&&(identical(other.storageUsageBytes, storageUsageBytes) || other.storageUsageBytes == storageUsageBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,defaultCurrency,defaultExpenseCategory,enableQuickExpense,enableGroceryOCR,saveLastStoreName,showFrequentItemSuggestions,clearGrocerySessionOnExit,confirmBeforeGrocerySubmit,enableSpendingIntelligence,insightFrequency,enableAppLock,autoLockTimer,requireAuthOnLaunch,lastExportDate,storageUsageBytes,createdAt,lastModified,version);

@override
String toString() {
  return 'AppSettingsEntity(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
}


}

/// @nodoc
abstract mixin class $AppSettingsEntityCopyWith<$Res>  {
  factory $AppSettingsEntityCopyWith(AppSettingsEntity value, $Res Function(AppSettingsEntity) _then) = _$AppSettingsEntityCopyWithImpl;
@useResult
$Res call({
 String defaultCurrency, String defaultExpenseCategory, bool enableQuickExpense, bool enableGroceryOCR, bool saveLastStoreName, bool showFrequentItemSuggestions, bool clearGrocerySessionOnExit, bool confirmBeforeGrocerySubmit, bool enableSpendingIntelligence, InsightFrequency insightFrequency, bool enableAppLock, AutoLockTimer autoLockTimer, bool requireAuthOnLaunch, DateTime? lastExportDate, int? storageUsageBytes, DateTime? createdAt, DateTime? lastModified, int version
});




}
/// @nodoc
class _$AppSettingsEntityCopyWithImpl<$Res>
    implements $AppSettingsEntityCopyWith<$Res> {
  _$AppSettingsEntityCopyWithImpl(this._self, this._then);

  final AppSettingsEntity _self;
  final $Res Function(AppSettingsEntity) _then;

/// Create a copy of AppSettingsEntity
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


/// Adds pattern-matching-related methods to [AppSettingsEntity].
extension AppSettingsEntityPatterns on AppSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _AppSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettingsEntity() when $default != null:
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
case _AppSettingsEntity() when $default != null:
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
case _AppSettingsEntity():
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
case _AppSettingsEntity() when $default != null:
return $default(_that.defaultCurrency,_that.defaultExpenseCategory,_that.enableQuickExpense,_that.enableGroceryOCR,_that.saveLastStoreName,_that.showFrequentItemSuggestions,_that.clearGrocerySessionOnExit,_that.confirmBeforeGrocerySubmit,_that.enableSpendingIntelligence,_that.insightFrequency,_that.enableAppLock,_that.autoLockTimer,_that.requireAuthOnLaunch,_that.lastExportDate,_that.storageUsageBytes,_that.createdAt,_that.lastModified,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettingsEntity extends AppSettingsEntity {
  const _AppSettingsEntity({required this.defaultCurrency, required this.defaultExpenseCategory, required this.enableQuickExpense, required this.enableGroceryOCR, required this.saveLastStoreName, required this.showFrequentItemSuggestions, required this.clearGrocerySessionOnExit, required this.confirmBeforeGrocerySubmit, required this.enableSpendingIntelligence, required this.insightFrequency, required this.enableAppLock, required this.autoLockTimer, required this.requireAuthOnLaunch, this.lastExportDate, this.storageUsageBytes, this.createdAt, this.lastModified, required this.version}): super._();
  

// Expense Preferences
@override final  String defaultCurrency;
@override final  String defaultExpenseCategory;
@override final  bool enableQuickExpense;
@override final  bool enableGroceryOCR;
// Grocery Settings
@override final  bool saveLastStoreName;
@override final  bool showFrequentItemSuggestions;
@override final  bool clearGrocerySessionOnExit;
@override final  bool confirmBeforeGrocerySubmit;
// Smart Insights Controls
@override final  bool enableSpendingIntelligence;
@override final  InsightFrequency insightFrequency;
// Security Settings
@override final  bool enableAppLock;
@override final  AutoLockTimer autoLockTimer;
@override final  bool requireAuthOnLaunch;
// Data & Storage
@override final  DateTime? lastExportDate;
@override final  int? storageUsageBytes;
// Metadata
@override final  DateTime? createdAt;
@override final  DateTime? lastModified;
@override final  int version;

/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsEntityCopyWith<_AppSettingsEntity> get copyWith => __$AppSettingsEntityCopyWithImpl<_AppSettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettingsEntity&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency)&&(identical(other.defaultExpenseCategory, defaultExpenseCategory) || other.defaultExpenseCategory == defaultExpenseCategory)&&(identical(other.enableQuickExpense, enableQuickExpense) || other.enableQuickExpense == enableQuickExpense)&&(identical(other.enableGroceryOCR, enableGroceryOCR) || other.enableGroceryOCR == enableGroceryOCR)&&(identical(other.saveLastStoreName, saveLastStoreName) || other.saveLastStoreName == saveLastStoreName)&&(identical(other.showFrequentItemSuggestions, showFrequentItemSuggestions) || other.showFrequentItemSuggestions == showFrequentItemSuggestions)&&(identical(other.clearGrocerySessionOnExit, clearGrocerySessionOnExit) || other.clearGrocerySessionOnExit == clearGrocerySessionOnExit)&&(identical(other.confirmBeforeGrocerySubmit, confirmBeforeGrocerySubmit) || other.confirmBeforeGrocerySubmit == confirmBeforeGrocerySubmit)&&(identical(other.enableSpendingIntelligence, enableSpendingIntelligence) || other.enableSpendingIntelligence == enableSpendingIntelligence)&&(identical(other.insightFrequency, insightFrequency) || other.insightFrequency == insightFrequency)&&(identical(other.enableAppLock, enableAppLock) || other.enableAppLock == enableAppLock)&&(identical(other.autoLockTimer, autoLockTimer) || other.autoLockTimer == autoLockTimer)&&(identical(other.requireAuthOnLaunch, requireAuthOnLaunch) || other.requireAuthOnLaunch == requireAuthOnLaunch)&&(identical(other.lastExportDate, lastExportDate) || other.lastExportDate == lastExportDate)&&(identical(other.storageUsageBytes, storageUsageBytes) || other.storageUsageBytes == storageUsageBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,defaultCurrency,defaultExpenseCategory,enableQuickExpense,enableGroceryOCR,saveLastStoreName,showFrequentItemSuggestions,clearGrocerySessionOnExit,confirmBeforeGrocerySubmit,enableSpendingIntelligence,insightFrequency,enableAppLock,autoLockTimer,requireAuthOnLaunch,lastExportDate,storageUsageBytes,createdAt,lastModified,version);

@override
String toString() {
  return 'AppSettingsEntity(defaultCurrency: $defaultCurrency, defaultExpenseCategory: $defaultExpenseCategory, enableQuickExpense: $enableQuickExpense, enableGroceryOCR: $enableGroceryOCR, saveLastStoreName: $saveLastStoreName, showFrequentItemSuggestions: $showFrequentItemSuggestions, clearGrocerySessionOnExit: $clearGrocerySessionOnExit, confirmBeforeGrocerySubmit: $confirmBeforeGrocerySubmit, enableSpendingIntelligence: $enableSpendingIntelligence, insightFrequency: $insightFrequency, enableAppLock: $enableAppLock, autoLockTimer: $autoLockTimer, requireAuthOnLaunch: $requireAuthOnLaunch, lastExportDate: $lastExportDate, storageUsageBytes: $storageUsageBytes, createdAt: $createdAt, lastModified: $lastModified, version: $version)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsEntityCopyWith<$Res> implements $AppSettingsEntityCopyWith<$Res> {
  factory _$AppSettingsEntityCopyWith(_AppSettingsEntity value, $Res Function(_AppSettingsEntity) _then) = __$AppSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String defaultCurrency, String defaultExpenseCategory, bool enableQuickExpense, bool enableGroceryOCR, bool saveLastStoreName, bool showFrequentItemSuggestions, bool clearGrocerySessionOnExit, bool confirmBeforeGrocerySubmit, bool enableSpendingIntelligence, InsightFrequency insightFrequency, bool enableAppLock, AutoLockTimer autoLockTimer, bool requireAuthOnLaunch, DateTime? lastExportDate, int? storageUsageBytes, DateTime? createdAt, DateTime? lastModified, int version
});




}
/// @nodoc
class __$AppSettingsEntityCopyWithImpl<$Res>
    implements _$AppSettingsEntityCopyWith<$Res> {
  __$AppSettingsEntityCopyWithImpl(this._self, this._then);

  final _AppSettingsEntity _self;
  final $Res Function(_AppSettingsEntity) _then;

/// Create a copy of AppSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultCurrency = null,Object? defaultExpenseCategory = null,Object? enableQuickExpense = null,Object? enableGroceryOCR = null,Object? saveLastStoreName = null,Object? showFrequentItemSuggestions = null,Object? clearGrocerySessionOnExit = null,Object? confirmBeforeGrocerySubmit = null,Object? enableSpendingIntelligence = null,Object? insightFrequency = null,Object? enableAppLock = null,Object? autoLockTimer = null,Object? requireAuthOnLaunch = null,Object? lastExportDate = freezed,Object? storageUsageBytes = freezed,Object? createdAt = freezed,Object? lastModified = freezed,Object? version = null,}) {
  return _then(_AppSettingsEntity(
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
