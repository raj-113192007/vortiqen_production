import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics.dart';

class AnalyticsRepository {
  AnalyticsRepository();

  Future<DashboardMetrics> getDashboardMetrics() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return const DashboardMetrics(
      totalStudents: 1420,
      totalTeachers: 84,
      totalRevenue: 48200000,
      pendingEnquiries: 28,
      totalAssets: 350,
      assignedAssets: 290,
    );
  }

  Future<List<SavedReport>> getReports() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      SavedReport(
        id: 'rep_01',
        schoolId: 'sch_01',
        type: 'FINANCIAL_ACADEMIC_AUDIT',
        month: DateTime.now(),
        summary: 'Q2 Comprehensive Operations & Fee Realisation Report',
        data: '{"collected": "94%", "attendance": "96.4%"}',
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<SavedReport> generateReportNow() async {
    return SavedReport(
      id: 'rep_new',
      schoolId: 'sch_01',
      type: 'REALTIME_PULSE',
      month: DateTime.now(),
      summary: 'Executive Pulse Generated',
      data: '{}',
      createdAt: DateTime.now(),
    );
  }
}

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository();
});

final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) {
  return ref.watch(analyticsRepositoryProvider).getDashboardMetrics();
});

final savedReportsProvider = FutureProvider<List<SavedReport>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getReports();
});
