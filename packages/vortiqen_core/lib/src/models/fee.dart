import 'student.dart';

class FeeCategory {
  final String id;
  final String schoolId;
  final String name;
  final double amount;

  FeeCategory({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.amount,
  });

  factory FeeCategory.fromJson(Map<String, dynamic> json) {
    return FeeCategory(
      id: json['id'],
      schoolId: json['schoolId'],
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
    );
  }
}

class FeeLedger {
  final String id;
  final String schoolId;
  final String studentId;
  final String categoryId;
  final DateTime dueDate;
  final double amountDue;
  final double amountPaid;
  final String status;
  
  final Student? student;
  final FeeCategory? category;

  FeeLedger({
    required this.id,
    required this.schoolId,
    required this.studentId,
    required this.categoryId,
    required this.dueDate,
    required this.amountDue,
    required this.amountPaid,
    required this.status,
    this.student,
    this.category,
  });

  factory FeeLedger.fromJson(Map<String, dynamic> json) {
    return FeeLedger(
      id: json['id'],
      schoolId: json['schoolId'],
      studentId: json['studentId'],
      categoryId: json['categoryId'],
      dueDate: DateTime.parse(json['dueDate']),
      amountDue: (json['amountDue'] as num).toDouble(),
      amountPaid: (json['amountPaid'] as num).toDouble(),
      status: json['status'],
      student: json['student'] != null ? Student.fromJson(json['student']) : null,
      category: json['category'] != null ? FeeCategory.fromJson(json['category']) : null,
    );
  }
}

class FeePayment {
  final String id;
  final String schoolId;
  final String studentId;
  final String ledgerId;
  final double amountPaid;
  final DateTime paymentDate;
  final String paymentMethod;
  final String? receiptNo;

  FeePayment({
    required this.id,
    required this.schoolId,
    required this.studentId,
    required this.ledgerId,
    required this.amountPaid,
    required this.paymentDate,
    required this.paymentMethod,
    this.receiptNo,
  });

  factory FeePayment.fromJson(Map<String, dynamic> json) {
    return FeePayment(
      id: json['id'],
      schoolId: json['schoolId'],
      studentId: json['studentId'],
      ledgerId: json['ledgerId'],
      amountPaid: (json['amountPaid'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: json['paymentMethod'],
      receiptNo: json['receiptNo'],
    );
  }
}
