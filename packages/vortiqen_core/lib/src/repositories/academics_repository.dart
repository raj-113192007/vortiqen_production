import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_models/vortiqen_models.dart';
import '../models/subject.dart';
import '../api/api_client.dart';

class AcademicsRepository {
  final Dio _client;

  AcademicsRepository(this._client);

  Future<List<AcademicClass>> getClasses() async {
    final response = await _client.get('/api/v1/classes');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => AcademicClass.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<AcademicClass> createClass(String name, List<String> sectionNames, {double monthlyFee = 0.0}) async {
    final response = await _client.post(
      '/api/v1/classes',
      data: {
        'name': name,
        'monthlyFee': monthlyFee,
        'sections': sectionNames.map((s) => {'name': s}).toList(),
      },
    );
    return AcademicClass.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<List<Subject>> getSubjects(String schoolId, {String? classId}) async {
    final response = await _client.get('/api/v1/subjects', queryParameters: {
      'schoolId': schoolId,
      if (classId != null) 'classId': classId,
    });
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Subject.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Subject> createSubject(Map<String, dynamic> subjectData) async {
    final response = await _client.post('/api/v1/subjects', data: subjectData);
    return Subject.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}

final academicsRepositoryProvider = Provider<AcademicsRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return AcademicsRepository(client);
});

final classesProvider = FutureProvider.autoDispose<List<AcademicClass>>((ref) {
  return ref.watch(academicsRepositoryProvider).getClasses();
});

final subjectsProvider = FutureProvider.family<List<Subject>, String>((ref, schoolId) {
  return ref.watch(academicsRepositoryProvider).getSubjects(schoolId);
});

