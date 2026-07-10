import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class DashboardLayout extends ConsumerWidget {
  final Widget child;

  const DashboardLayout({
    super.key,
    required this.child,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/attendance')) return 1;
    if (location.startsWith('/assignments')) return 2;
    if (location.startsWith('/exams')) return 3;
    if (location.startsWith('/payslips')) return 4;
    if (location.startsWith('/chat')) return 5;
    return 0; // Home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/attendance');
        break;
      case 2:
        context.go('/assignments');
        break;
      case 3:
        context.go('/exams');
        break;
      case 4:
        context.go('/payslips');
        break;
      case 5:
        context.go('/chat');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedIndex = _calculateSelectedIndex(context);
    final user = ref.watch(authProvider).value?.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VortiQen Teacher'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                user?.name ?? 'Teacher',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        backgroundColor: theme.colorScheme.surface,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'Exams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Payslips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
