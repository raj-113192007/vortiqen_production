import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exam.dart';
import '../api/api_client.dart';

class ExamsRepository {
  final Dio _client;

  ExamsRepository(this._client);

  Future<List<Exam>> getExams() async {
    final response = await _client.get('/api/v1/exams');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Exam.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Exam> getExamDetails(String examId) async {
    final response = await _client.get('/api/v1/exams/$examId');
    return Exam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<Exam> createExam({
    required String classId,
    required String name,
    String? startDate,
    String? endDate,
  }) async {
    final response = await _client.post('/api/v1/exams', data: {
      'classId': classId,
      'name': name,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
    });
    return Exam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<ExamSubject> addExamSubject({
    required String examId,
    required String subjectId,
    String? examDate,
    double? maxMarks,
  }) async {
    final response = await _client.post('/api/v1/exams/$examId/subjects', data: {
      'subjectId': subjectId,
      if (examDate != null) 'examDate': examDate,
      if (maxMarks != null) 'maxMarks': maxMarks,
    });
    return ExamSubject.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<void> submitMarks(String subjectId, List<Map<String, dynamic>> results) async {
    await _client.post('/api/v1/exams/subjects/$subjectId/marks', data: {
      'results': results,
    });
  }

  Future<List<Map<String, dynamic>>> getStudentReportCard(String studentId) async {
    final response = await _client.get('/api/v1/exams/student/$studentId/report-card');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }
}

final examsRepositoryProvider = Provider<ExamsRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return ExamsRepository(client.dio);
});

final examsProvider = FutureProvider<List<Exam>>((ref) {
  return ref.watch(examsRepositoryProvider).getExams();
});

final examDetailsProvider = FutureProvider.family<Exam, String>((ref, examId) {
  return ref.watch(examsRepositoryProvider).getExamDetails(examId);
});

final studentReportCardProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, studentId) {
  return ref.watch(examsRepositoryProvider).getStudentReportCard(studentId);
});
