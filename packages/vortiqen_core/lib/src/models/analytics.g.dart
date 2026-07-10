// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardMetrics _$DashboardMetricsFromJson(Map<String, dynamic> json) =>
    _DashboardMetrics(
      totalStudents: (json['totalStudents'] as num).toInt(),
      totalTeachers: (json['totalTeachers'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toInt(),
      pendingEnquiries: (json['pendingEnquiries'] as num).toInt(),
      totalAssets: (json['totalAssets'] as num).toInt(),
      assignedAssets: (json['assignedAssets'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardMetricsToJson(_DashboardMetrics instance) =>
    <String, dynamic>{
      'totalStudents': instance.totalStudents,
      'totalTeachers': instance.totalTeachers,
      'totalRevenue': instance.totalRevenue,
      'pendingEnquiries': instance.pendingEnquiries,
      'totalAssets': instance.totalAssets,
      'assignedAssets': instance.assignedAssets,
    };

_SavedReport _$SavedReportFromJson(Map<String, dynamic> json) => _SavedReport(
  id: json['id'] as String,
  schoolId: json['schoolId'] as String,
  type: json['type'] as String,
  month: DateTime.parse(json['month'] as String),
  summary: json['summary'] as String,
  data: json['data'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SavedReportToJson(_SavedReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schoolId': instance.schoolId,
      'type': instance.type,
      'month': instance.month.toIso8601String(),
      'summary': instance.summary,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
    };
