// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetCategory _$AssetCategoryFromJson(Map<String, dynamic> json) =>
    _AssetCategory(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AssetCategoryToJson(_AssetCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schoolId': instance.schoolId,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
