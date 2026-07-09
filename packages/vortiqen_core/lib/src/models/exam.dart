class Exam {
  final String id;
  final String schoolId;
  final String classId;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final DateTime createdAt;

  final String? className;
  final List<ExamSubject> subjects;

  Exam({
    required this.id,
    required this.schoolId,
    required this.classId,
    required this.name,
    this.startDate,
    this.endDate,
    required this.status,
    required this.createdAt,
    this.className,
    this.subjects = const [],
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      schoolId: json['schoolId'],
      classId: json['classId'],
      name: json['name'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      className: json['academicClass']?['name'],
      subjects: (json['examSubjects'] as List<dynamic>?)
              ?.map((e) => ExamSubject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExamSubject {
  final String id;
  final String examId;
  final String subjectId;
  final DateTime? examDate;
  final double maxMarks;
  
  final String? subjectName;
  final List<ExamResult> results;

  ExamSubject({
    required this.id,
    required this.examId,
    required this.subjectId,
    this.examDate,
    required this.maxMarks,
    this.subjectName,
    this.results = const [],
  });

  factory ExamSubject.fromJson(Map<String, dynamic> json) {
    return ExamSubject(
      id: json['id'],
      examId: json['examId'],
      subjectId: json['subjectId'],
      examDate: json['examDate'] != null ? DateTime.parse(json['examDate']) : null,
      maxMarks: (json['maxMarks'] as num).toDouble(),
      subjectName: json['subject']?['name'],
      results: (json['examResults'] as List<dynamic>?)
              ?.map((e) => ExamResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExamResult {
  final String id;
  final String examSubjectId;
  final String studentId;
  final double? marksObtained;
  final String? grade;
  final String? remarks;

  final String? studentName;
  final String? studentRollNo;

  ExamResult({
    required this.id,
    required this.examSubjectId,
    required this.studentId,
    this.marksObtained,
    this.grade,
    this.remarks,
    this.studentName,
    this.studentRollNo,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    final student = json['student'];
    final name = student != null ? '${student['firstName']} ${student['lastName'] ?? ''}'.trim() : null;

    return ExamResult(
      id: json['id'],
      examSubjectId: json['examSubjectId'],
      studentId: json['studentId'],
      marksObtained: json['marksObtained'] != null ? (json['marksObtained'] as num).toDouble() : null,
      grade: json['grade'],
      remarks: json['remarks'],
      studentName: name,
      studentRollNo: student?['rollNo'],
    );
  }
}
