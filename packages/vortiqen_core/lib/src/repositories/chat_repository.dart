import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat.dart';
import '../models/user.dart';

class ChatRepository {
  ChatRepository();

  Future<List<ChatGroup>> getMyGroups() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      ChatGroup(
        id: 'grp_01',
        schoolId: 'sch_01',
        name: 'Class 10-A Parents & Teachers Forum',
        isGroup: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      ChatGroup(
        id: 'grp_02',
        schoolId: 'sch_01',
        name: 'Faculty & Department Circulars',
        isGroup: true,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
    ];
  }

  Future<ChatGroup> createGroup(String name) async {
    return ChatGroup(
      id: 'grp_new',
      schoolId: 'sch_01',
      name: name,
      isGroup: true,
      createdAt: DateTime.now(),
    );
  }

  Future<void> addMember(String groupId, String userId) async {}

  Future<List<ChatMessage>> getGroupMessages(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      ChatMessage(
        id: 'msg_01',
        schoolId: 'sch_01',
        senderId: 'u_t1',
        groupId: groupId,
        content: 'Welcome parents! Mid-term exam schedule has been updated in the portal.',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        sender: User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', status: 'ACTIVE'),
      ),
      ChatMessage(
        id: 'msg_02',
        schoolId: 'sch_01',
        senderId: 'u_p1',
        groupId: groupId,
        content: 'Thank you Ma\'am. Will the practicals be conducted next week?',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        sender: User(id: 'u_p1', name: 'Rajesh Sharma', role: 'PARENT', status: 'ACTIVE'),
      ),
    ];
  }

  Future<List<ChatMessage>> getDirectMessages(String userId) async {
    return getGroupMessages('grp_01');
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});

final myGroupsProvider = FutureProvider<List<ChatGroup>>((ref) {
  return ref.watch(chatRepositoryProvider).getMyGroups();
});

final groupMessagesProvider = FutureProvider.family<List<ChatMessage>, String>((ref, groupId) {
  return ref.watch(chatRepositoryProvider).getGroupMessages(groupId);
});

final directMessagesProvider = FutureProvider.family<List<ChatMessage>, String>((ref, userId) {
  return ref.watch(chatRepositoryProvider).getDirectMessages(userId);
});
