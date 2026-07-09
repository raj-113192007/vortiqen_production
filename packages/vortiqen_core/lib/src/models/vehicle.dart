import 'user.dart';
import 'route.dart';
import 'student.dart';

class Vehicle {
  final String id;
  final String schoolId;
  final String plateNumber;
  final int capacity;
  final String? routeId;
  final User? driver;
  final Route? route;
  final List<Student> students;

  Vehicle({
    required this.id,
    required this.schoolId,
    required this.plateNumber,
    required this.capacity,
    this.routeId,
    this.driver,
    this.route,
    this.students = const [],
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      schoolId: json['schoolId'],
      plateNumber: json['plateNumber'],
      capacity: json['capacity'],
      routeId: json['routeId'],
      driver: json['driver'] != null ? User.fromJson(json['driver']) : null,
      route: json['route'] != null ? Route.fromJson(json['route']) : null,
      students: (json['students'] as List<dynamic>?)
              ?.map((s) => Student.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
