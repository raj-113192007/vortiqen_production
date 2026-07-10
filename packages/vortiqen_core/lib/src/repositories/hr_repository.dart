import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr.dart';
import 'package:dio/dio.dart';
import 'auth_repository.dart';

class HrRepository {
  final Dio _dio;

  HrRepository(this._dio);

  Future<List<Employee>> getEmployees() async {
    final res = await _dio.get('/hr/employees');
    return (res.data as List).map((e) => Employee.fromJson(e)).toList();
  }

  Future<Employee> getMyEmployeeProfile() async {
    final res = await _dio.get('/hr/employees/me');
    return Employee.fromJson(res.data);
  }

  Future<Employee> createEmployee({
    required String userId,
    required String designation,
    String? department,
    double? baseSalary,
    DateTime? joinDate,
  }) async {
    final res = await _dio.post('/hr/employees', data: {
      'userId': userId,
      'designation': designation,
      'department': department,
      'baseSalary': baseSalary,
      'joinDate': joinDate?.toIso8601String(),
    });
    return Employee.fromJson(res.data);
  }

  Future<List<Payroll>> getPayrolls(int month, int year) async {
    final res = await _dio.get('/hr/payroll', queryParameters: {
      'month': month,
      'year': year,
    });
    return (res.data as List).map((p) => Payroll.fromJson(p)).toList();
  }

  Future<List<Payroll>> getMyPayrolls() async {
    final res = await _dio.get('/hr/payroll/me');
    return (res.data as List).map((p) => Payroll.fromJson(p)).toList();
  }

  Future<void> generatePayroll(int month, int year) async {
    await _dio.post('/hr/payroll/generate', data: {
      'month': month,
      'year': year,
    });
  }

  Future<void> markPayrollAsPaid(String payrollId) async {
    await _dio.patch('/hr/payroll/$payrollId/pay');
  }
}

final hrRepositoryProvider = Provider<HrRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HrRepository(dio);
});

final employeesProvider = FutureProvider<List<Employee>>((ref) {
  final repo = ref.watch(hrRepositoryProvider);
  return repo.getEmployees();
});

final myEmployeeProfileProvider = FutureProvider<Employee>((ref) {
  final repo = ref.watch(hrRepositoryProvider);
  return repo.getMyEmployeeProfile();
});

final payrollsProvider = FutureProvider.family<List<Payroll>, Map<String, int>>((ref, args) {
  final repo = ref.watch(hrRepositoryProvider);
  return repo.getPayrolls(args['month']!, args['year']!);
});

final myPayrollsProvider = FutureProvider<List<Payroll>>((ref) {
  final repo = ref.watch(hrRepositoryProvider);
  return repo.getMyPayrolls();
});
