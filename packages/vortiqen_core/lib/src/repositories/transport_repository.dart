import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/route.dart';
import '../models/vehicle.dart';
import '../models/student.dart';
import '../api/api_client.dart';

class TransportRepository {
  final Dio _client;

  TransportRepository(this._client);

  Future<List<Route>> getRoutes() async {
    final response = await _client.get('/api/v1/transport/routes');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Route> createRoute(String name) async {
    final response = await _client.post('/api/v1/transport/routes', data: {
      'name': name,
    });
    return Route.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<List<Vehicle>> getVehicles() async {
    final response = await _client.get('/api/v1/transport/vehicles');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Vehicle.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Vehicle> createVehicle({
    required String plateNumber,
    required int capacity,
    String? driverId,
    String? routeId,
  }) async {
    final response = await _client.post('/api/v1/transport/vehicles', data: {
      'plateNumber': plateNumber,
      'capacity': capacity,
      if (driverId != null) 'driverId': driverId,
      if (routeId != null) 'routeId': routeId,
    });
    return Vehicle.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<void> assignStudent({
    required String studentId,
    String? routeId,
    String? vehicleId,
  }) async {
    await _client.post('/api/v1/transport/assign', data: {
      'studentId': studentId,
      if (routeId != null) 'routeId': routeId,
      if (vehicleId != null) 'vehicleId': vehicleId,
    });
  }

  Future<Student> getStudentTransportDetails(String studentId) async {
    final response = await _client.get('/api/v1/transport/student/$studentId');
    return Student.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<Vehicle> getDriverTransportDetails() async {
    final response = await _client.get('/api/v1/transport/driver/my-details');
    return Vehicle.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}

final transportRepositoryProvider = Provider<TransportRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return TransportRepository(client.dio);
});

final routesProvider = FutureProvider<List<Route>>((ref) {
  return ref.watch(transportRepositoryProvider).getRoutes();
});

final vehiclesProvider = FutureProvider<List<Vehicle>>((ref) {
  return ref.watch(transportRepositoryProvider).getVehicles();
});

final studentTransportProvider = FutureProvider.family<Student, String>((ref, studentId) {
  return ref.watch(transportRepositoryProvider).getStudentTransportDetails(studentId);
});

final driverTransportProvider = FutureProvider<Vehicle>((ref) {
  return ref.watch(transportRepositoryProvider).getDriverTransportDetails();
});
