// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardMetrics {

 int get totalStudents; int get totalTeachers; int get totalRevenue; int get pendingEnquiries; int get totalAssets; int get assignedAssets;
/// Create a copy of DashboardMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardMetricsCopyWith<DashboardMetrics> get copyWith => _$DashboardMetricsCopyWithImpl<DashboardMetrics>(this as DashboardMetrics, _$identity);

  /// Serializes this DashboardMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardMetrics&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalTeachers, totalTeachers) || other.totalTeachers == totalTeachers)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.pendingEnquiries, pendingEnquiries) || other.pendingEnquiries == pendingEnquiries)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.assignedAssets, assignedAssets) || other.assignedAssets == assignedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalStudents,totalTeachers,totalRevenue,pendingEnquiries,totalAssets,assignedAssets);

@override
String toString() {
  return 'DashboardMetrics(totalStudents: $totalStudents, totalTeachers: $totalTeachers, totalRevenue: $totalRevenue, pendingEnquiries: $pendingEnquiries, totalAssets: $totalAssets, assignedAssets: $assignedAssets)';
}


}

/// @nodoc
abstract mixin class $DashboardMetricsCopyWith<$Res>  {
  factory $DashboardMetricsCopyWith(DashboardMetrics value, $Res Function(DashboardMetrics) _then) = _$DashboardMetricsCopyWithImpl;
@useResult
$Res call({
 int totalStudents, int totalTeachers, int totalRevenue, int pendingEnquiries, int totalAssets, int assignedAssets
});




}
/// @nodoc
class _$DashboardMetricsCopyWithImpl<$Res>
    implements $DashboardMetricsCopyWith<$Res> {
  _$DashboardMetricsCopyWithImpl(this._self, this._then);

  final DashboardMetrics _self;
  final $Res Function(DashboardMetrics) _then;

/// Create a copy of DashboardMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalStudents = null,Object? totalTeachers = null,Object? totalRevenue = null,Object? pendingEnquiries = null,Object? totalAssets = null,Object? assignedAssets = null,}) {
  return _then(_self.copyWith(
totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalTeachers: null == totalTeachers ? _self.totalTeachers : totalTeachers // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,pendingEnquiries: null == pendingEnquiries ? _self.pendingEnquiries : pendingEnquiries // ignore: cast_nullable_to_non_nullable
as int,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as int,assignedAssets: null == assignedAssets ? _self.assignedAssets : assignedAssets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardMetrics].
extension DashboardMetricsPatterns on DashboardMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardMetrics value)  $default,){
final _that = this;
switch (_that) {
case _DashboardMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalStudents,  int totalTeachers,  int totalRevenue,  int pendingEnquiries,  int totalAssets,  int assignedAssets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardMetrics() when $default != null:
return $default(_that.totalStudents,_that.totalTeachers,_that.totalRevenue,_that.pendingEnquiries,_that.totalAssets,_that.assignedAssets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalStudents,  int totalTeachers,  int totalRevenue,  int pendingEnquiries,  int totalAssets,  int assignedAssets)  $default,) {final _that = this;
switch (_that) {
case _DashboardMetrics():
return $default(_that.totalStudents,_that.totalTeachers,_that.totalRevenue,_that.pendingEnquiries,_that.totalAssets,_that.assignedAssets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalStudents,  int totalTeachers,  int totalRevenue,  int pendingEnquiries,  int totalAssets,  int assignedAssets)?  $default,) {final _that = this;
switch (_that) {
case _DashboardMetrics() when $default != null:
return $default(_that.totalStudents,_that.totalTeachers,_that.totalRevenue,_that.pendingEnquiries,_that.totalAssets,_that.assignedAssets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardMetrics implements DashboardMetrics {
  const _DashboardMetrics({required this.totalStudents, required this.totalTeachers, required this.totalRevenue, required this.pendingEnquiries, required this.totalAssets, required this.assignedAssets});
  factory _DashboardMetrics.fromJson(Map<String, dynamic> json) => _$DashboardMetricsFromJson(json);

@override final  int totalStudents;
@override final  int totalTeachers;
@override final  int totalRevenue;
@override final  int pendingEnquiries;
@override final  int totalAssets;
@override final  int assignedAssets;

/// Create a copy of DashboardMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardMetricsCopyWith<_DashboardMetrics> get copyWith => __$DashboardMetricsCopyWithImpl<_DashboardMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardMetrics&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalTeachers, totalTeachers) || other.totalTeachers == totalTeachers)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.pendingEnquiries, pendingEnquiries) || other.pendingEnquiries == pendingEnquiries)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.assignedAssets, assignedAssets) || other.assignedAssets == assignedAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalStudents,totalTeachers,totalRevenue,pendingEnquiries,totalAssets,assignedAssets);

@override
String toString() {
  return 'DashboardMetrics(totalStudents: $totalStudents, totalTeachers: $totalTeachers, totalRevenue: $totalRevenue, pendingEnquiries: $pendingEnquiries, totalAssets: $totalAssets, assignedAssets: $assignedAssets)';
}


}

/// @nodoc
abstract mixin class _$DashboardMetricsCopyWith<$Res> implements $DashboardMetricsCopyWith<$Res> {
  factory _$DashboardMetricsCopyWith(_DashboardMetrics value, $Res Function(_DashboardMetrics) _then) = __$DashboardMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalStudents, int totalTeachers, int totalRevenue, int pendingEnquiries, int totalAssets, int assignedAssets
});




}
/// @nodoc
class __$DashboardMetricsCopyWithImpl<$Res>
    implements _$DashboardMetricsCopyWith<$Res> {
  __$DashboardMetricsCopyWithImpl(this._self, this._then);

  final _DashboardMetrics _self;
  final $Res Function(_DashboardMetrics) _then;

/// Create a copy of DashboardMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalStudents = null,Object? totalTeachers = null,Object? totalRevenue = null,Object? pendingEnquiries = null,Object? totalAssets = null,Object? assignedAssets = null,}) {
  return _then(_DashboardMetrics(
totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalTeachers: null == totalTeachers ? _self.totalTeachers : totalTeachers // ignore: cast_nullable_to_non_nullable
as int,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as int,pendingEnquiries: null == pendingEnquiries ? _self.pendingEnquiries : pendingEnquiries // ignore: cast_nullable_to_non_nullable
as int,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as int,assignedAssets: null == assignedAssets ? _self.assignedAssets : assignedAssets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SavedReport {

 String get id; String get schoolId; String get type; DateTime get month; String get summary; String get data; DateTime get createdAt;
/// Create a copy of SavedReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedReportCopyWith<SavedReport> get copyWith => _$SavedReportCopyWithImpl<SavedReport>(this as SavedReport, _$identity);

  /// Serializes this SavedReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.type, type) || other.type == type)&&(identical(other.month, month) || other.month == month)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,schoolId,type,month,summary,data,createdAt);

@override
String toString() {
  return 'SavedReport(id: $id, schoolId: $schoolId, type: $type, month: $month, summary: $summary, data: $data, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SavedReportCopyWith<$Res>  {
  factory $SavedReportCopyWith(SavedReport value, $Res Function(SavedReport) _then) = _$SavedReportCopyWithImpl;
@useResult
$Res call({
 String id, String schoolId, String type, DateTime month, String summary, String data, DateTime createdAt
});




}
/// @nodoc
class _$SavedReportCopyWithImpl<$Res>
    implements $SavedReportCopyWith<$Res> {
  _$SavedReportCopyWithImpl(this._self, this._then);

  final SavedReport _self;
  final $Res Function(SavedReport) _then;

/// Create a copy of SavedReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? schoolId = null,Object? type = null,Object? month = null,Object? summary = null,Object? data = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedReport].
extension SavedReportPatterns on SavedReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedReport value)  $default,){
final _that = this;
switch (_that) {
case _SavedReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedReport value)?  $default,){
final _that = this;
switch (_that) {
case _SavedReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String schoolId,  String type,  DateTime month,  String summary,  String data,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedReport() when $default != null:
return $default(_that.id,_that.schoolId,_that.type,_that.month,_that.summary,_that.data,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String schoolId,  String type,  DateTime month,  String summary,  String data,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SavedReport():
return $default(_that.id,_that.schoolId,_that.type,_that.month,_that.summary,_that.data,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String schoolId,  String type,  DateTime month,  String summary,  String data,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedReport() when $default != null:
return $default(_that.id,_that.schoolId,_that.type,_that.month,_that.summary,_that.data,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedReport implements SavedReport {
  const _SavedReport({required this.id, required this.schoolId, required this.type, required this.month, required this.summary, required this.data, required this.createdAt});
  factory _SavedReport.fromJson(Map<String, dynamic> json) => _$SavedReportFromJson(json);

@override final  String id;
@override final  String schoolId;
@override final  String type;
@override final  DateTime month;
@override final  String summary;
@override final  String data;
@override final  DateTime createdAt;

/// Create a copy of SavedReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedReportCopyWith<_SavedReport> get copyWith => __$SavedReportCopyWithImpl<_SavedReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.schoolId, schoolId) || other.schoolId == schoolId)&&(identical(other.type, type) || other.type == type)&&(identical(other.month, month) || other.month == month)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,schoolId,type,month,summary,data,createdAt);

@override
String toString() {
  return 'SavedReport(id: $id, schoolId: $schoolId, type: $type, month: $month, summary: $summary, data: $data, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SavedReportCopyWith<$Res> implements $SavedReportCopyWith<$Res> {
  factory _$SavedReportCopyWith(_SavedReport value, $Res Function(_SavedReport) _then) = __$SavedReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String schoolId, String type, DateTime month, String summary, String data, DateTime createdAt
});




}
/// @nodoc
class __$SavedReportCopyWithImpl<$Res>
    implements _$SavedReportCopyWith<$Res> {
  __$SavedReportCopyWithImpl(this._self, this._then);

  final _SavedReport _self;
  final $Res Function(_SavedReport) _then;

/// Create a copy of SavedReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? schoolId = null,Object? type = null,Object? month = null,Object? summary = null,Object? data = null,Object? createdAt = null,}) {
  return _then(_SavedReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,schoolId: null == schoolId ? _self.schoolId : schoolId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
