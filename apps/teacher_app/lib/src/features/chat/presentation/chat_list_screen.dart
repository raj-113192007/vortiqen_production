import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

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
                  context.push('/chat/group/${group.id}', extra: group);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

