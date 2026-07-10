import 'user.dart';

class Employee {
  final String id;
  final String schoolId;
  final String userId;
  final String designation;
  final String? department;
  final double baseSalary;
  final DateTime joinDate;
  final String status;
  final User? user;

  const Employee({
    required this.id,
    required this.schoolId,
    required this.userId,
    required this.designation,
    this.department,
    required this.baseSalary,
    required this.joinDate,
    required this.status,
    this.user,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      userId: json['userId'] as String,
      designation: json['designation'] as String,
      department: json['department'] as String?,
      baseSalary: (json['baseSalary'] as num).toDouble(),
      joinDate: DateTime.parse(json['joinDate'] as String),
      status: json['status'] as String,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'userId': userId,
      'designation': designation,
      'department': department,
      'baseSalary': baseSalary,
      'joinDate': joinDate.toIso8601String(),
      'status': status,
      'user': user?.toJson(),
    };
  }
}

class Payroll {
  final String id;
  final String schoolId;
  final String employeeId;
  final int month;
  final int year;
  final double baseSalary;
  final double allowances;
  final double deductions;
  final double netPay;
  final String status;
  final DateTime? paymentDate;
  final Employee? employee;

  const Payroll({
    required this.id,
    required this.schoolId,
    required this.employeeId,
    required this.month,
    required this.year,
    required this.baseSalary,
    required this.allowances,
    required this.deductions,
    required this.netPay,
    required this.status,
    this.paymentDate,
    this.employee,
  });

  factory Payroll.fromJson(Map<String, dynamic> json) {
    return Payroll(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      employeeId: json['employeeId'] as String,
      month: json['month'] as int,
      year: json['year'] as int,
      baseSalary: (json['baseSalary'] as num).toDouble(),
      allowances: (json['allowances'] as num).toDouble(),
      deductions: (json['deductions'] as num).toDouble(),
      netPay: (json['netPay'] as num).toDouble(),
      status: json['status'] as String,
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate'] as String) : null,
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'employeeId': employeeId,
      'month': month,
      'year': year,
      'baseSalary': baseSalary,
      'allowances': allowances,
      'deductions': deductions,
      'netPay': netPay,
      'status': status,
      'paymentDate': paymentDate?.toIso8601String(),
      'employee': employee?.toJson(),
    };
  }
}
