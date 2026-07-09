import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../repositories/auth_repository.dart';
import '../models/message.dart';

class SocketService {
  IO.Socket? _socket;
  final String _token;
  
  // Callback for when a new message is received
  Function(Message)? onMessageReceived;

  SocketService(this._token) {
    _initSocket();
  }

  void _initSocket() {
    _socket = IO.io('http://localhost:3000', IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .setAuth({'token': 'Bearer $_token'})
      .build()
    );

    _socket?.onConnect((_) {
      print('Socket connected');
    });

    _socket?.on('newMessage', (data) {
      if (onMessageReceived != null) {
        onMessageReceived!(Message.fromJson(data));
      }
    });

    _socket?.onDisconnect((_) {
      print('Socket disconnected');
    });

    _socket?.connect();
  }

  void sendMessage(String receiverId, String content) {
    _socket?.emit('sendMessage', {
      'receiverId': receiverId,
      'content': content,
    });
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}

final socketServiceProvider = Provider<SocketService?>((ref) {
  final authState = ref.watch(authRepositoryProvider);
  
  if (authState.token == null) return null;
  
  final service = SocketService(authState.token!);
  
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});
