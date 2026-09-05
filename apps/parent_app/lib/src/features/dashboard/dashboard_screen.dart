import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedChildIndex = 0;

  final List<Map<String, dynamic>> _children = [
    {
      'name': 'Aarav Sharma',
      'class': 'Class 10-A',
      'rollNo': '1024',
      'attendance': '94.2%',
      'busRoute': 'Route 14',
      'busStatus': 'En Route • 7 Mins Away',
      'dueFees': '₹24,500',
    },
    {
      'name': 'Ananya Sharma',
      'class': 'Class 6-B',
      'rollNo': '618',
      'attendance': '96.8%',
      'busRoute': 'Route 14',
      'busStatus': 'En Route • 7 Mins Away',
      'dueFees': '₹0 (Paid)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentChild = _children[_selectedChildIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF7675), Color(0xFFF39C12)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.family_restroom, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'VortiQen Parent Portal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF334155)),
            onPressed: () => context.push('/notices'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Child Switcher Header Card
              _buildChildSwitcherCard(theme, currentChild),
              const SizedBox(height: 20),
              // Live Transport Radar Alert Card
              _buildLiveBusCard(context, currentChild),
              const SizedBox(height: 24),
              // Quick Action Grid (All Core Feature Modules)
              const Text(
                'Parent Action Command Center',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 14),
              _buildQuickActionsGrid(context),
              const SizedBox(height: 24),
              // Today's Activity & Academic Snapshot
              _buildRecentActivitySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildSwitcherCard(ThemeData theme, Map<String, dynamic> child) {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFFF7675).withOpacity(0.2),
                child: const Icon(Icons.face_6_rounded, size: 32, color: Color(0xFFFF7675)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${child['class']} • Roll No: ${child['rollNo']} • Delhi Public School',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Switch Child Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedChildIndex,
                    isDense: true,
                    icon: const Icon(Icons.swap_horiz, size: 18, color: Color(0xFF6366F1)),
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: const Text('Aarav (10-A)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: const Text('Ananya (6-B)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedChildIndex = val);
                    },
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniMetric('Attendance', child['attendance'], const Color(0xFF10B981)),
              Container(width: 1, height: 24, color: const Color(0xFFE2E8F0)),
              _buildMiniMetric('Transport', child['busRoute'], const Color(0xFFF59E0B)),
              Container(width: 1, height: 24, color: const Color(0xFFE2E8F0)),
              _buildMiniMetric('Pending Due', child['dueFees'], child['dueFees'] == '₹0 (Paid)' ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
      ],
    );
  }

  Widget _buildLiveBusCard(BuildContext context, Map<String, dynamic> child) {
    return AnimatedCard(
      padding: const EdgeInsets.all(18),
      color: const Color(0xFF1E293B),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_bus_filled, color: Color(0xFFFBBF24), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'BUS TRACKER RADAR',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${child['busRoute']} is ${child['busStatus']}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Driver: Rameshwar Singh • Next Stop: Palm Greens Gate 2',
                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => context.push('/bus-radar'),
            icon: const Icon(Icons.radar, size: 16),
            label: const Text('Open Radar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Live Bus Radar',
        'subtitle': 'Realtime GPS & Stop ETA',
        'icon': Icons.map_outlined,
        'color': const Color(0xFFF59E0B),
        'route': '/bus-radar',
      },
      {
        'title': 'Homework Desk',
        'subtitle': '1 Due Soon • 2 Graded',
        'icon': Icons.assignment_outlined,
        'color': const Color(0xFF6366F1),
        'route': '/homework',
      },
      {
        'title': 'Attendance & Leaves',
        'subtitle': '94.2% Attendance • Apply',
        'icon': Icons.calendar_month_outlined,
        'color': const Color(0xFF10B981),
        'route': '/attendance-leave',
      },
      {
        'title': 'Online Fee Pay',
        'subtitle': '₹24,500 Outstanding',
        'icon': Icons.payment_outlined,
        'color': const Color(0xFFEF4444),
        'route': '/fees',
      },
      {
        'title': 'PTM Booking',
        'subtitle': '1-on-1 Teacher Slots',
        'icon': Icons.groups_outlined,
        'color': const Color(0xFF0984E3),
        'route': '/ptm',
      },
      {
        'title': 'Term Report Card',
        'subtitle': '93.2% Distinction Score',
        'icon': Icons.auto_stories_outlined,
        'color': const Color(0xFF8B5CF6),
        'route': '/reports',
      },
      {
        'title': 'School Notices',
        'subtitle': '4 Official Circulars',
        'icon': Icons.campaign_outlined,
        'color': const Color(0xFFEC4899),
        'route': '/notices',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsiveGridCount(mobile: 2, tablet: 3, desktop: 4),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.35,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final a = actions[index];
        final col = a['color'] as Color;

        return AnimatedCard(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: InkWell(
            onTap: () => context.push(a['route'] as String),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: col.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(a['icon'] as IconData, color: col, size: 22),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      a['subtitle'] as String,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Student Milestones & Logs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              TextButton(onPressed: () => context.push('/homework'), child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 12),
          _buildActivityTile(
            icon: Icons.grade,
            color: const Color(0xFF10B981),
            title: 'Calculus Assignment Graded: 28/30 (A+)',
            time: 'Yesterday, 06:45 PM • by Mr. Anil Kapoor',
          ),
          const Divider(height: 16),
          _buildActivityTile(
            icon: Icons.directions_bus,
            color: const Color(0xFFF59E0B),
            title: 'Aarav Boarded Bus at School Gate Stop',
            time: 'Today, 02:30 PM • Driver Rameshwar Singh',
          ),
          const Divider(height: 16),
          _buildActivityTile(
            icon: Icons.receipt,
            color: const Color(0xFF6366F1),
            title: 'Q3 Fee Invoice Generated: ₹24,500',
            time: '01 Sep 2026 • Due by 15 Oct 2026',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B))),
              Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }
}
