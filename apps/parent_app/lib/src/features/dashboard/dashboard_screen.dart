import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authProvider).value?.user;
    
    if (user == null || user.schoolId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final childrenAsync = ref.watch(parentStudentsProvider({
      'schoolId': user.schoolId,
      'parentId': user.id,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('VortiQen Parent'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: childrenAsync.when(
        data: (children) {
          if (children.isEmpty) {
            return const Center(child: Text('No children found for this account.'));
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                  onTap: () => context.push('/child/${child.id}'),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                          child: Icon(Icons.person, size: 32, color: theme.colorScheme.primary),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${child.firstName} ${child.lastName ?? ''}'.trim(),
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Class: ${child.academicClass?.name ?? 'N/A'} - ${child.section?.name ?? ''}',
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                              ),
                              if (child.rollNo != null)
                                Text(
                                  'Roll No: ${child.rollNo}',
                                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
                                ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
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
