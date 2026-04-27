// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroceryPreferences {

/// Last store name used in a grocery session
 String? get lastStoreName;/// List of frequently purchased items (name only)
 List<String> get frequentItems;/// Maximum number of frequent items to track
 int get maxFrequentItems;/// Whether to save last store name between sessions
 bool get saveLastStore;/// Whether to show frequent item suggestions
 bool get showSuggestions;/// Whether to clear grocery session on app exit
 bool get clearOnExit;/// Whether to confirm before submitting grocery session
 bool get confirmSubmit;/// Timestamp of last update
 DateTime? get lastUpdated;
/// Create a copy of GroceryPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroceryPreferencesCopyWith<GroceryPreferences> get copyWith => _$GroceryPreferencesCopyWithImpl<GroceryPreferences>(this as GroceryPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroceryPreferences&&(identical(other.lastStoreName, lastStoreName) || other.lastStoreName == lastStoreName)&&const DeepCollectionEquality().equals(other.frequentItems, frequentItems)&&(identical(other.maxFrequentItems, maxFrequentItems) || other.maxFrequentItems == maxFrequentItems)&&(identical(other.saveLastStore, saveLastStore) || other.saveLastStore == saveLastStore)&&(identical(other.showSuggestions, showSuggestions) || other.showSuggestions == showSuggestions)&&(identical(other.clearOnExit, clearOnExit) || other.clearOnExit == clearOnExit)&&(identical(other.confirmSubmit, confirmSubmit) || other.confirmSubmit == confirmSubmit)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,lastStoreName,const DeepCollectionEquality().hash(frequentItems),maxFrequentItems,saveLastStore,showSuggestions,clearOnExit,confirmSubmit,lastUpdated);

