import 'user.dart';

class ChatGroup {
  final String id;
  final String schoolId;
  final String name;
  final bool isGroup;
  final DateTime createdAt;

  const ChatGroup({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.isGroup,
    required this.createdAt,
  });

  factory ChatGroup.fromJson(Map<String, dynamic> json) {
    return ChatGroup(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      name: json['name'] as String,
      isGroup: json['isGroup'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class ChatMessage {
  final String id;
  final String schoolId;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final User? sender;
  final User? receiver;

  const ChatMessage({
    required this.id,
    required this.schoolId,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    required this.createdAt,
    this.isRead = false,
    this.sender,
    this.receiver,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String?,
      groupId: json['groupId'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? User.fromJson(json['receiver']) : null,
    );
  }
}
