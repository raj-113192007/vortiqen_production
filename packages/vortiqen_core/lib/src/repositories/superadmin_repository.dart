import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
import '../models/platform_stats.dart';
import '../models/school.dart';

part 'superadmin_repository.g.dart';

class SuperadminRepository {
  final ApiClient _api;

  SuperadminRepository(this._api);

  Future<PlatformStats> getStats() async {
    final response = await _api.dio.get('/superadmin/stats');
    return PlatformStats.fromJson(response.data);
  }

  Future<List<School>> getSchools() async {
    final response = await _api.dio.get('/superadmin/schools');
    return (response.data as List).map((e) => School.fromJson(e)).toList();
  }

  Future<School> updateSchoolStatus(String id, String status) async {
    final response = await _api.dio.patch(
      '/superadmin/schools/$id/status',
      data: {'status': status},
    );
    return School.fromJson(response.data);
  }
}

@riverpod
SuperadminRepository superadminRepository(SuperadminRepositoryRef ref) {
  return SuperadminRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<PlatformStats> platformStats(PlatformStatsRef ref) {
  return ref.watch(superadminRepositoryProvider).getStats();
}

@riverpod
Future<List<School>> allSchools(AllSchoolsRef ref) {
  return ref.watch(superadminRepositoryProvider).getSchools();
}
