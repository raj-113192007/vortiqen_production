import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr.dart';
import '../models/user.dart';

class HrRepository {
  HrRepository();

  Future<List<Employee>> getEmployees() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Employee(
        id: 'emp_01',
        schoolId: 'sch_01',
        userId: 'u_t1',
        designation: 'Senior Faculty - HOD Science',
        department: 'Academics',
        baseSalary: 65000,
        joinDate: DateTime(2021, 6, 15),
        status: 'ACTIVE',
        user: User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Employee(
        id: 'emp_02',
        schoolId: 'sch_01',
        userId: 'u_t2',
        designation: 'Associate Professor',
        department: 'Physics',
        baseSalary: 58000,
        joinDate: DateTime(2022, 4, 1),
        status: 'ACTIVE',
        user: User(id: 'u_t2', name: 'Prof. Alok Mukherjee', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Employee(
        id: 'emp_03',
        schoolId: 'sch_01',
        userId: 'u_d1',
        designation: 'Senior Fleet Pilot',
        department: 'Transport',
        baseSalary: 32000,
        joinDate: DateTime(2020, 8, 10),
        status: 'ACTIVE',
        user: User(id: 'u_d1', name: 'Ramesh Kumar (Route 04)', role: 'DRIVER', status: 'ACTIVE'),
      ),
    ];
  }

  Future<Employee> getMyEmployeeProfile() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return Employee(
      id: 'emp_01',
      schoolId: 'sch_01',
      userId: 'u_t1',
      designation: 'Senior Faculty - HOD Science',
      department: 'Academics',
      baseSalary: 65000,
      joinDate: DateTime(2021, 6, 15),
      status: 'ACTIVE',
      user: User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', status: 'ACTIVE'),
    );
  }

  Future<List<Payroll>> getPayrolls(int month, int year) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Payroll(
        id: 'pay_01',
        schoolId: 'sch_01',
        employeeId: 'emp_01',
        month: month,
        year: year,
        baseSalary: 65000,
        allowances: 8000,
        deductions: 3500,
        netPay: 69500,
        status: 'PAID',
        paymentDate: DateTime.now(),
        employee: Employee(
          id: 'emp_01',
          schoolId: 'sch_01',
          userId: 'u_t1',
          designation: 'HOD Science',
          baseSalary: 65000,
          joinDate: DateTime(2021, 6, 15),
          status: 'ACTIVE',
          user: User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', status: 'ACTIVE'),
        ),
      ),
    ];
  }

  Future<List<Payroll>> getMyPayrolls() async {
    return getPayrolls(DateTime.now().month, DateTime.now().year);
  }

  Future<Employee> createEmployee({
    required String userId,
    required String designation,
    String? department,
    double? baseSalary,
    DateTime? joinDate,
  }) async {
    return Employee(
      id: 'emp_new',
      schoolId: 'sch_01',
      userId: userId,
      designation: designation,
      department: department,
      baseSalary: baseSalary ?? 50000,
      joinDate: joinDate ?? DateTime.now(),
      status: 'ACTIVE',
      user: User(id: userId, name: 'New Employee', role: 'TEACHER', status: 'ACTIVE'),
    );
  }

  Future<void> generatePayroll(int month, int year) async {}
  Future<void> markPayrollAsPaid(String payrollId) async {}
}

final hrRepositoryProvider = Provider<HrRepository>((ref) {
  return HrRepository();
});

final employeesProvider = FutureProvider<List<Employee>>((ref) {
  return ref.watch(hrRepositoryProvider).getEmployees();
});

final myEmployeeProfileProvider = FutureProvider<Employee>((ref) {
  return ref.watch(hrRepositoryProvider).getMyEmployeeProfile();
});

final payrollsProvider = FutureProvider.family<List<Payroll>, Map<String, int>>((ref, args) {
  return ref.watch(hrRepositoryProvider).getPayrolls(args['month'] ?? 8, args['year'] ?? 2026);
});

final myPayrollsProvider = FutureProvider<List<Payroll>>((ref) {
  return ref.watch(hrRepositoryProvider).getMyPayrolls();
});