@override
String toString() {
  return 'GroceryPreferences(lastStoreName: $lastStoreName, frequentItems: $frequentItems, maxFrequentItems: $maxFrequentItems, saveLastStore: $saveLastStore, showSuggestions: $showSuggestions, clearOnExit: $clearOnExit, confirmSubmit: $confirmSubmit, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $GroceryPreferencesCopyWith<$Res>  {
  factory $GroceryPreferencesCopyWith(GroceryPreferences value, $Res Function(GroceryPreferences) _then) = _$GroceryPreferencesCopyWithImpl;
@useResult
$Res call({
 String? lastStoreName, List<String> frequentItems, int maxFrequentItems, bool saveLastStore, bool showSuggestions, bool clearOnExit, bool confirmSubmit, DateTime? lastUpdated
});




}
/// @nodoc
class _$GroceryPreferencesCopyWithImpl<$Res>
    implements $GroceryPreferencesCopyWith<$Res> {
  _$GroceryPreferencesCopyWithImpl(this._self, this._then);

  final GroceryPreferences _self;
  final $Res Function(GroceryPreferences) _then;

/// Create a copy of GroceryPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastStoreName = freezed,Object? frequentItems = null,Object? maxFrequentItems = null,Object? saveLastStore = null,Object? showSuggestions = null,Object? clearOnExit = null,Object? confirmSubmit = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
lastStoreName: freezed == lastStoreName ? _self.lastStoreName : lastStoreName // ignore: cast_nullable_to_non_nullable
as String?,frequentItems: null == frequentItems ? _self.frequentItems : frequentItems // ignore: cast_nullable_to_non_nullable
as List<String>,maxFrequentItems: null == maxFrequentItems ? _self.maxFrequentItems : maxFrequentItems // ignore: cast_nullable_to_non_nullable
as int,saveLastStore: null == saveLastStore ? _self.saveLastStore : saveLastStore // ignore: cast_nullable_to_non_nullable
as bool,showSuggestions: null == showSuggestions ? _self.showSuggestions : showSuggestions // ignore: cast_nullable_to_non_nullable
as bool,clearOnExit: null == clearOnExit ? _self.clearOnExit : clearOnExit // ignore: cast_nullable_to_non_nullable
as bool,confirmSubmit: null == confirmSubmit ? _self.confirmSubmit : confirmSubmit // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroceryPreferences].
extension GroceryPreferencesPatterns on GroceryPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroceryPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroceryPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroceryPreferences value)  $default,){
final _that = this;
switch (_that) {
case _GroceryPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroceryPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _GroceryPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? lastStoreName,  List<String> frequentItems,  int maxFrequentItems,  bool saveLastStore,  bool showSuggestions,  bool clearOnExit,  bool confirmSubmit,  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroceryPreferences() when $default != null:
return $default(_that.lastStoreName,_that.frequentItems,_that.maxFrequentItems,_that.saveLastStore,_that.showSuggestions,_that.clearOnExit,_that.confirmSubmit,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? lastStoreName,  List<String> frequentItems,  int maxFrequentItems,  bool saveLastStore,  bool showSuggestions,  bool clearOnExit,  bool confirmSubmit,  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _GroceryPreferences():
return $default(_that.lastStoreName,_that.frequentItems,_that.maxFrequentItems,_that.saveLastStore,_that.showSuggestions,_that.clearOnExit,_that.confirmSubmit,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? lastStoreName,  List<String> frequentItems,  int maxFrequentItems,  bool saveLastStore,  bool showSuggestions,  bool clearOnExit,  bool confirmSubmit,  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _GroceryPreferences() when $default != null:
return $default(_that.lastStoreName,_that.frequentItems,_that.maxFrequentItems,_that.saveLastStore,_that.showSuggestions,_that.clearOnExit,_that.confirmSubmit,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _GroceryPreferences implements GroceryPreferences {
  const _GroceryPreferences({this.lastStoreName, final  List<String> frequentItems = const [], this.maxFrequentItems = 20, this.saveLastStore = true, this.showSuggestions = true, this.clearOnExit = false, this.confirmSubmit = true, this.lastUpdated}): _frequentItems = frequentItems;
  

/// Last store name used in a grocery session
@override final  String? lastStoreName;
/// List of frequently purchased items (name only)
 final  List<String> _frequentItems;
/// List of frequently purchased items (name only)
@override@JsonKey() List<String> get frequentItems {
  if (_frequentItems is EqualUnmodifiableListView) return _frequentItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_frequentItems);
}

/// Maximum number of frequent items to track
@override@JsonKey() final  int maxFrequentItems;
/// Whether to save last store name between sessions
@override@JsonKey() final  bool saveLastStore;
/// Whether to show frequent item suggestions
@override@JsonKey() final  bool showSuggestions;
/// Whether to clear grocery session on app exit
@override@JsonKey() final  bool clearOnExit;
/// Whether to confirm before submitting grocery session
@override@JsonKey() final  bool confirmSubmit;
/// Timestamp of last update
@override final  DateTime? lastUpdated;

/// Create a copy of GroceryPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroceryPreferencesCopyWith<_GroceryPreferences> get copyWith => __$GroceryPreferencesCopyWithImpl<_GroceryPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroceryPreferences&&(identical(other.lastStoreName, lastStoreName) || other.lastStoreName == lastStoreName)&&const DeepCollectionEquality().equals(other._frequentItems, _frequentItems)&&(identical(other.maxFrequentItems, maxFrequentItems) || other.maxFrequentItems == maxFrequentItems)&&(identical(other.saveLastStore, saveLastStore) || other.saveLastStore == saveLastStore)&&(identical(other.showSuggestions, showSuggestions) || other.showSuggestions == showSuggestions)&&(identical(other.clearOnExit, clearOnExit) || other.clearOnExit == clearOnExit)&&(identical(other.confirmSubmit, confirmSubmit) || other.confirmSubmit == confirmSubmit)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,lastStoreName,const DeepCollectionEquality().hash(_frequentItems),maxFrequentItems,saveLastStore,showSuggestions,clearOnExit,confirmSubmit,lastUpdated);

@override
String toString() {
  return 'GroceryPreferences(lastStoreName: $lastStoreName, frequentItems: $frequentItems, maxFrequentItems: $maxFrequentItems, saveLastStore: $saveLastStore, showSuggestions: $showSuggestions, clearOnExit: $clearOnExit, confirmSubmit: $confirmSubmit, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$GroceryPreferencesCopyWith<$Res> implements $GroceryPreferencesCopyWith<$Res> {
  factory _$GroceryPreferencesCopyWith(_GroceryPreferences value, $Res Function(_GroceryPreferences) _then) = __$GroceryPreferencesCopyWithImpl;
@override @useResult
$Res call({
 String? lastStoreName, List<String> frequentItems, int maxFrequentItems, bool saveLastStore, bool showSuggestions, bool clearOnExit, bool confirmSubmit, DateTime? lastUpdated
});




}
/// @nodoc
class __$GroceryPreferencesCopyWithImpl<$Res>
    implements _$GroceryPreferencesCopyWith<$Res> {
  __$GroceryPreferencesCopyWithImpl(this._self, this._then);

  final _GroceryPreferences _self;
  final $Res Function(_GroceryPreferences) _then;

/// Create a copy of GroceryPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastStoreName = freezed,Object? frequentItems = null,Object? maxFrequentItems = null,Object? saveLastStore = null,Object? showSuggestions = null,Object? clearOnExit = null,Object? confirmSubmit = null,Object? lastUpdated = freezed,}) {
  return _then(_GroceryPreferences(
lastStoreName: freezed == lastStoreName ? _self.lastStoreName : lastStoreName // ignore: cast_nullable_to_non_nullable
as String?,frequentItems: null == frequentItems ? _self._frequentItems : frequentItems // ignore: cast_nullable_to_non_nullable
as List<String>,maxFrequentItems: null == maxFrequentItems ? _self.maxFrequentItems : maxFrequentItems // ignore: cast_nullable_to_non_nullable
as int,saveLastStore: null == saveLastStore ? _self.saveLastStore : saveLastStore // ignore: cast_nullable_to_non_nullable
as bool,showSuggestions: null == showSuggestions ? _self.showSuggestions : showSuggestions // ignore: cast_nullable_to_non_nullable
as bool,clearOnExit: null == clearOnExit ? _self.clearOnExit : clearOnExit // ignore: cast_nullable_to_non_nullable
as bool,confirmSubmit: null == confirmSubmit ? _self.confirmSubmit : confirmSubmit // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
