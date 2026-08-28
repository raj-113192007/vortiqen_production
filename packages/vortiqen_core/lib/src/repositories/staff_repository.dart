import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class StaffRepository {
  StaffRepository();

  Future<List<User>> getStaff(String schoolId, {String? role}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', email: 'priya.verma@school.edu', status: 'ACTIVE', phone: '+91 98111 22334'),
      User(id: 'u_t2', name: 'Prof. Alok Mukherjee', role: 'TEACHER', email: 'alok.m@school.edu', status: 'ACTIVE', phone: '+91 98222 33445'),
      User(id: 'u_t3', name: 'Dr. Sunita Rao', role: 'TEACHER', email: 'sunita.rao@school.edu', status: 'ACTIVE', phone: '+91 98333 44556'),
      User(id: 'u_d1', name: 'Ramesh Kumar (Route 04)', role: 'DRIVER', email: 'ramesh.bus@school.edu', status: 'ACTIVE', phone: '+91 98444 55667'),
      User(id: 'u_a1', name: 'Principal Sharma', role: 'SCHOOL_ADMIN', email: 'principal@school.edu', status: 'ACTIVE', phone: '+91 98555 66778'),
    ];
  }

  Future<User> createStaff(Map<String, dynamic> staffData) async {
    return User(
      id: 'u_new',
      name: staffData['name'] ?? 'New Staff',
      role: staffData['role'] ?? 'TEACHER',
      email: staffData['email'] ?? 'staff@school.edu',
      status: 'ACTIVE',
    );
  }
}

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  return StaffRepository();
});

final staffProvider = FutureProvider.family<List<User>, String>((ref, schoolId) {
  return ref.watch(staffRepositoryProvider).getStaff(schoolId);
});
