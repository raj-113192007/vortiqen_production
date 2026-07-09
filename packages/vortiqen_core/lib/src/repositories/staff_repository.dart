import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../api/api_client.dart';

class StaffRepository {
  final Dio _client;

  StaffRepository(this._client);

  Future<List<User>> getStaff(String schoolId, {String? role}) async {
    final response = await _client.get('/api/v1/users', queryParameters: {
      'schoolId': schoolId,
      if (role != null) 'role': role,
    });
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<User> createStaff(Map<String, dynamic> staffData) async {
    final response = await _client.post('/api/v1/users', data: staffData);
    return User.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return StaffRepository(client);
});

final staffProvider = FutureProvider.family<List<User>, String>((ref, schoolId) {
  return ref.watch(staffRepositoryProvider).getStaff(schoolId);
});
