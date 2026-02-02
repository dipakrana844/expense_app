// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Insight {
  String get id => throw _privateConstructorUsedError;
  InsightType get type => throw _privateConstructorUsedError;
  InsightSeverity get severity => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get createdDate => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightCopyWith<Insight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightCopyWith<$Res> {
  factory $InsightCopyWith(Insight value, $Res Function(Insight) then) =
      _$InsightCopyWithImpl<$Res, Insight>;
  @useResult
  $Res call(
      {String id,
      InsightType type,
      InsightSeverity severity,
      String title,
      String message,
      DateTime createdDate,
      bool isRead,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$InsightCopyWithImpl<$Res, $Val extends Insight>
    implements $InsightCopyWith<$Res> {
  _$InsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? message = null,
    Object? createdDate = null,
    Object? isRead = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as InsightSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightImplCopyWith<$Res> implements $InsightCopyWith<$Res> {
  factory _$$InsightImplCopyWith(
          _$InsightImpl value, $Res Function(_$InsightImpl) then) =
      __$$InsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      InsightType type,
      InsightSeverity severity,
      String title,
      String message,
      DateTime createdDate,
      bool isRead,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$InsightImplCopyWithImpl<$Res>
    extends _$InsightCopyWithImpl<$Res, _$InsightImpl>
    implements _$$InsightImplCopyWith<$Res> {
  __$$InsightImplCopyWithImpl(
      _$InsightImpl _value, $Res Function(_$InsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? severity = null,
    Object? title = null,
    Object? message = null,
    Object? createdDate = null,
    Object? isRead = null,
    Object? metadata = freezed,
  }) {
    return _then(_$InsightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as InsightSeverity,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$InsightImpl implements _Insight {
  const _$InsightImpl(
      {required this.id,
      required this.type,
      required this.severity,
      required this.title,
      required this.message,
      required this.createdDate,
      this.isRead = false,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  @override
  final String id;
  @override
  final InsightType type;
  @override
  final InsightSeverity severity;
  @override
  final String title;
  @override
  final String message;
  @override
  final DateTime createdDate;
  @override
  @JsonKey()
  final bool isRead;
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
    return 'Insight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      severity,
      title,
      message,
      createdDate,
      isRead,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      __$$InsightImplCopyWithImpl<_$InsightImpl>(this, _$identity);
}

abstract class _Insight implements Insight {
  const factory _Insight(
      {required final String id,
      required final InsightType type,
      required final InsightSeverity severity,
      required final String title,
      required final String message,
      required final DateTime createdDate,
      final bool isRead,
      final Map<String, dynamic>? metadata}) = _$InsightImpl;

  @override
  String get id;
  @override
  InsightType get type;
  @override
  InsightSeverity get severity;
  @override
  String get title;
  @override
  String get message;
  @override
  DateTime get createdDate;
  @override
  bool get isRead;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
