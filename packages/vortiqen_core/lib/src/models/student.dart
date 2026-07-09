import 'user.dart';
import 'route.dart';
import 'vehicle.dart';

class Student {
  final String id;
  final String schoolId;
  final String? sectionId;
  final String rollNo;
  final String firstName;
  final String? lastName;
  final String? routeId;
  final String? vehicleId;
  final User? user;
  final User? parent;
  final Route? route;
  final Vehicle? vehicle;

  Student({
    required this.id,
    required this.schoolId,
    this.sectionId,
    required this.rollNo,
    required this.firstName,
    this.lastName,
    this.routeId,
    this.vehicleId,
    this.user,
    this.parent,
    this.route,
    this.vehicle,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      schoolId: json['schoolId'],
      sectionId: json['sectionId'],
      rollNo: json['rollNo'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      routeId: json['routeId'],
      vehicleId: json['vehicleId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      parent: json['parent'] != null ? User.fromJson(json['parent']) : null,
      route: json['route'] != null ? Route.fromJson(json['route']) : null,
      vehicle: json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
    );
  }
}
