import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cctv_camera.dart';

class CctvRepository {
  CctvRepository();

  Future<List<CctvCamera>> getAllCameras() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      CctvCamera(
        id: 'cam_01',
        schoolId: 'sch_01',
        name: 'Main Gate & Security Perimeter',
        location: 'Campus North Entrance',
        streamUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        status: 'ONLINE',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CctvCamera(
        id: 'cam_02',
        schoolId: 'sch_01',
        name: 'Academic Block Corridor A',
        location: 'Ground Floor Science Wing',
        streamUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        status: 'ONLINE',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CctvCamera(
        id: 'cam_03',
        schoolId: 'sch_01',
        name: 'Sports Ground & Pavilion',
        location: 'West Campus Athletic Field',
        streamUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        status: 'ONLINE',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  Future<CctvCamera> addCamera(Map<String, dynamic> data) async {
    return CctvCamera(
      id: 'cam_new',
      schoolId: 'sch_01',
      name: data['name'] ?? 'New Camera',
      location: data['location'] ?? 'Location',
      streamUrl: '',
      status: 'ONLINE',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> updateCamera(String id, Map<String, dynamic> data) async {}
}

final cctvRepositoryProvider = Provider<CctvRepository>((ref) {
  return CctvRepository();
});

final cctvCamerasProvider = FutureProvider<List<CctvCamera>>((ref) {
  return ref.watch(cctvRepositoryProvider).getAllCameras();
});
