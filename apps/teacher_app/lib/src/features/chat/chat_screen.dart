import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

import 'chat_detail_screen.dart';

final chatContactsProvider = FutureProvider<List<ChatContact>>((ref) async {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getContacts();
});

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(chatContactsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: contactsAsync.when(
        data: (contacts) {
          if (contacts.isEmpty) {
            return const Center(child: Text('No contacts found.'));
          }
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(contact.name[0].toUpperCase()),
                ),
                title: Text(contact.name),
                subtitle: Text(contact.details ?? contact.role),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(contact: contact),
                    ),
                  );
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
