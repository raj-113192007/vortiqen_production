import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exam.dart';

class ExamsRepository {
  ExamsRepository();

  Future<List<Exam>> getExams() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Exam(
        id: 'ex_01',
        schoolId: 'sch_01',
        classId: 'cls_10',
        name: 'Mid-Term Summative Assessment (2026)',
        startDate: DateTime.now().add(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 20)),
        status: 'SCHEDULED',
        createdAt: DateTime.now(),
        subjects: [
          ExamSubject(id: 'es_01', examId: 'ex_01', subjectId: 'sub_01', examDate: DateTime.now().add(const Duration(days: 10)), maxMarks: 100),
          ExamSubject(id: 'es_02', examId: 'ex_01', subjectId: 'sub_02', examDate: DateTime.now().add(const Duration(days: 12)), maxMarks: 100),
          ExamSubject(id: 'es_03', examId: 'ex_01', subjectId: 'sub_03', examDate: DateTime.now().add(const Duration(days: 15)), maxMarks: 100),
        ],
      ),
      Exam(
        id: 'ex_02',
        schoolId: 'sch_01',
        classId: 'cls_10',
        name: 'Periodic Unit Test 1',
        startDate: DateTime.now().subtract(const Duration(days: 40)),
        endDate: DateTime.now().subtract(const Duration(days: 35)),
        status: 'COMPLETED',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ];
  }

  Future<Exam> getExamDetails(String examId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return Exam(
      id: examId,
      schoolId: 'sch_01',
      classId: 'cls_10',
      name: 'Mid-Term Summative Assessment (2026)',
      startDate: DateTime.now().add(const Duration(days: 10)),
      endDate: DateTime.now().add(const Duration(days: 20)),
      status: 'SCHEDULED',
      createdAt: DateTime.now(),
    );
  }

  Future<Exam> createExam({
    required String classId,
    required String name,
    String? startDate,
    String? endDate,
  }) async {
    return Exam(
      id: 'ex_new',
      schoolId: 'sch_01',
      classId: classId,
      name: name,
      status: 'SCHEDULED',
      createdAt: DateTime.now(),
    );
  }

  Future<ExamSubject> addExamSubject({
    required String examId,
    required String subjectId,
    String? examDate,
    double? maxMarks,
  }) async {
    return ExamSubject(
      id: 'es_new',
      examId: examId,
      subjectId: subjectId,
      maxMarks: maxMarks ?? 100,
    );
  }

  Future<void> submitMarks(String subjectId, List<Map<String, dynamic>> results) async {}

  Future<List<Map<String, dynamic>>> getStudentReportCard(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      {'subject': 'Advanced Mathematics', 'marks': 96, 'total': 100, 'grade': 'A+'},
      {'subject': 'Physics & Dynamics', 'marks': 89, 'total': 100, 'grade': 'A'},
      {'subject': 'Chemistry & Lab', 'marks': 92, 'total': 100, 'grade': 'A+'},
      {'subject': 'Computer Science', 'marks': 98, 'total': 100, 'grade': 'O'},
      {'subject': 'English Literature', 'marks': 88, 'total': 100, 'grade': 'A'},
    ];
  }
}

final examsRepositoryProvider = Provider<ExamsRepository>((ref) {
  return ExamsRepository();
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
