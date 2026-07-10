import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/attendance.dart';
import '../api/api_client.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(ref.read(apiClientProvider));
});

final classAttendanceProvider = FutureProvider.family<List<Attendance>, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(attendanceRepositoryProvider);
  return repo.getAttendanceByClass(
    params['classId'],
    params['sectionId'] ?? '',
    params['date'],
  );
});

final studentAttendanceProvider = FutureProvider.family<List<Attendance>, String>((ref, studentId) async {
  final repo = ref.read(attendanceRepositoryProvider);
  return repo.getAttendanceByStudent(studentId);
});

class AttendanceRepository {
  final ApiClient _apiClient;

  AttendanceRepository(this._apiClient);

  Future<List<Attendance>> getAttendanceByClass(String classId, String sectionId, String date) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/v1/attendance/class',
        queryParameters: {
          'classId': classId,
          'sectionId': sectionId,
          'date': date,
        },
      );
      return (response.data as List).map((x) => Attendance.fromJson(x)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch attendance');
    }
  }

  Future<List<Attendance>> getAttendanceByStudent(String studentId) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/v1/attendance/student',
        queryParameters: {
          'studentId': studentId,
        },
      );
      return (response.data as List).map((x) => Attendance.fromJson(x)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch student attendance');
    }
  }

  Future<void> markAttendance(String date, List<Map<String, dynamic>> studentStatuses, String markedById) async {
    try {
      await _apiClient.dio.post(
        '/api/v1/attendance',
        data: {
          'date': date,
          'studentStatuses': studentStatuses,
          'markedById': markedById,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to mark attendance');
    }
  }
}
