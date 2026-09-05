import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import 'student_dashboard_tab.dart';
import '../academics/academics_screen.dart';
import '../attendance/student_attendance_screen.dart';
import '../exams/exams_and_results_screen.dart';
import '../fees/student_fees_screen.dart';
import '../transport/student_transport_screen.dart';
import '../profile/student_id_card_screen.dart';
import '../notices/school_notices_screen.dart';
import '../calendar/student_calendar_tasks_screen.dart';
import '../reminders/student_alarm_reminder_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedNavIndex = 0;

  final List<AdaptiveNavItem> _navItems = const [
    AdaptiveNavItem(
      label: 'Home',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    AdaptiveNavItem(
      label: 'Academics',
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book,
      badge: 'LMS',
    ),
    AdaptiveNavItem(
      label: 'Planner',
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      badge: 'To-Do',
    ),
    AdaptiveNavItem(
      label: 'Attendance',
      icon: Icons.fact_check_outlined,
      selectedIcon: Icons.fact_check,
    ),
    AdaptiveNavItem(
      label: 'Exams',
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
    ),
    AdaptiveNavItem(
      label: 'Fees',
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet,
    ),
    AdaptiveNavItem(
      label: 'Transport',
      icon: Icons.directions_bus_outlined,
      selectedIcon: Icons.directions_bus,
      badge: 'LIVE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;
    final primaryColor = AppColors.studentPrimary;

    final pages = [
      StudentDashboardTab(
        onNavigateTab: (index) => setState(() => _selectedNavIndex = index),
        onOpenIdCard: () => _openIdCardScreen(context),
        onOpenNotices: () => _openNoticesScreen(context),
        onOpenAiDoubt: () => setState(() => _selectedNavIndex = 1),
        onOpenCalendar: () => setState(() => _selectedNavIndex = 2),
        onOpenReminders: () => _openRemindersScreen(context),
      ),
      const AcademicsScreen(),
      const StudentCalendarTasksScreen(),
      const StudentAttendanceScreen(),
      const ExamsAndResultsScreen(),
      const StudentFeesScreen(),
      const StudentTransportScreen(),
    ];

    return AdaptiveScaffold(
      role: AppRole.student,
      title: _navItems[_selectedNavIndex].label == 'Home' ? 'VortiQen Student Hub' : _navItems[_selectedNavIndex].label,
      subtitle: 'Class 10-A  •  Aarav Sharma  •  Roll #24',
      selectedIndex: _selectedNavIndex,
      onDestinationSelected: (index) => setState(() => _selectedNavIndex = index),
      destinations: _navItems,
      actions: [
        // Alarms & Smart Reminders Button
        IconButton(
          icon: const Icon(Icons.alarm_on_outlined),
          tooltip: 'Alarms & Smart Reminders',
          onPressed: () => _openRemindersScreen(context),
        ),

        // Smart Calendar Planner Button
        IconButton(
          icon: const Icon(Icons.event_note_outlined),
          tooltip: 'Calendar & To-Do Planner',
          onPressed: () => _openCalendarScreen(context),
        ),

        // Digital ID Card Quick Button
        IconButton(
          icon: const Icon(Icons.badge_outlined),
          tooltip: 'Digital ID Card',
          onPressed: () => _openIdCardScreen(context),
        ),

        // School Notices Bell
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE84393),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          tooltip: 'School Notices',
          onPressed: () => _openNoticesScreen(context),
        ),

        // Community / Teacher Chat Shortcut
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          tooltip: 'Teacher & Group Chat',
          onPressed: () => context.push('/chat'),
        ),

        // User Avatar Menu
        PopupMenuButton<String>(
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: primaryColor.withValues(alpha: 0.2),
            child: const Icon(Icons.person, size: 20, color: Color(0xFF0984E3)),
          ),
          onSelected: (val) {
            if (val == 'id_card') {
              _openIdCardScreen(context);
            } else if (val == 'calendar') {
              _openCalendarScreen(context);
            } else if (val == 'reminders') {
              _openRemindersScreen(context);
            } else if (val == 'notices') {
              _openNoticesScreen(context);
            } else if (val == 'logout') {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(user?.name ?? 'Aarav Sharma', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Class 10-A • Student'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'calendar',
              child: Row(
                children: [
                  Icon(Icons.calendar_month, size: 20),
                  SizedBox(width: 12),
                  Text('Calendar Planner'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'reminders',
              child: Row(
                children: [
                  Icon(Icons.alarm_on, size: 20),
                  SizedBox(width: 12),
                  Text('Alarms & Reminders'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'id_card',
              child: Row(
                children: [
                  Icon(Icons.badge, size: 20),
                  SizedBox(width: 12),
                  Text('Digital ID Card'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'notices',
              child: Row(
                children: [
                  Icon(Icons.campaign, size: 20),
                  SizedBox(width: 12),
                  Text('School Notices'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red, size: 20),
                  SizedBox(width: 12),
                  Text('Sign Out', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
      body: pages[_selectedNavIndex],
    );
  }

  void _openRemindersScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StudentAlarmReminderScreen()),
    );
  }

  void _openIdCardScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StudentIdCardScreen()),
    );
  }

  void _openNoticesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SchoolNoticesScreen()),
    );
  }

  void _openCalendarScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StudentCalendarTasksScreen()),
    );
  }
}
