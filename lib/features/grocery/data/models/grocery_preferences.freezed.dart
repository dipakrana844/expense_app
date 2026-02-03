// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grocery_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroceryPreferences _$GroceryPreferencesFromJson(Map<String, dynamic> json) {
  return _GroceryPreferences.fromJson(json);
}

/// @nodoc
mixin _$GroceryPreferences {
  /// Last store name used in a grocery session
  @HiveField(0)
  String? get lastStoreName => throw _privateConstructorUsedError;

  /// List of frequently purchased items (name only)
  @HiveField(1)
  List<String> get frequentItems => throw _privateConstructorUsedError;

  /// Maximum number of frequent items to track
  @HiveField(2)
  int get maxFrequentItems => throw _privateConstructorUsedError;

  /// Whether to save last store name between sessions
  @HiveField(3)
  bool get saveLastStore => throw _privateConstructorUsedError;

  /// Whether to show frequent item suggestions
  @HiveField(4)
  bool get showSuggestions => throw _privateConstructorUsedError;

  /// Whether to clear grocery session on app exit
  @HiveField(5)
  bool get clearOnExit => throw _privateConstructorUsedError;

  /// Whether to confirm before submitting grocery session
  @HiveField(6)
  bool get confirmSubmit => throw _privateConstructorUsedError;

  /// Timestamp of last update
  @HiveField(7)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroceryPreferencesCopyWith<GroceryPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroceryPreferencesCopyWith<$Res> {
  factory $GroceryPreferencesCopyWith(
          GroceryPreferences value, $Res Function(GroceryPreferences) then) =
      _$GroceryPreferencesCopyWithImpl<$Res, GroceryPreferences>;
  @useResult
  $Res call(
      {@HiveField(0) String? lastStoreName,
      @HiveField(1) List<String> frequentItems,
      @HiveField(2) int maxFrequentItems,
      @HiveField(3) bool saveLastStore,
      @HiveField(4) bool showSuggestions,
      @HiveField(5) bool clearOnExit,
      @HiveField(6) bool confirmSubmit,
      @HiveField(7) DateTime? lastUpdated});
}

/// @nodoc
class _$GroceryPreferencesCopyWithImpl<$Res, $Val extends GroceryPreferences>
    implements $GroceryPreferencesCopyWith<$Res> {
  _$GroceryPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastStoreName = freezed,
    Object? frequentItems = null,
    Object? maxFrequentItems = null,
    Object? saveLastStore = null,
    Object? showSuggestions = null,
    Object? clearOnExit = null,
    Object? confirmSubmit = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      lastStoreName: freezed == lastStoreName
          ? _value.lastStoreName
          : lastStoreName // ignore: cast_nullable_to_non_nullable
              as String?,
      frequentItems: null == frequentItems
          ? _value.frequentItems
          : frequentItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxFrequentItems: null == maxFrequentItems
          ? _value.maxFrequentItems
          : maxFrequentItems // ignore: cast_nullable_to_non_nullable
              as int,
      saveLastStore: null == saveLastStore
          ? _value.saveLastStore
          : saveLastStore // ignore: cast_nullable_to_non_nullable
              as bool,
      showSuggestions: null == showSuggestions
          ? _value.showSuggestions
          : showSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
      clearOnExit: null == clearOnExit
          ? _value.clearOnExit
          : clearOnExit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmSubmit: null == confirmSubmit
          ? _value.confirmSubmit
          : confirmSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroceryPreferencesImplCopyWith<$Res>
    implements $GroceryPreferencesCopyWith<$Res> {
  factory _$$GroceryPreferencesImplCopyWith(_$GroceryPreferencesImpl value,
          $Res Function(_$GroceryPreferencesImpl) then) =
      __$$GroceryPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? lastStoreName,
      @HiveField(1) List<String> frequentItems,
      @HiveField(2) int maxFrequentItems,
      @HiveField(3) bool saveLastStore,
      @HiveField(4) bool showSuggestions,
      @HiveField(5) bool clearOnExit,
      @HiveField(6) bool confirmSubmit,
      @HiveField(7) DateTime? lastUpdated});
}

