// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlatformStats _$PlatformStatsFromJson(Map<String, dynamic> json) =>
    _PlatformStats(
      totalSchools: (json['totalSchools'] as num?)?.toInt() ?? 0,
      totalUsers: (json['totalUsers'] as num?)?.toInt() ?? 0,
      totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlatformStatsToJson(_PlatformStats instance) =>
    <String, dynamic>{
      'totalSchools': instance.totalSchools,
      'totalUsers': instance.totalUsers,
      'totalStudents': instance.totalStudents,
      'totalRevenue': instance.totalRevenue,
    };
