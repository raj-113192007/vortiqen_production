// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Asset _$AssetFromJson(Map<String, dynamic> json) => _Asset(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      depreciationRate: (json['depreciationRate'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'AVAILABLE',
      condition: json['condition'] as String? ?? 'GOOD',
      assignedToUser: json['assignedToUser'] as String?,
      location: json['location'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      assignedTo: json['assignedTo'] == null
          ? null
          : User.fromJson(json['assignedTo'] as Map<String, dynamic>),
      logs: (json['logs'] as List<dynamic>?)
              ?.map((e) => AssetLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AssetToJson(_Asset instance) => <String, dynamic>{
      'id': instance.id,
      'schoolId': instance.schoolId,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'sku': instance.sku,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'depreciationRate': instance.depreciationRate,
      'status': instance.status,
      'condition': instance.condition,
      'assignedToUser': instance.assignedToUser,
      'location': instance.location,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'assignedTo': instance.assignedTo,
      'logs': instance.logs,
    };

_AssetLog _$AssetLogFromJson(Map<String, dynamic> json) => _AssetLog(
      id: json['id'] as String,
      assetId: json['assetId'] as String,
      action: json['action'] as String,
      userId: json['userId'] as String?,
      adminId: json['adminId'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AssetLogToJson(_AssetLog instance) => <String, dynamic>{
      'id': instance.id,
      'assetId': instance.assetId,
      'action': instance.action,
      'userId': instance.userId,
      'adminId': instance.adminId,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
