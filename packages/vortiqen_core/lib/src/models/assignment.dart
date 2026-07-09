class Assignment {
  final String id;
  final String schoolId;
  final String sectionId;
  final String subjectId;
  final String teacherId;
  final String title;
  final String? description;
  final String? attachmentUrl;
  final DateTime dueDate;
  final DateTime createdAt;

  final String? subjectName;
  final String? teacherName;

  Assignment({
    required this.id,
    required this.schoolId,
    required this.sectionId,
    required this.subjectId,
    required this.teacherId,
    required this.title,
    this.description,
    this.attachmentUrl,
    required this.dueDate,
    required this.createdAt,
    this.subjectName,
    this.teacherName,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      schoolId: json['schoolId'],
      sectionId: json['sectionId'],
      subjectId: json['subjectId'],
      teacherId: json['teacherId'],
      title: json['title'],
      description: json['description'],
      attachmentUrl: json['attachmentUrl'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      subjectName: json['subject']?['name'],
      teacherName: json['teacher']?['name'],
    );
  }
}

class AssignmentSubmission {
  final String id;
  final String assignmentId;
  final String studentId;
  final String? content;
  final String? attachmentUrl;
  final String status;
  final String? grade;
  final String? teacherNotes;
  final DateTime createdAt;

  final String? studentName;
  final String? studentRollNo;

  AssignmentSubmission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    this.content,
    this.attachmentUrl,
    required this.status,
    this.grade,
    this.teacherNotes,
    required this.createdAt,
    this.studentName,
    this.studentRollNo,
  });

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) {
    final student = json['student'];
    final name = student != null ? '${student['firstName']} ${student['lastName'] ?? ''}'.trim() : null;
    
    return AssignmentSubmission(
      id: json['id'],
      assignmentId: json['assignmentId'],
      studentId: json['studentId'],
      content: json['content'],
      attachmentUrl: json['attachmentUrl'],
      status: json['status'],
      grade: json['grade'],
      teacherNotes: json['teacherNotes'],
      createdAt: DateTime.parse(json['createdAt']),
      studentName: name,
      studentRollNo: student?['rollNo'],
    );
  }
}
