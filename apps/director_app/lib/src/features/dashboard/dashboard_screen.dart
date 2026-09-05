import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DirectorDashboardScreen extends ConsumerWidget {
  const DirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFF1E293B)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.account_balance, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('VortiQen Director Boardroom', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.approval, color: Color(0xFFD4AF37)),
            tooltip: 'Pending Approvals',
            onPressed: () => context.push('/approvals'),
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
          maxWidth: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Director Executive Header Card
              _buildDirectorHeroCard(),
              const SizedBox(height: 20),
              // Institutional Metrics Strip
              _buildMetricStrip(),
              const SizedBox(height: 24),
              // Executive Action Grid (All 5 Modules)
              const Text(
                'Executive Governance & Strategic Command',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 14),
              _buildDirectorActionGrid(context),
              const SizedBox(height: 24),
              // Institutional Highlights & Approvals Snapshot
              _buildExecutiveHighlights(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectorHeroCard() {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.2),
            child: const Icon(Icons.military_tech_rounded, color: Color(0xFFB8860B), size: 34),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dr. Rajeshwar Shastri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF0F172A))),
                const SizedBox(height: 2),
                Text('Managing Director & Board Chair • Delhi Public School Campus', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                Text('Session 2026-27 • 1,448 Enrolled Students • 92 Faculty Members', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD4AF37)),
            ),
            child: const Text('GOVERNANCE LEVEL', style: TextStyle(color: Color(0xFF8C7118), fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricStrip() {
    return Row(
      children: [
        Expanded(
          child: _buildMiniMetricCard(
            title: 'Annual Revenue',
            value: '₹ 4.82 Cr',
            sub: '+14.2% YoY',
            color: const Color(0xFFD4AF37),
            icon: Icons.currency_rupee,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMiniMetricCard(
            title: 'Active Students',
            value: '1,448',
            sub: '98.4% Retention',
            color: const Color(0xFF0984E3),
            icon: Icons.school,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMiniMetricCard(
            title: 'Faculty Strength',
            value: '92 Members',
            sub: '1:16 Ratio',
            color: const Color(0xFF00B894),
            icon: Icons.badge,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMiniMetricCard(
            title: 'Attendance Index',
            value: '94.8%',
            sub: 'Term Average',
            color: const Color(0xFF6366F1),
            icon: Icons.fact_check_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniMetricCard({
    required String title,
    required String value,
    required String sub,
    required Color color,
    required IconData icon,
  }) {
    return AnimatedCard(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: Color(0xFF64748B))),
              Icon(icon, color: color, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color)),
          const SizedBox(height: 2),
          Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDirectorActionGrid(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Command HUD',
        'subtitle': 'Realtime Campus Telemetry',
        'icon': Icons.space_dashboard_outlined,
        'color': const Color(0xFFD4AF37),
        'route': '/command-hud',
      },
      {
        'title': 'Cash Flow & Treasury',
        'subtitle': '₹4.82 Cr Revenue & OpEx',
        'icon': Icons.account_balance_wallet_outlined,
        'color': const Color(0xFF10B981),
        'route': '/cash-flow',
      },
      {
        'title': 'Academic Matrix',
        'subtitle': 'Class GPAs & Syllabus Target',
        'icon': Icons.auto_stories_outlined,
        'color': const Color(0xFF6366F1),
        'route': '/academic-matrix',
      },
      {
        'title': 'Admissions Funnel',
        'subtitle': '240 / 250 Seats Enrolled (96%)',
        'icon': Icons.filter_alt_outlined,
        'color': const Color(0xFF0984E3),
        'route': '/admissions-funnel',
      },
      {
        'title': 'Capex Approvals',
        'subtitle': '3 Requisitions (₹19.55L)',
        'icon': Icons.verified_user_outlined,
        'color': const Color(0xFFEF4444),
        'route': '/approvals',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsiveGridCount(mobile: 2, tablet: 3, desktop: 5),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.3,
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
                    color: col.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(a['icon'] as IconData, color: col, size: 22),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
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

  Widget _buildExecutiveHighlights(BuildContext context) {
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
              const Text('Executive Governance Board Highlights', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              TextButton(onPressed: () => context.push('/approvals'), child: const Text('Review Approvals')),
            ],
          ),
          const SizedBox(height: 12),
          _buildHighlightTile(
            icon: Icons.computer,
            color: const Color(0xFF6366F1),
            title: 'Capex Requisition: ₹ 14.50 Lakhs for AI Lab Workstations',
            subtitle: 'Submitted by IT Head Mr. Rajesh Mehra • Pending Board Signature',
          ),
          const Divider(height: 16),
          _buildHighlightTile(
            icon: Icons.emoji_events,
            color: const Color(0xFFD4AF37),
            title: 'CBSE Regional Olympiad: 12 Students Qualified for National Finals',
            subtitle: 'Delhi Public School ranks #1 in North Region in STEM Olympiad',
          ),
          const Divider(height: 16),
          _buildHighlightTile(
            icon: Icons.pie_chart,
            color: const Color(0xFF10B981),
            title: 'Admissions Target 96% Met: 240 / 250 Seats Enrolled',
            subtitle: 'New Session 2026-27 Orientation scheduled for 1st October',
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF1E293B))),
              Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }
}
