import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/cctv_camera.dart';
import '../api/api_client.dart';

part 'cctv_repository.g.dart';

class CctvRepository {
  final Dio _dio;

  CctvRepository(this._dio);

  Future<List<CctvCamera>> getAllCameras() async {
    final response = await _dio.get('/cctv');
    return (response.data as List).map((json) => CctvCamera.fromJson(json)).toList();
  }

  Future<CctvCamera> addCamera(Map<String, dynamic> data) async {
    final response = await _dio.post('/cctv', data: data);
    return CctvCamera.fromJson(response.data);
  }

  Future<void> updateCamera(String id, Map<String, dynamic> data) async {
    await _dio.patch('/cctv/$id', data: data);
  }
}

@riverpod
CctvRepository cctvRepository(CctvRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return CctvRepository(dio);
}

@riverpod
Future<List<CctvCamera>> cctvCameras(CctvCamerasRef ref) {
  return ref.watch(cctvRepositoryProvider).getAllCameras();
}
