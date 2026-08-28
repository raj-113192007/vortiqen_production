import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../models/assignment.dart';

class AssignmentsRepository {
  AssignmentsRepository();

  Future<List<Assignment>> getAssignmentsForSection(String sectionId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Assignment(
        id: 'asg_01',
        schoolId: 'sch_01',
        sectionId: sectionId,
        subjectId: 'sub_01',
        teacherId: 'u_t1',
        title: 'Trigonometry & Calculus Problem Set 4',
        description: 'Complete questions 1 to 25 from Chapter 7 textbook and upload clear handwritten scans.',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        subjectName: 'Advanced Mathematics',
        teacherName: 'Dr. Priya Verma',
      ),
      Assignment(
        id: 'asg_02',
        schoolId: 'sch_01',
        sectionId: sectionId,
        subjectId: 'sub_02',
        teacherId: 'u_t2',
        title: 'Optics & Ray Diagram Lab Worksheet',
        description: 'Draw concave and convex mirror diagrams with experimental focal length calculations.',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        subjectName: 'Physics & Dynamics',
        teacherName: 'Prof. Alok Mukherjee',
      ),
    ];
  }

  Future<List<Assignment>> getAssignmentsForTeacher() async {
    return getAssignmentsForSection('sec_10a');
  }

  Future<Assignment> createAssignment({
    required String sectionId,
    required String subjectId,
    required String title,
    required String dueDate,
    String? description,
    PlatformFile? file,
  }) async {
    return Assignment(
      id: 'asg_new',
      schoolId: 'sch_01',
      sectionId: sectionId,
      subjectId: subjectId,
      teacherId: 'u_t1',
      title: title,
      description: description,
      dueDate: DateTime.parse(dueDate),
      createdAt: DateTime.now(),
      subjectName: 'Subject',
      teacherName: 'Dr. Priya Verma',
    );
  }

  Future<AssignmentSubmission> submitAssignment({
    required String assignmentId,
    required String studentId,
    String? content,
    PlatformFile? file,
  }) async {
    return AssignmentSubmission(
      id: 'sub_new',
      assignmentId: assignmentId,
      studentId: studentId,
      content: content,
      status: 'SUBMITTED',
      createdAt: DateTime.now(),
      studentName: 'Aarav Sharma',
      studentRollNo: '101',
    );
  }

  Future<List<AssignmentSubmission>> getSubmissions(String assignmentId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      AssignmentSubmission(
        id: 'sub_01',
        assignmentId: assignmentId,
        studentId: 'stu_01',
        content: 'Completed all 25 questions with proofs attached.',
        status: 'GRADED',
        grade: 'A+',
        teacherNotes: 'Excellent working and clear steps!',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        studentName: 'Aarav Sharma',
        studentRollNo: '101',
      ),
      AssignmentSubmission(
        id: 'sub_02',
        assignmentId: assignmentId,
        studentId: 'stu_02',
        content: 'Attached PDF worksheet.',
        status: 'SUBMITTED',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        studentName: 'Ananya Iyer',
        studentRollNo: '102',
      ),
    ];
  }

  Future<void> gradeSubmission({
    required String submissionId,
    required String grade,
    String? teacherNotes,
  }) async {}
}

final assignmentsRepositoryProvider = Provider<AssignmentsRepository>((ref) {
  return AssignmentsRepository();
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
