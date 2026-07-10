class AdmissionEnquiry {
  final String id;
  final String schoolId;
  final String parentName;
  final String studentName;
  final String? email;
  final String phone;
  final String? classApplied;
  final String status;
  final DateTime? interviewDate;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AdmissionEnquiry({
    required this.id,
    required this.schoolId,
    required this.parentName,
    required this.studentName,
    this.email,
    required this.phone,
    this.classApplied,
    this.status = 'PENDING',
    this.interviewDate,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory AdmissionEnquiry.fromJson(Map<String, dynamic> json) {
    return AdmissionEnquiry(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      parentName: json['parentName'] as String,
      studentName: json['studentName'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      classApplied: json['classApplied'] as String?,
      status: json['status'] as String? ?? 'PENDING',
      interviewDate: json['interviewDate'] != null
          ? DateTime.parse(json['interviewDate'] as String)
          : null,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'parentName': parentName,
      'studentName': studentName,
      'email': email,
      'phone': phone,
      'classApplied': classApplied,
      'status': status,
      'interviewDate': interviewDate?.toIso8601String(),
      'notes': notes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
