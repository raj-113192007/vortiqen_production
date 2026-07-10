import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final ChatGroup group;

  const ChatRoomScreen({super.key, required this.group});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> _messages = [];
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    // Re-connect if disconnected, connect if connected
    ref.read(socketConnectionProvider);
    
    // Listen for incoming messages on socket
    ref.read(socketServiceProvider).onGroupMessage.listen((msg) {
      if (msg.groupId == widget.group.id && mounted) {
        setState(() {
          _messages.insert(0, msg);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(groupMessagesProvider(widget.group.id));
    final currentUser = ref.watch(authProvider).value?.user;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(widget.group.isGroup ? Icons.group : Icons.person, size: 20),
            const SizedBox(width: 8),
            Text(widget.group.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: historyAsync.when(
              data: (history) {
                if (_isInitialLoad) {
                  _messages = List.from(history);
                  _isInitialLoad = false;
                }
                
                if (_messages.isEmpty) {
                  return const Center(child: Text('No messages yet. Say hi!'));
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isMe = msg.senderId == currentUser?.id;
                    
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blueAccent : const Color(0xFF2A2A3C),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isMe) ...[
                              Text(
                                msg.sender?.name ?? 'Unknown',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              msg.content,
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('HH:mm').format(msg.createdAt),
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error loading history')),
            ),
          ),
          // Chat Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    // Optimistic UI updates could happen here, but we'll rely on socket roundtrip or REST response for simplicity
    ref.read(socketServiceProvider).sendGroupMessage(widget.group.id, text);
    _messageController.clear();
  }
}

