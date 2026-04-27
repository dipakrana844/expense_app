// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Insight {

 String get id; InsightType get type; InsightSeverity get severity; String get title; String get message; DateTime get createdDate; bool get isRead; Map<String, dynamic>? get metadata;
/// Create a copy of Insight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsightCopyWith<Insight> get copyWith => _$InsightCopyWithImpl<Insight>(this as Insight, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Insight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,message,createdDate,isRead,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Insight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $InsightCopyWith<$Res>  {
  factory $InsightCopyWith(Insight value, $Res Function(Insight) _then) = _$InsightCopyWithImpl;
@useResult
$Res call({
 String id, InsightType type, InsightSeverity severity, String title, String message, DateTime createdDate, bool isRead, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$InsightCopyWithImpl<$Res>
    implements $InsightCopyWith<$Res> {
  _$InsightCopyWithImpl(this._self, this._then);

  final Insight _self;
  final $Res Function(Insight) _then;

/// Create a copy of Insight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? createdDate = null,Object? isRead = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Insight].
extension InsightPatterns on Insight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Insight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Insight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Insight value)  $default,){
final _that = this;
switch (_that) {
case _Insight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Insight value)?  $default,){
final _that = this;
switch (_that) {
case _Insight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Insight() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _Insight():
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InsightType type,  InsightSeverity severity,  String title,  String message,  DateTime createdDate,  bool isRead,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _Insight() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.title,_that.message,_that.createdDate,_that.isRead,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc


class _Insight implements Insight {
  const _Insight({required this.id, required this.type, required this.severity, required this.title, required this.message, required this.createdDate, this.isRead = false, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  

@override final  String id;
@override final  InsightType type;
@override final  InsightSeverity severity;
@override final  String title;
@override final  String message;
@override final  DateTime createdDate;
@override@JsonKey() final  bool isRead;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Insight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsightCopyWith<_Insight> get copyWith => __$InsightCopyWithImpl<_Insight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Insight&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,severity,title,message,createdDate,isRead,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Insight(id: $id, type: $type, severity: $severity, title: $title, message: $message, createdDate: $createdDate, isRead: $isRead, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$InsightCopyWith<$Res> implements $InsightCopyWith<$Res> {
  factory _$InsightCopyWith(_Insight value, $Res Function(_Insight) _then) = __$InsightCopyWithImpl;
@override @useResult
$Res call({
 String id, InsightType type, InsightSeverity severity, String title, String message, DateTime createdDate, bool isRead, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$InsightCopyWithImpl<$Res>
    implements _$InsightCopyWith<$Res> {
  __$InsightCopyWithImpl(this._self, this._then);

  final _Insight _self;
  final $Res Function(_Insight) _then;

/// Create a copy of Insight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? title = null,Object? message = null,Object? createdDate = null,Object? isRead = null,Object? metadata = freezed,}) {
  return _then(_Insight(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InsightType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as InsightSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
