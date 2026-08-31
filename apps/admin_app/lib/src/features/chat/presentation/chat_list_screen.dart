import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(myGroupsProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(context, ref),
          ),
          const SizedBox(height: 20),

          groupsAsync.when(
            data: (groups) {
              final groupChats = groups.where((g) => g.isGroup).length;
              final directChats = groups.length - groupChats;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Summary KPIs
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 100),
                    child: _buildKpis(groups.length, groupChats, directChats),
                  ),
                  const SizedBox(height: 20),

                  if (groups.isEmpty)
                    _buildEmptyState(context, ref)
                  else
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 150),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final group = groups[index];
                          final isGrp = group.isGroup;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HoverLiftCard(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatRoomScreen(group: group)));
                              },
                              padding: const EdgeInsets.all(16),
                              borderRadius: 14,
                              hoverBorderColor: const Color(0xFF6C5CE7).withValues(alpha: 0.35),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: isGrp
                                        ? const Color(0xFF6C5CE7).withValues(alpha: 0.12)
                                        : const Color(0xFF10B981).withValues(alpha: 0.12),
                                    child: Icon(
                                      isGrp ? Icons.forum_rounded : Icons.person_rounded,
                                      color: isGrp ? const Color(0xFF6C5CE7) : const Color(0xFF10B981),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              group.name,
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: isGrp
                                                    ? const Color(0xFF6C5CE7).withValues(alpha: 0.08)
                                                    : const Color(0xFF10B981).withValues(alpha: 0.08),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                isGrp ? 'GROUP' : 'DIRECT',
                                                style: TextStyle(
                                                  color: isGrp ? const Color(0xFF6C5CE7) : const Color(0xFF10B981),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        const Text('Tap to open real-time message stream', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campus Communications & Channels',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Staff Department Broadcasts, Parent-Teacher Messaging & Administrative Circles',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFF10B981)),
                    SizedBox(width: 6),
                    Text('CHAT SERVER ONLINE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showCreateGroupDialog(context, ref),
                icon: const Icon(Icons.group_add_rounded, size: 16),
                label: const Text('Create Channel / Group'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpis(int total, int groups, int directs) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(total.toDouble(), 'Active Conversations', Icons.chat_bubble_outline_rounded, const Color(0xFF6C5CE7), 'Campus Threads'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricTile(groups.toDouble(), 'Department Channels', Icons.groups_outlined, const Color(0xFF10B981), 'Faculty Groups'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricTile(directs.toDouble(), '1-on-1 Direct Chats', Icons.person_outline_rounded, const Color(0xFF0984E3), 'Private Inboxes'),
        ),
      ],
    );
  }

  Widget _buildMetricTile(double value, String label, IconData icon, Color color, String sub) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 14,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  fractionDigits: 0,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.forum_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            const Text('No Chat Groups or Channels Yet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            const Text('Click "Create Channel / Group" above to start collaborative school discussions.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  void _showCreateGroupDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Create New Communication Group', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Channel / Group Name (e.g. Science Faculty, Bus Drivers)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                await ref.read(chatRepositoryProvider).createGroup(nameController.text);
                ref.invalidate(myGroupsProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Create Channel'),
          ),
        ],
      ),
    );
  }
}
