import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics.freezed.dart';
part 'analytics.g.dart';

@freezed
class DashboardMetrics with _$DashboardMetrics {
  const factory DashboardMetrics({
    required int totalStudents,
    required int totalTeachers,
    required int totalRevenue,
    required int pendingEnquiries,
    required int totalAssets,
    required int assignedAssets,
  }) = _DashboardMetrics;

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) => _$DashboardMetricsFromJson(json);
}

@freezed
class SavedReport with _$SavedReport {
  const factory SavedReport({
    required String id,
    required String schoolId,
    required String type,
    required DateTime month,
    required String summary,
    required String data,
    required DateTime createdAt,
  }) = _SavedReport;

  factory SavedReport.fromJson(Map<String, dynamic> json) => _$SavedReportFromJson(json);
}
