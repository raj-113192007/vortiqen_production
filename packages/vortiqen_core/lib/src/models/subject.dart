import 'user.dart';

class Subject {
  final String id;
  final String name;
  final String classId;
  final String schoolId;
  final User? teacher;

  Subject({
    required this.id,
    required this.name,
    required this.classId,
    required this.schoolId,
    this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      classId: json['classId'],
      schoolId: json['schoolId'],
      teacher: json['teacher'] != null ? User.fromJson(json['teacher']) : null,
    );
  }
}
