import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _currentTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;
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
          // 1. Executive Teacher Welcome Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildWelcomeHeader(user?.name ?? 'Teacher'),
          ),
          const SizedBox(height: 20),

          // 2. Active Period Alert Card (Real-time Live Classroom Status)
          FadeSlideEntry(
            delay: const Duration(milliseconds: 80),
            child: _buildActivePeriodCard(),
          ),
          const SizedBox(height: 20),

          // 3. Quick Animated KPI Counters
          FadeSlideEntry(
            delay: const Duration(milliseconds: 140),
            child: _buildKpisGrid(),
          ),
          const SizedBox(height: 24),

          // 4. Quick Action Cockpit Hub
          FadeSlideEntry(
            delay: const Duration(milliseconds: 200),
            child: _buildQuickActionCockpit(),
          ),
          const SizedBox(height: 24),

          // 5. Today's Period Schedule & Notice Board Row
          FadeSlideEntry(
            delay: const Duration(milliseconds: 260),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildTodayScheduleCard()),
                      const SizedBox(width: 20),
                      Expanded(flex: 2, child: _buildNoticeBoardCard()),
                    ],
                  )
                : Column(
                    children: [
                      _buildTodayScheduleCard(),
                      const SizedBox(height: 20),
                      _buildNoticeBoardCard(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(String name) {
    final timeStr = DateFormat('hh:mm:ss a').format(_currentTime);
    final dateStr = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());

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
        runSpacing: 14,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Welcome back, $name 👋',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: -0.5),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '$dateStr • Assigned: Science & Mathematics (Senior Wing)',
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const PulsingLiveDot(size: 5, pulseScale: 2.2, color: Color(0xFF10B981)),
                const SizedBox(width: 8),
                Text(
                  timeStr,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Color(0xFF38BDF8),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivePeriodCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.timer_outlined, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('CURRENT PERIOD', style: TextStyle(color: Color(0xFF059669), fontSize: 10, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(width: 8),
                    const Text('09:30 AM - 10:15 AM', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mathematics • Class 10-A (Room 304)',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(height: 2),
                const Text('Chapter 4: Quadratic Equations & Formula Applications', style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => context.push('/daily-lesson-planner'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text('Plan Lesson', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
              ),
              ElevatedButton(
                onPressed: () => context.go('/mark-attendance'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF059669),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: const Text('Take Roll Call', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpisGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth < 650 ? 2 : 4;
        return GridView.count(
          crossAxisCount: crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossCount == 4 ? 2.3 : 2.0,
          children: [
            _buildMetricPill(94.5, 'Attendance Rate', '%', 'Class 10-A Today', Icons.check_circle_outline_rounded, const Color(0xFF10B981), 1),
            _buildMetricPill(8.0, 'Pending Reviews', '', 'Homework Submissions', Icons.assignment_late_outlined, const Color(0xFFF59E0B), 0),
            _buildMetricPill(5.0, 'Periods Today', '', '2 Free Slots Available', Icons.access_time_rounded, const Color(0xFF6C5CE7), 0),
            _buildMetricPill(3.0, 'School Circulars', '', 'Unread Announcements', Icons.campaign_outlined, const Color(0xFF0984E3), 0),
          ],
        );
      },
    );
  }

  Widget _buildMetricPill(double value, String title, String suffix, String sub, IconData icon, Color color, int digits) {
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
                  suffix: suffix,
                  fractionDigits: digits,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCockpit() {
    final actions = [
      {'title': 'My Profile & KYC', 'sub': 'Aadhaar, Degree & Vault', 'icon': Icons.badge_rounded, 'color': const Color(0xFF10B981), 'route': '/profile'},
      {'title': 'Leave Sanctions', 'sub': 'My Leaves & Student Approvals', 'icon': Icons.how_to_reg_rounded, 'color': const Color(0xFF8E44AD), 'route': '/hr/leaves'},
      {'title': 'Parent Grievances', 'sub': 'Complaints & Inquiries', 'icon': Icons.forum_rounded, 'color': const Color(0xFFE17055), 'route': '/complaints'},
      {'title': 'Salary & Payslips', 'sub': 'Monthly Slips & Form 16', 'icon': Icons.account_balance_wallet_rounded, 'color': const Color(0xFF0284C7), 'route': '/payslips'},
      {'title': 'Daily Agenda & To-Do', 'sub': 'Calendar, Periods & Tasks', 'icon': Icons.event_available_rounded, 'color': const Color(0xFF6C5CE7), 'route': '/calendar'},
      {'title': 'Mark Roll Call', 'sub': '1-Tap Live Register', 'icon': Icons.checklist_rounded, 'color': const Color(0xFF059669), 'route': '/mark-attendance'},
      {'title': 'Lesson Planner', 'sub': 'Day-wise Pedagogy Log', 'icon': Icons.edit_calendar_rounded, 'color': const Color(0xFF9B59B6), 'route': '/daily-lesson-planner'},
      {'title': 'Syllabus Tracker', 'sub': 'Teaching Units & Progress', 'icon': Icons.auto_stories_rounded, 'color': const Color(0xFF0984E3), 'route': '/teaching-units'},
      {'title': 'Class Daily Diary', 'sub': 'Broadcast Notes to Parents', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFFF59E0B), 'route': '/academics/diary'},
      {'title': 'Weekly Timetable', 'sub': 'Class Schedule', 'icon': Icons.calendar_view_week_rounded, 'color': const Color(0xFF00CEC9), 'route': '/academics/timetable'},
      {'title': 'Post Homework', 'sub': 'Add Assignment / PDF', 'icon': Icons.post_add_rounded, 'color': const Color(0xFFD63031), 'route': '/assignments/create'},
      {'title': 'Enter Marks', 'sub': 'Marksheet Gradebook', 'icon': Icons.grade_rounded, 'color': const Color(0xFFFD79A8), 'route': '/exams'},
      {'title': 'Scholar 360', 'sub': 'Class Student Roster', 'icon': Icons.people_alt_rounded, 'color': const Color(0xFF2D3436), 'route': '/students'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Workspace Actions',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth < 650 ? 2 : (constraints.maxWidth < 1050 ? 3 : 6);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                childAspectRatio: crossCount >= 3 ? 1.6 : 1.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final a = actions[index];
                final col = a['color'] as Color;

                return HoverLiftCard(
                  onTap: () => context.go(a['route'] as String),
                  padding: const EdgeInsets.all(14),
                  borderRadius: 14,
                  hoverBorderColor: col.withValues(alpha: 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: col.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                        child: Icon(a['icon'] as IconData, color: col, size: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(a['title'] as String, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                      Text(a['sub'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTodayScheduleCard() {
    final periods = [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Assembly & Homeroom', 'class': 'Class 10-A', 'room': 'Room 304', 'status': 'COMPLETED'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Mathematics', 'class': 'Class 10-A', 'room': 'Room 304', 'status': 'ACTIVE'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Physics Lab', 'class': 'Class 9-B', 'room': 'Lab 2', 'status': 'UPCOMING'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Staff Planning (Free)', 'class': 'Faculty Room', 'room': 'Floor 2', 'status': 'FREE'},
      {'period': 'Period 5', 'time': '12:15 - 01:00 PM', 'subject': 'Geometry & Math', 'class': 'Class 8-C', 'room': 'Room 201', 'status': 'UPCOMING'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Today's Teaching Schedule", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
              TextButton(
                onPressed: () => context.go('/academics/timetable'),
                child: const Text('Full Week View →', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: periods.length,
            itemBuilder: (context, index) {
              final p = periods[index];
              final isActive = p['status'] == 'ACTIVE';
              final isDone = p['status'] == 'COMPLETED';

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF10B981).withValues(alpha: 0.05) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isActive ? const Color(0xFF10B981).withValues(alpha: 0.4) : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['period']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF1E293B))),
                          Text(p['time']!, style: const TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['subject']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                          Text('${p['class']} • ${p['room']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    if (isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                        child: const Row(
                          children: [
                            PulsingLiveDot(size: 4, pulseScale: 2.0, color: Color(0xFF10B981)),
                            SizedBox(width: 5),
                            Text('NOW', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )
                    else if (isDone)
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF94A3B8), size: 18)
                    else
                      Text(p['status']!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeBoardCard() {
    final notices = [
      {'title': 'Parent-Teacher Meeting Scheduled', 'date': '5 Sep 2026', 'tag': 'ADMIN'},
      {'title': 'Science Exhibition Project Guidelines', 'date': '2 Sep 2026', 'tag': 'ACADEMIC'},
      {'title': 'Quarterly Exam Timetable Released', 'date': '31 Aug 2026', 'tag': 'EXAM'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('School Notice Board', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
              Icon(Icons.campaign_rounded, color: Color(0xFF6C5CE7), size: 20),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final n = notices[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(n['tag']!, style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 9)),
                        ),
                        Text(n['date']!, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(n['title']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B))),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
