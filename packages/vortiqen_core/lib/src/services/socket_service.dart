import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/chat.dart';
import '../providers/auth_provider.dart';

class SocketService {
  IO.Socket? _socket;
  final String baseUrl;
  
  // StreamControllers to broadcast received messages
  final _groupMessageController = StreamController<ChatMessage>.broadcast();
  final _directMessageController = StreamController<ChatMessage>.broadcast();

  Stream<ChatMessage> get onGroupMessage => _groupMessageController.stream;
  Stream<ChatMessage> get onDirectMessage => _directMessageController.stream;

  SocketService(this.baseUrl);

  void connect(String token) {
    if (_socket != null && _socket!.connected) return;

    _socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {
        'Authorization': 'Bearer $token',
      }
    });

    _socket!.onConnect((_) {
      print('Socket connected');
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
    });

    _socket!.on('receiveGroupMessage', (data) {
      final msg = ChatMessage.fromJson(data);
      _groupMessageController.add(msg);
    });

    _socket!.on('receiveDirectMessage', (data) {
      final msg = ChatMessage.fromJson(data);
      _directMessageController.add(msg);
    });

    _socket!.connect();
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void sendGroupMessage(String groupId, String content) {
    if (_socket == null || !_socket!.connected) return;
    _socket!.emit('sendGroupMessage', {
      'groupId': groupId,
      'content': content,
    });
  }

  void sendDirectMessage(String receiverId, String content) {
    if (_socket == null || !_socket!.connected) return;
    _socket!.emit('sendDirectMessage', {
      'receiverId': receiverId,
      'content': content,
    });
  }
}

final socketServiceProvider = Provider<SocketService>((ref) {
  String baseUrl = 'http://localhost:3000';
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    baseUrl = 'http://10.0.2.2:3000';
  }
  final service = SocketService(baseUrl);
  
  ref.onDispose(() {
    service.disconnect();
  });

  return service;
});

// A provider that automatically connects when auth changes
final socketConnectionProvider = Provider<void>((ref) {
  final authState = ref.watch(authProvider).value;
  final socketService = ref.watch(socketServiceProvider);

  if (authState?.token != null) {
    socketService.connect(authState!.token!);
  } else {
    socketService.disconnect();
  }
});
