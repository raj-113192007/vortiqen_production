import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StudentDashboardTab extends ConsumerWidget {
  final Function(int tabIndex) onNavigateTab;
  final VoidCallback onOpenIdCard;
  final VoidCallback onOpenNotices;
  final VoidCallback onOpenAiDoubt;
  final VoidCallback onOpenCalendar;
  final VoidCallback? onOpenReminders;

  const StudentDashboardTab({
    super.key,
    required this.onNavigateTab,
    required this.onOpenIdCard,
    required this.onOpenNotices,
    required this.onOpenAiDoubt,
    required this.onOpenCalendar,
    this.onOpenReminders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value?.user;
    final primaryColor = AppColors.studentPrimary;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Student Welcome Banner & Live Class
            ResponsiveTwoPane(
              breakpoint: 960,
              leftFlex: 3,
              rightFlex: 2,
              spacing: 16,
              leftPane: _buildHeroBanner(context, user, primaryColor),
              rightPane: _buildLiveClassCard(context, primaryColor),
            ),
            const SizedBox(height: 20),

            // 2. Quick Stats Responsive Grid
            _buildQuickStats(context, primaryColor),
            const SizedBox(height: 24),

            // 3. Quick Action Launcher
            _buildQuickActions(context, primaryColor),
            const SizedBox(height: 24),

            // 4. Today's Schedule & Pending Homework
            ResponsiveTwoPane(
              breakpoint: 860,
              leftFlex: 1,
              rightFlex: 1,
              spacing: 20,
              leftPane: _buildTodayScheduleSection(context, primaryColor),
              rightPane: Column(
                children: [
                  _buildPendingHomeworkSection(context, primaryColor),
                  const SizedBox(height: 18),
                  _buildNoticeHighlight(context, primaryColor),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, User? user, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0984E3), Color(0xFF00CEC9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with online status
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: const Center(
                  child: Icon(Icons.school, size: 34, color: Colors.white),
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B894),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, 👋',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user?.name ?? 'Aarav Sharma',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Class 10-A  •  Roll #24  •  CBSE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onOpenIdCard,
            icon: const Icon(Icons.badge_outlined, color: Colors.white, size: 26),
            tooltip: 'Digital ID Card',
          ),
        ],
      ),
    );
  }

  Widget _buildLiveClassCard(BuildContext context, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF00CEC9).withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00CEC9).withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00CEC9), Color(0xFF0984E3)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.science, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE84393),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'LIVE CLASS NOW',
                      style: TextStyle(
                        color: Color(0xFFE84393),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Physics — Thermodynamics',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Prof. Verma • Science Lab 2',
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => onNavigateTab(1),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0984E3),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Join', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, Color primaryColor) {
    final columns = context.responsiveGridCount(mobile: 2, tablet: 4, desktop: 4, wide: 4);
    final aspectRatio = context.responsiveValue<double>(mobile: 1.45, tablet: 1.5, desktop: 1.65, wide: 1.8);

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: aspectRatio,
      children: [
        _buildStatCard(
          title: 'Attendance',
          value: '94.8%',
          subtitle: '114/120 Days',
          icon: Icons.fact_check,
          color: const Color(0xFF00B894),
          onTap: () => onNavigateTab(3),
        ),
        _buildStatCard(
          title: 'Homework',
          value: '2 Pending',
          subtitle: 'Due this week',
          icon: Icons.assignment_late_outlined,
          color: const Color(0xFFE17055),
          onTap: () => onNavigateTab(1),
        ),
        _buildStatCard(
          title: 'Next Exam',
          value: 'In 4 Days',
          subtitle: 'Science Mid-Term',
          icon: Icons.alarm,
          color: const Color(0xFF6C5CE7),
          onTap: () => onNavigateTab(4),
        ),
        _buildStatCard(
          title: 'Fee Status',
          value: 'Paid',
          subtitle: 'No dues pending',
          icon: Icons.check_circle_outline,
          color: const Color(0xFF0984E3),
          onTap: () => onNavigateTab(5),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: color,
                    letterSpacing: -0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, Color primaryColor) {
    final actions = [
      {'title': 'Alarms & Reminders', 'icon': Icons.alarm_on_rounded, 'color': const Color(0xFF0984E3), 'action': onOpenReminders ?? onOpenCalendar},
      {'title': 'AI Doubt Assistant', 'icon': Icons.smart_toy_outlined, 'color': const Color(0xFF6C5CE7), 'action': onOpenAiDoubt},
      {'title': 'Calendar Planner', 'icon': Icons.calendar_month, 'color': const Color(0xFF0984E3), 'action': onOpenCalendar},
      {'title': 'Timetable', 'icon': Icons.schedule, 'color': const Color(0xFF00CEC9), 'action': () => onNavigateTab(1)},
      {'title': 'Study Notes', 'icon': Icons.menu_book, 'color': const Color(0xFF00B894), 'action': () => onNavigateTab(1)},
      {'title': 'Live Bus GPS', 'icon': Icons.directions_bus, 'color': const Color(0xFFF39C12), 'action': () => onNavigateTab(6)},
      {'title': 'Report Card', 'icon': Icons.military_tech, 'color': const Color(0xFFE84393), 'action': () => onNavigateTab(4)},
      {'title': 'Fee Receipt', 'icon': Icons.receipt_long, 'color': const Color(0xFF00CEC9), 'action': () => onNavigateTab(5)},
      {'title': 'ID Card', 'icon': Icons.badge, 'color': const Color(0xFF2D3436), 'action': onOpenIdCard},
      {'title': 'Notices', 'icon': Icons.campaign, 'color': const Color(0xFFD63031), 'action': onOpenNotices},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Services',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions.map((item) {
              final color = item['color'] as Color;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: item['action'] as VoidCallback,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 95,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item['icon'] as IconData, color: color, size: 22),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayScheduleSection(BuildContext context, Color primaryColor) {
    final schedule = [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Mathematics', 'topic': 'Quadratic Equations', 'room': 'Room 102', 'status': 'completed'},
      {'period': 'Period 2', 'time': '09:15 - 10:00 AM', 'subject': 'English Literature', 'topic': 'The Merchant of Venice', 'room': 'Room 102', 'status': 'completed'},
      {'period': 'Break', 'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'topic': 'Cafeteria & Library', 'room': 'Grounds', 'status': 'completed'},
      {'period': 'Period 3', 'time': '10:30 - 11:15 AM', 'subject': 'Physics (Lab)', 'topic': 'Thermodynamics & Heat', 'room': 'Science Lab 2', 'status': 'live'},
      {'period': 'Period 4', 'time': '11:15 - 12:00 PM', 'subject': 'Chemistry', 'topic': 'Periodic Table & Bonds', 'room': 'Room 102', 'status': 'upcoming'},
      {'period': 'Period 5', 'time': '12:45 - 01:30 PM', 'subject': 'Computer Science', 'topic': 'Python Loops & Lists', 'room': 'IT Lab 1', 'status': 'upcoming'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Schedule",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
            ),
            TextButton(
              onPressed: () => onNavigateTab(1),
              child: const Text('Full Timetable →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: schedule.length,
            separatorBuilder: (_, _) => const Divider(height: 16, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, index) {
              final item = schedule[index];
              final isLive = item['status'] == 'live';
              final isCompleted = item['status'] == 'completed';

              return Row(
                children: [
                  Container(
                    width: 75,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['period']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isLive ? const Color(0xFF0984E3) : Colors.grey[700],
                          ),
                        ),
                        Text(
                          item['time']!.split(' ')[0],
                          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 3,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isLive
                          ? const Color(0xFF00CEC9)
                          : isCompleted
                              ? const Color(0xFF00B894)
                              : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['subject']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: isCompleted ? Colors.grey[700] : const Color(0xFF2D3436),
                          ),
                        ),
                        Text(
                          '${item['topic']} • ${item['room']}',
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  if (isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00CEC9).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF00CEC9),
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  if (isCompleted)
                    const Icon(Icons.check_circle, color: Color(0xFF00B894), size: 18),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPendingHomeworkSection(BuildContext context, Color primaryColor) {
    final pendingTasks = [
      {
        'subject': 'Mathematics',
        'title': 'Chapter 4: Quadratic Equations Ex 4.2',
        'due': 'Tomorrow, 09:00 AM',
        'isUrgent': true,
        'icon': Icons.calculate,
        'color': const Color(0xFF0984E3),
      },
      {
        'subject': 'Physics',
        'title': 'Heat Transfer Lab Report & Numericals',
        'due': 'In 3 days (12 Sept)',
        'isUrgent': false,
        'icon': Icons.bolt,
        'color': const Color(0xFF6C5CE7),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Homework',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
            ),
            TextButton(
              onPressed: () => onNavigateTab(1),
              child: const Text('View All →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pendingTasks.length,
          itemBuilder: (context, index) {
            final task = pendingTasks[index];
            final color = task['color'] as Color;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(task['icon'] as IconData, color: color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              task['subject'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                            if (task['isUrgent'] == true) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE84393).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'DUE SOON',
                                  style: TextStyle(color: Color(0xFFE84393), fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          task['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Deadline: ${task['due']}',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => onNavigateTab(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor.withValues(alpha: 0.1),
                      foregroundColor: primaryColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Upload', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNoticeHighlight(BuildContext context, Color primaryColor) {
    return InkWell(
      onTap: onOpenNotices,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF6C5CE7).withValues(alpha: 0.08), const Color(0xFF0984E3).withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF6C5CE7).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF6C5CE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.campaign, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Annual Sports Day & Science Fair',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Registrations open for track events and robotics exhibition.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF6C5CE7)),
          ],
        ),
      ),
    );
  }
}
