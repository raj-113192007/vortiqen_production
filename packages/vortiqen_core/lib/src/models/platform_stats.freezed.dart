// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlatformStats {

 int get totalSchools; int get totalUsers; int get totalStudents; int get totalRevenue;
/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformStatsCopyWith<PlatformStats> get copyWith => _$PlatformStatsCopyWithImpl<PlatformStats>(this as PlatformStats, _$identity);

  /// Serializes this PlatformStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformStats&&(identical(other.totalSchools, totalSchools) || other.totalSchools == totalSchools)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSchools,totalUsers,totalStudents,totalRevenue);

@override
String toString() {
  return 'PlatformStats(totalSchools: $totalSchools, totalUsers: $totalUsers, totalStudents: $totalStudents, totalRevenue: $totalRevenue)';
}


}

/// @nodoc
abstract mixin class $PlatformStatsCopyWith<$Res>  {
  factory $PlatformStatsCopyWith(PlatformStats value, $Res Function(PlatformStats) _then) = _$PlatformStatsCopyWithImpl;
@useResult
$Res call({
 int totalSchools, int totalUsers, int totalStudents, int totalRevenue
});




}
/// @nodoc
class _$PlatformStatsCopyWithImpl<$Res>
    implements $PlatformStatsCopyWith<$Res> {
  _$PlatformStatsCopyWithImpl(this._self, this._then);

  final PlatformStats _self;
  final $Res Function(PlatformStats) _then;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSchools = null,Object? totalUsers = null,Object? totalStudents = null,Object? totalRevenue = null,}) {
  return _then(_self.copyWith(
totalSchools: null == totalSchools ? _self.totalSchools : totalSchools // ignore: cast_nullable_to_non_nullable
as int,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformStats].
extension PlatformStatsPatterns on PlatformStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformStats value)  $default,){
final _that = this;
switch (_that) {
case _PlatformStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformStats value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalSchools,  int totalUsers,  int totalStudents,  int totalRevenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
return $default(_that.totalSchools,_that.totalUsers,_that.totalStudents,_that.totalRevenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalSchools,  int totalUsers,  int totalStudents,  int totalRevenue)  $default,) {final _that = this;
switch (_that) {
case _PlatformStats():
return $default(_that.totalSchools,_that.totalUsers,_that.totalStudents,_that.totalRevenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalSchools,  int totalUsers,  int totalStudents,  int totalRevenue)?  $default,) {final _that = this;
switch (_that) {
case _PlatformStats() when $default != null:
return $default(_that.totalSchools,_that.totalUsers,_that.totalStudents,_that.totalRevenue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformStats implements PlatformStats {
  const _PlatformStats({this.totalSchools = 0, this.totalUsers = 0, this.totalStudents = 0, this.totalRevenue = 0});
  factory _PlatformStats.fromJson(Map<String, dynamic> json) => _$PlatformStatsFromJson(json);

@override@JsonKey() final  int totalSchools;
@override@JsonKey() final  int totalUsers;
@override@JsonKey() final  int totalStudents;
@override@JsonKey() final  int totalRevenue;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformStatsCopyWith<_PlatformStats> get copyWith => __$PlatformStatsCopyWithImpl<_PlatformStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformStats&&(identical(other.totalSchools, totalSchools) || other.totalSchools == totalSchools)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalSchools,totalUsers,totalStudents,totalRevenue);

@override
String toString() {
  return 'PlatformStats(totalSchools: $totalSchools, totalUsers: $totalUsers, totalStudents: $totalStudents, totalRevenue: $totalRevenue)';
}


}

/// @nodoc
abstract mixin class _$PlatformStatsCopyWith<$Res> implements $PlatformStatsCopyWith<$Res> {
  factory _$PlatformStatsCopyWith(_PlatformStats value, $Res Function(_PlatformStats) _then) = __$PlatformStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalSchools, int totalUsers, int totalStudents, int totalRevenue
});




}
/// @nodoc
class __$PlatformStatsCopyWithImpl<$Res>
    implements _$PlatformStatsCopyWith<$Res> {
  __$PlatformStatsCopyWithImpl(this._self, this._then);

  final _PlatformStats _self;
  final $Res Function(_PlatformStats) _then;

/// Create a copy of PlatformStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSchools = null,Object? totalUsers = null,Object? totalStudents = null,Object? totalRevenue = null,}) {
  return _then(_PlatformStats(
totalSchools: null == totalSchools ? _self.totalSchools : totalSchools // ignore: cast_nullable_to_non_nullable
as int,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
