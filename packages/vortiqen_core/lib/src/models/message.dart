import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String schoolId,
    required String senderId,
    required String receiverId,
    required String content,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

@freezed
class ChatContact with _$ChatContact {
  const factory ChatContact({
    required String id,
    required String name,
    required String role,
    String? details,
  }) = _ChatContact;

  factory ChatContact.fromJson(Map<String, dynamic> json) => _$ChatContactFromJson(json);
}
