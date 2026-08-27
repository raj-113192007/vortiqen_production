import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/route.dart';
import '../models/vehicle.dart';
import '../models/student.dart';

class TransportRepository {
  TransportRepository();

  Future<List<Route>> getRoutes() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return [
      Route(id: 'r_01', name: 'Route 01: North Campus Express', schoolId: 'sch_01'),
      Route(id: 'r_02', name: 'Route 02: City Center & Civil Lines', schoolId: 'sch_01'),
      Route(id: 'r_03', name: 'Route 03: Green Park & Ring Road', schoolId: 'sch_01'),
      Route(id: 'r_04', name: 'Route 04: Sector 14 to Main Gate', schoolId: 'sch_01'),
    ];
  }

  Future<List<Vehicle>> getVehicles() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return [
      Vehicle(id: 'v_01', plateNumber: 'DL 01 AB 1234', capacity: 32, schoolId: 'sch_01'),
      Vehicle(id: 'v_02', plateNumber: 'DL 01 CD 5678', capacity: 40, schoolId: 'sch_01'),
      Vehicle(id: 'v_03', plateNumber: 'DL 01 EF 9012', capacity: 28, schoolId: 'sch_01'),
    ];
  }

  Future<Vehicle> getDriverTransportDetails() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return Vehicle(
      id: 'v_04',
      plateNumber: 'DL 01 PB 4488',
      capacity: 36,
      schoolId: 'sch_01',
      route: Route(id: 'r_04', name: 'Route 04: Sector 14 to Campus', schoolId: 'sch_01'),
      students: [
        Student(id: 's_01', firstName: 'Aarav', lastName: 'Sharma', rollNo: '101', schoolId: 'sch_01'),
        Student(id: 's_02', firstName: 'Ananya', lastName: 'Iyer', rollNo: '102', schoolId: 'sch_01'),
        Student(id: 's_03', firstName: 'Rohan', lastName: 'Mehta', rollNo: '103', schoolId: 'sch_01'),
        Student(id: 's_04', firstName: 'Diya', lastName: 'Patel', rollNo: '104', schoolId: 'sch_01'),
      ],
    );
  }
}

final transportRepositoryProvider = Provider<TransportRepository>((ref) {
  return TransportRepository();
});

final routesProvider = FutureProvider<List<Route>>((ref) {
  return ref.watch(transportRepositoryProvider).getRoutes();
});

final vehiclesProvider = FutureProvider<List<Vehicle>>((ref) {
  return ref.watch(transportRepositoryProvider).getVehicles();
});

final driverTransportProvider = FutureProvider<Vehicle>((ref) {
  return ref.watch(transportRepositoryProvider).getDriverTransportDetails();
});

final studentTransportProvider = FutureProvider.family<Student, String>((ref, studentId) async {
  await Future.delayed(const Duration(milliseconds: 150));
  return Student(
    id: studentId,
    firstName: 'Aarav',
    lastName: 'Sharma',
    rollNo: '101',
    schoolId: 'sch_01',
    route: Route(id: 'r_04', name: 'Route 04: Sector 14 to Campus', schoolId: 'sch_01'),
    vehicle: Vehicle(id: 'v_04', plateNumber: 'DL 01 PB 4488', capacity: 36, schoolId: 'sch_01'),
  );
});
