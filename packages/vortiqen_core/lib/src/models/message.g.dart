// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  schoolId: json['schoolId'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isRead: json['isRead'] as bool? ?? false,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'schoolId': instance.schoolId,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'isRead': instance.isRead,
};

_ChatContact _$ChatContactFromJson(Map<String, dynamic> json) => _ChatContact(
  id: json['id'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
  details: json['details'] as String?,
);

Map<String, dynamic> _$ChatContactToJson(_ChatContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'details': instance.details,
    };
