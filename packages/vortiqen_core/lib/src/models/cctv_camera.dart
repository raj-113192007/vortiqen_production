import 'package:freezed_annotation/freezed_annotation.dart';

part 'cctv_camera.freezed.dart';
part 'cctv_camera.g.dart';

@freezed
abstract class CctvCamera with _$CctvCamera {
  const factory CctvCamera({
    required String id,
    required String schoolId,
    required String name,
    required String location,
    required String streamUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CctvCamera;

  factory CctvCamera.fromJson(Map<String, dynamic> json) => _$CctvCameraFromJson(json);
}