/// @nodoc
class __$$GroceryPreferencesImplCopyWithImpl<$Res>
    extends _$GroceryPreferencesCopyWithImpl<$Res, _$GroceryPreferencesImpl>
    implements _$$GroceryPreferencesImplCopyWith<$Res> {
  __$$GroceryPreferencesImplCopyWithImpl(_$GroceryPreferencesImpl _value,
      $Res Function(_$GroceryPreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastStoreName = freezed,
    Object? frequentItems = null,
    Object? maxFrequentItems = null,
    Object? saveLastStore = null,
    Object? showSuggestions = null,
    Object? clearOnExit = null,
    Object? confirmSubmit = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$GroceryPreferencesImpl(
      lastStoreName: freezed == lastStoreName
          ? _value.lastStoreName
          : lastStoreName // ignore: cast_nullable_to_non_nullable
              as String?,
      frequentItems: null == frequentItems
          ? _value._frequentItems
          : frequentItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      maxFrequentItems: null == maxFrequentItems
          ? _value.maxFrequentItems
          : maxFrequentItems // ignore: cast_nullable_to_non_nullable
              as int,
      saveLastStore: null == saveLastStore
          ? _value.saveLastStore
          : saveLastStore // ignore: cast_nullable_to_non_nullable
              as bool,
      showSuggestions: null == showSuggestions
          ? _value.showSuggestions
          : showSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
      clearOnExit: null == clearOnExit
          ? _value.clearOnExit
          : clearOnExit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmSubmit: null == confirmSubmit
          ? _value.confirmSubmit
          : confirmSubmit // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroceryPreferencesImpl implements _GroceryPreferences {
  const _$GroceryPreferencesImpl(
      {@HiveField(0) this.lastStoreName,
      @HiveField(1) final List<String> frequentItems = const [],
      @HiveField(2) this.maxFrequentItems = 20,
      @HiveField(3) this.saveLastStore = true,
      @HiveField(4) this.showSuggestions = true,
      @HiveField(5) this.clearOnExit = false,
      @HiveField(6) this.confirmSubmit = true,
      @HiveField(7) this.lastUpdated})
      : _frequentItems = frequentItems;

  factory _$GroceryPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroceryPreferencesImplFromJson(json);

  /// Last store name used in a grocery session
  @override
  @HiveField(0)
  final String? lastStoreName;

  /// List of frequently purchased items (name only)
  final List<String> _frequentItems;

  /// List of frequently purchased items (name only)
  @override
  @JsonKey()
  @HiveField(1)
  List<String> get frequentItems {
    if (_frequentItems is EqualUnmodifiableListView) return _frequentItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequentItems);
  }

  /// Maximum number of frequent items to track
  @override
  @JsonKey()
  @HiveField(2)
  final int maxFrequentItems;

  /// Whether to save last store name between sessions
  @override
  @JsonKey()
  @HiveField(3)
  final bool saveLastStore;

  /// Whether to show frequent item suggestions
  @override
  @JsonKey()
  @HiveField(4)
  final bool showSuggestions;

  /// Whether to clear grocery session on app exit
  @override
  @JsonKey()
  @HiveField(5)
  final bool clearOnExit;

  /// Whether to confirm before submitting grocery session
  @override
  @JsonKey()
  @HiveField(6)
  final bool confirmSubmit;

  /// Timestamp of last update
  @override
  @HiveField(7)
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'GroceryPreferences(lastStoreName: $lastStoreName, frequentItems: $frequentItems, maxFrequentItems: $maxFrequentItems, saveLastStore: $saveLastStore, showSuggestions: $showSuggestions, clearOnExit: $clearOnExit, confirmSubmit: $confirmSubmit, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroceryPreferencesImpl &&
            (identical(other.lastStoreName, lastStoreName) ||
                other.lastStoreName == lastStoreName) &&
            const DeepCollectionEquality()
                .equals(other._frequentItems, _frequentItems) &&
            (identical(other.maxFrequentItems, maxFrequentItems) ||
                other.maxFrequentItems == maxFrequentItems) &&
            (identical(other.saveLastStore, saveLastStore) ||
                other.saveLastStore == saveLastStore) &&
            (identical(other.showSuggestions, showSuggestions) ||
                other.showSuggestions == showSuggestions) &&
            (identical(other.clearOnExit, clearOnExit) ||
                other.clearOnExit == clearOnExit) &&
            (identical(other.confirmSubmit, confirmSubmit) ||
                other.confirmSubmit == confirmSubmit) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastStoreName,
      const DeepCollectionEquality().hash(_frequentItems),
      maxFrequentItems,
      saveLastStore,
      showSuggestions,
      clearOnExit,
      confirmSubmit,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroceryPreferencesImplCopyWith<_$GroceryPreferencesImpl> get copyWith =>
      __$$GroceryPreferencesImplCopyWithImpl<_$GroceryPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroceryPreferencesImplToJson(
      this,
    );
  }
}

abstract class _GroceryPreferences implements GroceryPreferences {
  const factory _GroceryPreferences(
      {@HiveField(0) final String? lastStoreName,
      @HiveField(1) final List<String> frequentItems,
      @HiveField(2) final int maxFrequentItems,
      @HiveField(3) final bool saveLastStore,
      @HiveField(4) final bool showSuggestions,
      @HiveField(5) final bool clearOnExit,
      @HiveField(6) final bool confirmSubmit,
      @HiveField(7) final DateTime? lastUpdated}) = _$GroceryPreferencesImpl;

  factory _GroceryPreferences.fromJson(Map<String, dynamic> json) =
      _$GroceryPreferencesImpl.fromJson;

  @override

  /// Last store name used in a grocery session
  @HiveField(0)
  String? get lastStoreName;
  @override

  /// List of frequently purchased items (name only)
  @HiveField(1)
  List<String> get frequentItems;
  @override

  /// Maximum number of frequent items to track
  @HiveField(2)
  int get maxFrequentItems;
  @override

  /// Whether to save last store name between sessions
  @HiveField(3)
  bool get saveLastStore;
  @override

  /// Whether to show frequent item suggestions
  @HiveField(4)
  bool get showSuggestions;
  @override

  /// Whether to clear grocery session on app exit
  @HiveField(5)
  bool get clearOnExit;
  @override

  /// Whether to confirm before submitting grocery session
  @HiveField(6)
  bool get confirmSubmit;
  @override

  /// Timestamp of last update
  @HiveField(7)
  DateTime? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$GroceryPreferencesImplCopyWith<_$GroceryPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
