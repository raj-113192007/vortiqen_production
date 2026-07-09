import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_stats.freezed.dart';
part 'platform_stats.g.dart';

@freezed
class PlatformStats with _$PlatformStats {
  const factory PlatformStats({
    @Default(0) int totalSchools,
    @Default(0) int totalUsers,
    @Default(0) int totalStudents,
    @Default(0) int totalRevenue,
  }) = _PlatformStats;

  factory PlatformStats.fromJson(Map<String, dynamic> json) => _$PlatformStatsFromJson(json);
}
