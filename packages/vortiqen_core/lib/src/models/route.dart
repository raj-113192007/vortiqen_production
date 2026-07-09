import 'vehicle.dart';

class Route {
  final String id;
  final String schoolId;
  final String name;
  final List<Vehicle> vehicles;

  Route({
    required this.id,
    required this.schoolId,
    required this.name,
    this.vehicles = const [],
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'],
      schoolId: json['schoolId'],
      name: json['name'],
      vehicles: (json['vehicles'] as List<dynamic>?)
              ?.map((v) => Vehicle.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
