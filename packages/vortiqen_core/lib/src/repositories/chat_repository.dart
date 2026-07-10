import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat.dart';
import 'package:dio/dio.dart';
import '../api/api_client.dart';

class ChatRepository {
  final Dio _dio;

  ChatRepository(this._dio);

  Future<List<ChatGroup>> getMyGroups() async {
    final res = await _dio.get('/chat/groups');
    return (res.data as List).map((e) => ChatGroup.fromJson(e)).toList();
  }

  Future<ChatGroup> createGroup(String name) async {
    final res = await _dio.post('/chat/groups', data: {'name': name});
    return ChatGroup.fromJson(res.data);
  }

  Future<void> addMember(String groupId, String userId) async {
    await _dio.post('/chat/groups/$groupId/members', data: {'userId': userId});
  }

  Future<List<ChatMessage>> getGroupMessages(String groupId) async {
    final res = await _dio.get('/chat/groups/$groupId/messages');
    return (res.data as List).map((e) => ChatMessage.fromJson(e)).toList();
  }

  Future<List<ChatMessage>> getDirectMessages(String userId) async {
    final res = await _dio.get('/chat/direct/$userId/messages');
    return (res.data as List).map((e) => ChatMessage.fromJson(e)).toList();
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ChatRepository(dio);
});

final myGroupsProvider = FutureProvider<List<ChatGroup>>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getMyGroups();
});

final groupMessagesProvider = FutureProvider.family<List<ChatMessage>, String>((ref, groupId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getGroupMessages(groupId);
});

final directMessagesProvider = FutureProvider.family<List<ChatMessage>, String>((ref, userId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getDirectMessages(userId);
});
