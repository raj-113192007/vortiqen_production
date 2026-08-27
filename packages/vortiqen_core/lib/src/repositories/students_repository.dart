import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/user.dart';
import '../api/api_client.dart';
import '../providers/auth_provider.dart';

class StudentsRepository {
  final Dio? _client;

  StudentsRepository([this._client]);

  Future<List<Student>> getStudents(String schoolId, {String? classId, String? sectionId, String? parentId, String? userId}) async {
    // Offline Standalone Mock Data
    await Future.delayed(const Duration(milliseconds: 200));

    return [
      Student(
        id: 'stu_01',
        schoolId: schoolId,
        rollNo: '101',
        firstName: 'Aarav',
        lastName: 'Sharma',
        user: User(id: 'u_01', name: 'Aarav Sharma', role: 'STUDENT', status: 'ACTIVE'),
      ),
      Student(
        id: 'stu_02',
        schoolId: schoolId,
        rollNo: '102',
        firstName: 'Ananya',
        lastName: 'Iyer',
        user: User(id: 'u_02', name: 'Ananya Iyer', role: 'STUDENT', status: 'ACTIVE'),
      ),
      Student(
        id: 'stu_03',
        schoolId: schoolId,
        rollNo: '103',
        firstName: 'Rohan',
        lastName: 'Mehta',
        user: User(id: 'u_03', name: 'Rohan Mehta', role: 'STUDENT', status: 'ACTIVE'),
      ),
      Student(
        id: 'stu_04',
        schoolId: schoolId,
        rollNo: '104',
        firstName: 'Diya',
        lastName: 'Patel',
        user: User(id: 'u_04', name: 'Diya Patel', role: 'STUDENT', status: 'ACTIVE'),
      ),
      Student(
        id: 'stu_05',
        schoolId: schoolId,
        rollNo: '105',
        firstName: 'Kabir',
        lastName: 'Kapoor',
        user: User(id: 'u_05', name: 'Kabir Kapoor', role: 'STUDENT', status: 'ACTIVE'),
      ),
    ];
  }

  Future<Student> createStudent(Map<String, dynamic> studentData) async {
    return Student(
      id: 'stu_new',
      schoolId: 'school_01',
      rollNo: '106',
      firstName: studentData['firstName'] ?? 'New',
      lastName: studentData['lastName'] ?? 'Student',
    );
  }
}

final studentsRepositoryProvider = Provider<StudentsRepository>((ref) {
  return StudentsRepository();
});

final studentsProvider = FutureProvider.family<List<Student>, String>((ref, schoolId) {
  return ref.watch(studentsRepositoryProvider).getStudents(schoolId);
});

final parentStudentsProvider = FutureProvider.family<List<Student>, Map<String, dynamic>>((ref, params) {
  return ref.watch(studentsRepositoryProvider).getStudents(
    params['schoolId'] as String,
    parentId: params['parentId'] as String?,
  );
});

final studentProfileProvider = FutureProvider.family<Student?, Map<String, dynamic>>((ref, params) async {
  final students = await ref.watch(studentsRepositoryProvider).getStudents(
    params['schoolId'] as String,
    userId: params['userId'] as String?,
  );
  return students.isNotEmpty ? students.first : null;
});

final studentListProvider = FutureProvider.family<List<Student>, Map<String, dynamic>>((ref, params) {
  final schoolId = ref.watch(authProvider).value?.user?.schoolId ?? 'school_01';
  return ref.watch(studentsRepositoryProvider).getStudents(
    schoolId,
    classId: params['classId'] as String?,
    sectionId: params['sectionId'] as String?,
  );
});
