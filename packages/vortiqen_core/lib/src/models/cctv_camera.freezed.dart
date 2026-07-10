// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cctv_camera.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CctvCamera {

 String get id; String get schoolId; String get name; String get location; String get streamUrl; String get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of CctvCamera
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CctvCameraCopyWith<CctvCamera> get copyWith => _$CctvCameraCopyWithImpl<CctvCamera>(this as CctvCamera, _$identity);

  /// Serializes this CctvCamera to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CctvCamera&&(identical(other.id, id) || other.id == id)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,schoolId,name,location,streamUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'CctvCamera(id: $id, schoolId: $schoolId, name: $name, location: $location, streamUrl: $streamUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CctvCameraCopyWith<$Res>  {
  factory $CctvCameraCopyWith(CctvCamera value, $Res Function(CctvCamera) _then) = _$CctvCameraCopyWithImpl;
@useResult
$Res call({
 String id, String schoolId, String name, String location, String streamUrl, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CctvCameraCopyWithImpl<$Res>
    implements $CctvCameraCopyWith<$Res> {
  _$CctvCameraCopyWithImpl(this._self, this._then);

  final CctvCamera _self;
  final $Res Function(CctvCamera) _then;

/// Create a copy of CctvCamera
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? schoolId = null,Object? name = null,Object? location = null,Object? streamUrl = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CctvCamera].
extension CctvCameraPatterns on CctvCamera {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CctvCamera value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CctvCamera() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CctvCamera value)  $default,){
final _that = this;
switch (_that) {
case _CctvCamera():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CctvCamera value)?  $default,){
final _that = this;
switch (_that) {
case _CctvCamera() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String schoolId,  String name,  String location,  String streamUrl,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CctvCamera() when $default != null:
return $default(_that.id,_that.schoolId,_that.name,_that.location,_that.streamUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String schoolId,  String name,  String location,  String streamUrl,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CctvCamera():
return $default(_that.id,_that.schoolId,_that.name,_that.location,_that.streamUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String schoolId,  String name,  String location,  String streamUrl,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CctvCamera() when $default != null:
return $default(_that.id,_that.schoolId,_that.name,_that.location,_that.streamUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CctvCamera implements CctvCamera {
  const _CctvCamera({required this.id, required this.schoolId, required this.name, required this.location, required this.streamUrl, required this.status, required this.createdAt, required this.updatedAt});
  factory _CctvCamera.fromJson(Map<String, dynamic> json) => _$CctvCameraFromJson(json);

@override final  String id;
@override final  String schoolId;
@override final  String name;
@override final  String location;
@override final  String streamUrl;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of CctvCamera
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CctvCameraCopyWith<_CctvCamera> get copyWith => __$CctvCameraCopyWithImpl<_CctvCamera>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CctvCameraToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CctvCamera&&(identical(other.id, id) || other.id == id)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,schoolId,name,location,streamUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'CctvCamera(id: $id, schoolId: $schoolId, name: $name, location: $location, streamUrl: $streamUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CctvCameraCopyWith<$Res> implements $CctvCameraCopyWith<$Res> {
  factory _$CctvCameraCopyWith(_CctvCamera value, $Res Function(_CctvCamera) _then) = __$CctvCameraCopyWithImpl;
@override @useResult
$Res call({
 String id, String schoolId, String name, String location, String streamUrl, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CctvCameraCopyWithImpl<$Res>
    implements _$CctvCameraCopyWith<$Res> {
  __$CctvCameraCopyWithImpl(this._self, this._then);

  final _CctvCamera _self;
  final $Res Function(_CctvCamera) _then;

/// Create a copy of CctvCamera
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? schoolId = null,Object? name = null,Object? location = null,Object? streamUrl = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CctvCamera(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
