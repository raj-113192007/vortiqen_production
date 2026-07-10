// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cctv_camera.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CctvCamera _$CctvCameraFromJson(Map<String, dynamic> json) => _CctvCamera(
  id: json['id'] as String,
  schoolId: json['schoolId'] as String,
  name: json['name'] as String,
  location: json['location'] as String,
  streamUrl: json['streamUrl'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CctvCameraToJson(_CctvCamera instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schoolId': instance.schoolId,
      'name': instance.name,
      'location': instance.location,
      'streamUrl': instance.streamUrl,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
