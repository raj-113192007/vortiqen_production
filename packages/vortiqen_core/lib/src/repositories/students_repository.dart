import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../api/api_client.dart';
import '../providers/auth_provider.dart';

class StudentsRepository {
  final Dio _client;

  StudentsRepository(this._client);

  Future<List<Student>> getStudents(String schoolId, {String? classId, String? sectionId, String? parentId, String? userId}) async {
    final response = await _client.get('/api/v1/students', queryParameters: {
      'schoolId': schoolId,
      if (classId != null) 'classId': classId,
      if (sectionId != null) 'sectionId': sectionId,
      if (parentId != null) 'parentId': parentId,
      if (userId != null) 'userId': userId,
    });
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Student.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Student> createStudent(Map<String, dynamic> studentData) async {
    final response = await _client.post('/api/v1/students', data: studentData);
    return Student.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}

final studentsRepositoryProvider = Provider<StudentsRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return StudentsRepository(client.dio);
});

final studentsProvider = FutureProvider.family<List<Student>, String>((ref, schoolId) {
  return ref.watch(studentsRepositoryProvider).getStudents(schoolId);
});

final parentStudentsProvider = FutureProvider.family<List<Student>, Map<String, dynamic>>((ref, params) {
  return ref.watch(studentsRepositoryProvider).getStudents(
    params['schoolId'] as String,
    parentId: params['parentId'] as String,
  );
});

final studentProfileProvider = FutureProvider.family<Student?, Map<String, dynamic>>((ref, params) async {
  final students = await ref.watch(studentsRepositoryProvider).getStudents(
    params['schoolId'] as String,
    userId: params['userId'] as String,
  );
  return students.isNotEmpty ? students.first : null;
});
final studentListProvider = FutureProvider.family<List<Student>, Map<String, dynamic>>((ref, params) {
  final schoolId = ref.watch(authProvider).value?.user?.schoolId;
  if (schoolId == null) return Future.value([]);
  
  return ref.watch(studentsRepositoryProvider).getStudents(
    schoolId,
    classId: params['classId'] as String?,
    sectionId: params['sectionId'] as String?,
  );
});
