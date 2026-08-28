import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository();
});

final classAttendanceProvider = FutureProvider.family<List<Attendance>, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(attendanceRepositoryProvider);
  return repo.getAttendanceByClass(
    params['classId'] ?? 'cls_10',
    params['sectionId'] ?? 'sec_10a',
    params['date'] ?? '2026-08-27',
  );
});

final studentAttendanceProvider = FutureProvider.family<List<Attendance>, String>((ref, studentId) async {
  final repo = ref.read(attendanceRepositoryProvider);
  return repo.getAttendanceByStudent(studentId);
});

class AttendanceRepository {
  AttendanceRepository();

  Future<List<Attendance>> getAttendanceByClass(String classId, String sectionId, String date) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Attendance(
        id: 'att_01',
        schoolId: 'sch_01',
        studentId: 'stu_01',
        date: DateTime.now(),
        status: 'PRESENT',
        remarks: 'On time',
      ),
      Attendance(
        id: 'att_02',
        schoolId: 'sch_01',
        studentId: 'stu_02',
        date: DateTime.now(),
        status: 'PRESENT',
        remarks: 'On time',
      ),
      Attendance(
        id: 'att_03',
        schoolId: 'sch_01',
        studentId: 'stu_03',
        date: DateTime.now(),
        status: 'ABSENT',
        remarks: 'Sick leave informed',
      ),
      Attendance(
        id: 'att_04',
        schoolId: 'sch_01',
        studentId: 'stu_04',
        date: DateTime.now(),
        status: 'PRESENT',
        remarks: 'On time',
      ),
      Attendance(
        id: 'att_05',
        schoolId: 'sch_01',
        studentId: 'stu_05',
        date: DateTime.now(),
        status: 'PRESENT',
        remarks: 'On time',
      ),
    ];
  }

  Future<List<Attendance>> getAttendanceByStudent(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Attendance(
        id: 'att_01',
        schoolId: 'sch_01',
        studentId: studentId,
        date: DateTime.now(),
        status: 'PRESENT',
        remarks: 'Present - Regular Class',
      ),
      Attendance(
        id: 'att_02',
        schoolId: 'sch_01',
        studentId: studentId,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: 'PRESENT',
        remarks: 'Present - Science Lab',
      ),
      Attendance(
        id: 'att_03',
        schoolId: 'sch_01',
        studentId: studentId,
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'PRESENT',
        remarks: 'Present - Sports Period',
      ),
      Attendance(
        id: 'att_04',
        schoolId: 'sch_01',
        studentId: studentId,
        date: DateTime.now().subtract(const Duration(days: 3)),
        status: 'ABSENT',
        remarks: 'Medical Leave',
      ),
    ];
  }

  Future<void> markAttendance(String date, List<Map<String, dynamic>> studentStatuses, String markedById) async {}
}
