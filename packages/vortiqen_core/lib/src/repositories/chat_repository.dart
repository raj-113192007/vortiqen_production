import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/message.dart';
import '../models/user.dart';
import 'auth_repository.dart';

part 'chat_repository.g.dart';

class ChatRepository {
  final Dio _dio;

  ChatRepository(this._dio);

  Future<List<ChatContact>> getContacts() async {
    final response = await _dio.get('/chat/contacts');
    return (response.data as List)
        .map((e) => ChatContact.fromJson(e))
        .toList();
  }

  Future<List<Message>> getChatHistory(String otherUserId) async {
    final response = await _dio.get('/chat/history/$otherUserId');
    return (response.data as List)
        .map((e) => Message.fromJson(e))
        .toList();
  }
}

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final authState = ref.watch(authRepositoryProvider);
  
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000', // adjust as needed
    headers: {
      if (authState.token != null) 'Authorization': 'Bearer ${authState.token}',
    },
  ));

  return ChatRepository(dio);
}
