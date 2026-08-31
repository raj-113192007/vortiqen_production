import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard_layout.dart';
import '../academics/academics_screen.dart';
import '../staff/staff_screen.dart';
import '../students/students_screen.dart';
import '../transport/transport_screen.dart';
import '../attendance/attendance_screen.dart';
import '../fees/fees_screen.dart';
import '../inventory/presentation/inventory_list_screen.dart';
import '../analytics/presentation/analytics_dashboard_screen.dart';
import '../cctv/presentation/cctv_list_screen.dart';
import '../exams/presentation/exams_list_screen.dart';
import '../hr/presentation/hr_dashboard_screen.dart';
import '../chat/presentation/chat_list_screen.dart';
import '../admissions/admissions_list_screen.dart';
import '../onboarding/presentation/data_onboarding_hub_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;
  bool _action1Resolved = false;
  bool _action2Resolved = false;

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_selectedIndex) {
      case 0:
        content = _buildOverview(context);
        break;
      case 1:
        content = const DataOnboardingHubScreen();
        break;
      case 2:
        content = const StudentsScreen();
        break;
      case 3:
        content = const AcademicsScreen();
        break;
      case 4:
        content = const FeesScreen();
        break;
      case 5:
        content = const ExamsListScreen();
        break;
      case 6:
        content = const StaffScreen();
        break;
      case 7:
        content = const TransportScreen();
        break;
      case 8:
        content = const CctvListScreen();
        break;
      case 9:
        content = const AcademicsScreen();
        break;
      case 10:
        content = const TransportScreen();
        break;
      case 11:
        content = const AdmissionsListScreen();
        break;
      case 12:
        content = const InventoryListScreen();
        break;
      case 13:
        content = const ChatListScreen();
        break;
      case 14:
        content = const AnalyticsDashboardScreen();
        break;
      default:
        content = _buildOverview(context);
    }

    return DashboardLayout(
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: content,
    );
  }

  Widget _buildOverview(BuildContext context) {
    final theme = Theme.of(context);
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
          // 1. Executive Welcome Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildExecutiveHeader(context),
          ),
          const SizedBox(height: 24),

          // 2. Primary 4 KPI Pulse Cards
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 450),
            child: _buildKpiGrid(context, isDesktop),
          ),
          const SizedBox(height: 24),

          // 3. Dual Charts Row: Weekly Attendance Curve & Fee Realisation
          FadeSlideEntry(
            delay: const Duration(milliseconds: 180),
            duration: const Duration(milliseconds: 450),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: _buildAttendanceChartCard(context)),
                      const SizedBox(width: 24),
                      Expanded(flex: 5, child: _buildFeeRealisationCard(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildAttendanceChartCard(context),
                      const SizedBox(height: 20),
                      _buildFeeRealisationCard(context),
                    ],
                  ),
          ),
          const SizedBox(height: 24),

          // 4. Principal's Urgent Action Queue
          FadeSlideEntry(
            delay: const Duration(milliseconds: 240),
            duration: const Duration(milliseconds: 450),
            child: _buildActionQueue(context),
          ),
          const SizedBox(height: 24),

          // 5. Bottom Dual Row: Live Bus & Safety Pulse + Today's Schedule
          FadeSlideEntry(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 450),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _buildTransportSafetyCard(context)),
                      const SizedBox(width: 24),
                      Expanded(flex: 6, child: _buildTodayScheduleCard(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildTransportSafetyCard(context),
                      const SizedBox(height: 20),
                      _buildTodayScheduleCard(context),
                    ],
                  ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // --- 1. Executive Welcome Header ---
  Widget _buildExecutiveHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Good Morning, Principal Sharma',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.wb_sunny_outlined, size: 22, color: Color(0xFFF59E0B)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Academic Year 2026-27 • Term 2 (Day 84 of 180)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6C5CE7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Delhi Public International School',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),

          // Quick Action Buttons
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _selectedIndex = 1),
                icon: const Icon(Icons.cloud_upload_rounded, size: 16),
                label: const Text('Data Onboarding'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notice Broadcast Dialog: Draft sent to all parents & teachers')),
                  );
                },
                icon: const Icon(Icons.campaign_outlined, size: 16, color: Color(0xFF334155)),
                label: const Text('Broadcast Notice', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Primary 4 KPI Pulse Cards ---
  Widget _buildKpiGrid(BuildContext context, bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 4 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: crossAxisCount == 4 ? 1.6 : 2.2,
          children: [
            _buildAnimatedKpiCard(
              title: 'Total Students',
              targetValue: 1420,
              prefix: '',
              suffix: '',
              fractionDigits: 0,
              badgeText: '96.8% Present Today',
              badgeColor: const Color(0xFF00B894),
              icon: Icons.people_alt_rounded,
              color: const Color(0xFF6C5CE7),
              subtext: '46 Absent • 12 On Leave',
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            _buildAnimatedKpiCard(
              title: 'Fee Collection (MTD)',
              targetValue: 42.8,
              prefix: '₹ ',
              suffix: ' L',
              fractionDigits: 1,
              badgeText: '88.7% Realised',
              badgeColor: const Color(0xFF0984E3),
              icon: Icons.account_balance_wallet_rounded,
              color: const Color(0xFF00B894),
              subtext: '₹ 5.4 L Pending Dues',
              onTap: () => setState(() => _selectedIndex = 4),
            ),
            _buildAnimatedKpiCard(
              title: 'Staff & Faculty Duty',
              targetValue: 81,
              prefix: '',
              suffix: ' / 84',
              fractionDigits: 0,
              badgeText: '3 Approved Leaves',
              badgeColor: const Color(0xFFF39C12),
              icon: Icons.badge_rounded,
              color: const Color(0xFFE84393),
              subtext: 'All Periods Covered',
              onTap: () => setState(() => _selectedIndex = 6),
            ),
            _buildAnimatedKpiCard(
              title: 'Smart Bus Fleet',
              targetValue: 8,
              prefix: '',
              suffix: ' / 8 Active',
              fractionDigits: 0,
              badgeText: 'All GPS Live',
              badgeColor: const Color(0xFF00B894),
              icon: Icons.directions_bus_rounded,
              color: const Color(0xFFF39C12),
              subtext: '0 Delays • 412 Commuters',
              onTap: () => setState(() => _selectedIndex = 7),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedKpiCard({
    required String title,
    required double targetValue,
    required String prefix,
    required String suffix,
    required int fractionDigits,
    required String badgeText,
    required Color badgeColor,
    required IconData icon,
    required Color color,
    required String subtext,
    required VoidCallback onTap,
  }) {
    return HoverLiftCard(
      onTap: onTap,
      borderRadius: 18,
      padding: const EdgeInsets.all(20),
      hoverBorderColor: color.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AnimatedMetricCounter(
                targetValue: targetValue,
                prefix: prefix,
                suffix: suffix,
                fractionDigits: fractionDigits,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtext,
            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // --- 3. Weekly Attendance Curve & Fee Realisation ---
  Widget _buildAttendanceChartCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Attendance Pulse',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Campus-wide Student & Faculty Presence Rate',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Text(
                  'This Week • Mon - Fri',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(color: const Color(0xFFF1F5F9), strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (val, meta) => Text('${val.toInt()}%', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                        if (val.toInt() >= 0 && val.toInt() < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(days[val.toInt()], style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minY: 85,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 94.5),
                      FlSpot(1, 96.2),
                      FlSpot(2, 95.8),
                      FlSpot(3, 97.4),
                      FlSpot(4, 96.8),
                    ],
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: const Color(0xFF6C5CE7),
                    barWidth: 3.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF6C5CE7).withOpacity(0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRealisationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fee Realisation Matrix',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 2),
          const Text(
            'Term 2 Target: ₹ 48.2 Lakhs',
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 20),

          // Custom Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 14,
              child: Row(
                children: [
                  Expanded(flex: 88, child: Container(color: const Color(0xFF00B894))),
                  Expanded(flex: 12, child: Container(color: const Color(0xFFFF7675))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          _buildFeeBreakdownRow('Collected (Paid Online/Bank)', '₹ 42,80,000', '88.7%', const Color(0xFF00B894)),
          const Divider(height: 18, color: Color(0xFFF1F5F9)),
          _buildFeeBreakdownRow('Pending Dues (< 15 Days)', '₹ 3,90,000', '8.1%', const Color(0xFFF39C12)),
          const Divider(height: 18, color: Color(0xFFF1F5F9)),
          _buildFeeBreakdownRow('Overdue Critical (> 30 Days)', '₹ 1,50,000', '3.2%', const Color(0xFFFF7675)),
        ],
      ),
    );
  }

  Widget _buildFeeBreakdownRow(String label, String amount, String pct, Color dotColor) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
        ),
        const SizedBox(width: 8),
        Text(
          '($pct)',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: dotColor),
        ),
      ],
    );
  }

  // --- 4. Principal's Urgent Action Queue ---
  Widget _buildActionQueue(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF), // Soft violet background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFF6C5CE7), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              const Text(
                'Urgent Action Queue (Needs Your Attention Today)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF581C87)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action 1: Leave Request
          if (!_action1Resolved)
            _buildActionCard(
              icon: Icons.person_off_rounded,
              iconColor: const Color(0xFFF39C12),
              title: 'Faculty Leave Application: Prof. Alok Mukherjee',
              subtitle: 'Requested 2 Days Medical Leave (28 Aug - 29 Aug). Substitute arrangement confirmed with Mrs. Emily Davis.',
              actionText: '1-Tap Approve',
              onAction: () {
                setState(() => _action1Resolved = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Leave approved and substitute timetable notified!')),
                );
              },
            ),

          if (!_action1Resolved) const SizedBox(height: 12),

          // Action 2: Overdue Fees WhatsApp
          if (!_action2Resolved)
            _buildActionCard(
              icon: Icons.notifications_active_rounded,
              iconColor: const Color(0xFFE84393),
              title: '18 Students in Grade 10 have Tuition Fees Overdue > 30 Days',
              subtitle: 'Send automated polite WhatsApp fee payment link directly to registered parent contacts.',
              actionText: 'Send WhatsApp Ping',
              onAction: () {
                setState(() => _action2Resolved = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('WhatsApp Payment Reminders dispatched to 18 parents!')),
                );
              },
            ),

          if (_action1Resolved && _action2Resolved)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text('All urgent tasks for today are resolved!', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF00B894))),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return HoverLiftCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 14,
      hoverBorderColor: iconColor.withValues(alpha: 0.35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B))),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(width: 14),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: Text(actionText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // --- 5. Bottom Dual Cards: Bus & Safety Pulse + Today's Schedule ---
  Widget _buildTransportSafetyCard(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Campus Safety & Transport Pulse',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
              ),
              InkWell(
                onTap: () => setState(() => _selectedIndex = 7),
                child: const Text('View All Feeds', style: TextStyle(color: Color(0xFF6C5CE7), fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPulseItem(
            Icons.directions_bus_rounded,
            const Color(0xFFF39C12),
            'Route 04: Sector 14 Express (DL 01 PB 4488)',
            'Driver: Ramesh Kumar • 34 Students Boarded • ETA: 8 Mins to Main Gate',
            'LIVE GPS',
            const Color(0xFF00B894),
          ),
          const Divider(height: 20, color: Color(0xFFF1F5F9)),
          _buildPulseItem(
            Icons.videocam_rounded,
            const Color(0xFF0984E3),
            'Security CCTV Infrastructure',
            '12 / 12 High-Definition Cameras Streaming • North Gate, Science Wing & Sports Field',
            '100% ONLINE',
            const Color(0xFF00B894),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseItem(IconData icon, Color iconColor, String title, String sub, String badge, Color badgeColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PulsingLiveDot(size: 5, pulseScale: 2.0, color: badgeColor),
                        const SizedBox(width: 6),
                        Text(badge, style: TextStyle(color: badgeColor, fontSize: 9, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodayScheduleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Key Academic Events',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
              ),
              Text('28 Aug 2026', style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduleRow('10:30 AM', 'Grade 10 Science Practical Exam', 'Lab 2 (Prof. Alok Substitute)', const Color(0xFF6C5CE7)),
          const Divider(height: 20, color: Color(0xFFF1F5F9)),
          _buildScheduleRow('02:00 PM', 'Parent-Teacher Council Review (PTM)', 'Auditorium Block B', const Color(0xFF00B894)),
          const Divider(height: 20, color: Color(0xFFF1F5F9)),
          _buildScheduleRow('04:30 PM', 'Inter-School Athletics Training', 'West Ground Pavilion', const Color(0xFFF39C12)),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(String time, String title, String venue, Color dotColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
          child: Text(time, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B))),
              const SizedBox(height: 2),
              Text(venue, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
        ),
      ],
    );
  }
}
