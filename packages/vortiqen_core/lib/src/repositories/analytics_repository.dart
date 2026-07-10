import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/analytics.dart';
import 'api_client.dart';

part 'analytics_repository.g.dart';

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

@riverpod
AnalyticsRepository analyticsRepository(AnalyticsRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return AnalyticsRepository(dio);
}

@riverpod
Future<DashboardMetrics> dashboardMetrics(DashboardMetricsRef ref) {
  return ref.watch(analyticsRepositoryProvider).getDashboardMetrics();
}

@riverpod
Future<List<SavedReport>> savedReports(SavedReportsRef ref) {
  return ref.watch(analyticsRepositoryProvider).getReports();
}
