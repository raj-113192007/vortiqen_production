import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics.dart';
import '../api/api_client.dart';

class AnalyticsRepository {
  final Dio _dio;

  AnalyticsRepository(this._dio);

  Future<DashboardMetrics> getDashboardMetrics() async {
    final response = await _dio.get('/analytics/dashboard');
    return DashboardMetrics.fromJson(response.data);
  }

  Future<List<SavedReport>> getReports() async {
    final response = await _dio.get('/analytics/reports');
    return (response.data as List).map((json) => SavedReport.fromJson(json)).toList();
  }

  Future<SavedReport> generateReportNow() async {
    final response = await _dio.post('/analytics/reports/generate');
    return SavedReport.fromJson(response.data);
  }
}

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AnalyticsRepository(dio);
});

final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) {
  return ref.watch(analyticsRepositoryProvider).getDashboardMetrics();
});

final savedReportsProvider = FutureProvider<List<SavedReport>>((ref) {
  return ref.watch(analyticsRepositoryProvider).getReports();
});
