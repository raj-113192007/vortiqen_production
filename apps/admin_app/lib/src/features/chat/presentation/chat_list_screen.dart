import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(myGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communications'),
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('No groups or chats found.'));
          }

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                  child: Icon(group.isGroup ? Icons.group : Icons.person, color: Colors.blueAccent),
                ),
                title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('Tap to open chat', style: TextStyle(color: Colors.white54)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChatRoomScreen(group: group)));
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.group_add),
        onPressed: () {
          _showCreateGroupDialog(context, ref);
        },
      ),
    );
  }

  void _showCreateGroupDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        title: const Text('Create Chat Group', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'Group Name', hintStyle: TextStyle(color: Colors.white54)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await ref.read(chatRepositoryProvider).createGroup(nameController.text);
                ref.invalidate(myGroupsProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

