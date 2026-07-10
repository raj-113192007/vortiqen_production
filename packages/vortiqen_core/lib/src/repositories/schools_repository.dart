import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/school.dart';
import '../api/api_client.dart';

class SchoolsRepository {
  final Dio _client;

  SchoolsRepository(this._client);

  Future<List<School>> getSchools() async {
    final response = await _client.get('/api/v1/schools');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => School.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<School> createSchool(Map<String, dynamic> schoolData) async {
    final response = await _client.post('/api/v1/schools', data: schoolData);
    return School.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}

final schoolsRepositoryProvider = Provider<SchoolsRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return SchoolsRepository(client.dio);
});

final schoolsProvider = FutureProvider<List<School>>((ref) {
  return ref.watch(schoolsRepositoryProvider).getSchools();
});
