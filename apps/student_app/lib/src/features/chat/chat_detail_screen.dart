import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

final chatHistoryProvider = FutureProvider.autoDispose.family<List<ChatMessage>, String>((ref, otherUserId) async {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getDirectMessages(otherUserId);
});

class ChatDetailScreen extends ConsumerStatefulWidget {
  final ChatContact contact;

  const ChatDetailScreen({super.key, required this.contact});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _realtimeMessages = [];

  @override
  void initState() {
    super.initState();
    // Setup socket listener
    final socketService = ref.read(socketServiceProvider);
    socketService.onDirectMessage.listen((message) {
      if (message.senderId == widget.contact.id || message.receiverId == widget.contact.id) {
        setState(() {
          _realtimeMessages.add(message);
        });
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    final socketService = ref.read(socketServiceProvider);
    socketService.sendDirectMessage(widget.contact.id, _messageController.text.trim());
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(chatHistoryProvider(widget.contact.id));
    final currentUserId = ref.watch(authProvider).value?.user?.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.contact.name)),
      body: Column(
        children: [
          Expanded(
            child: historyAsync.when(
              data: (history) {
                final allMessages = [...history, ..._realtimeMessages];
                // Deduplicate by ID
                final Map<String, ChatMessage> uniqueMessages = {};
                for (var m in allMessages) {
                  uniqueMessages[m.id] = m;
                }
                
                final displayMessages = uniqueMessages.values.toList()
                  ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

                if (displayMessages.isEmpty) {
                  return const Center(child: Text('Say Hi!'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: displayMessages.length,
                  itemBuilder: (context, index) {
                    final msg = displayMessages[index];
                    final isMe = msg.senderId == currentUserId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMe ? Theme.of(context).primaryColor : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16).copyWith(
                            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                            bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          msg.content,
                          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
