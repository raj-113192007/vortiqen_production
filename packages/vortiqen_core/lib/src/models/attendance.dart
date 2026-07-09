import 'student.dart';

class Attendance {
  final String id;
  final String schoolId;
  final String studentId;
  final DateTime date;
  final String status;
  final String? markedById;
  final String? remarks;
  
  final Student? student;

  Attendance({
    required this.id,
    required this.schoolId,
    required this.studentId,
    required this.date,
    required this.status,
    this.markedById,
    this.remarks,
    this.student,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      schoolId: json['schoolId'],
      studentId: json['studentId'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      markedById: json['markedById'],
      remarks: json['remarks'],
      student: json['student'] != null ? Student.fromJson(json['student']) : null,
    );
  }
}
