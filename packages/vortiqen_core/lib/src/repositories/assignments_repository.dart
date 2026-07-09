import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../models/assignment.dart';
import '../api/api_client.dart';

class AssignmentsRepository {
  final Dio _client;

  AssignmentsRepository(this._client);

  Future<List<Assignment>> getAssignmentsForSection(String sectionId) async {
    final response = await _client.get('/api/v1/assignments/section/$sectionId');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Assignment.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Assignment>> getAssignmentsForTeacher() async {
    final response = await _client.get('/api/v1/assignments/teacher');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Assignment.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Assignment> createAssignment({
    required String sectionId,
    required String subjectId,
    required String title,
    required String dueDate,
    String? description,
    PlatformFile? file,
  }) async {
    FormData formData = FormData.fromMap({
      'sectionId': sectionId,
      'subjectId': subjectId,
      'title': title,
      'dueDate': dueDate,
      if (description != null) 'description': description,
    });

    if (file != null && file.path != null) {
      formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(file.path!, filename: file.name),
      ));
    } else if (file != null && file.bytes != null) {
      formData.files.add(MapEntry(
        'file',
        MultipartFile.fromBytes(file.bytes!, filename: file.name),
      ));
    }

    final response = await _client.post('/api/v1/assignments', data: formData);
    return Assignment.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<AssignmentSubmission> submitAssignment({
    required String assignmentId,
    required String studentId,
    String? content,
    PlatformFile? file,
  }) async {
    FormData formData = FormData.fromMap({
      'studentId': studentId,
      if (content != null) 'content': content,
    });

    if (file != null && file.path != null) {
      formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(file.path!, filename: file.name),
      ));
    } else if (file != null && file.bytes != null) {
      formData.files.add(MapEntry(
        'file',
        MultipartFile.fromBytes(file.bytes!, filename: file.name),
      ));
    }

    final response = await _client.post('/api/v1/assignments/$assignmentId/submit', data: formData);
    return AssignmentSubmission.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<List<AssignmentSubmission>> getSubmissions(String assignmentId) async {
    final response = await _client.get('/api/v1/assignments/$assignmentId/submissions');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => AssignmentSubmission.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> gradeSubmission({
    required String submissionId,
    required String grade,
    String? teacherNotes,
  }) async {
    await _client.patch(
      '/api/v1/assignments/submissions/$submissionId/grade',
      data: {
        'grade': grade,
        if (teacherNotes != null) 'teacherNotes': teacherNotes,
      },
    );
  }
}

final assignmentsRepositoryProvider = Provider<AssignmentsRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return AssignmentsRepository(client);
});

final sectionAssignmentsProvider = FutureProvider.family<List<Assignment>, String>((ref, sectionId) {
  return ref.watch(assignmentsRepositoryProvider).getAssignmentsForSection(sectionId);
});

final teacherAssignmentsProvider = FutureProvider<List<Assignment>>((ref) {
  return ref.watch(assignmentsRepositoryProvider).getAssignmentsForTeacher();
});

final assignmentSubmissionsProvider = FutureProvider.family<List<AssignmentSubmission>, String>((ref, assignmentId) {
  return ref.watch(assignmentsRepositoryProvider).getSubmissions(assignmentId);
});
