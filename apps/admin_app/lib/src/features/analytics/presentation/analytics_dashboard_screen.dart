import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:go_router/go_router.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);
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
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          metricsAsync.when(
            data: (metrics) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Summary KPI Cards
                FadeSlideEntry(
                  delay: const Duration(milliseconds: 100),
                  child: _buildSummaryCards(metrics, context),
                ),
                const SizedBox(height: 24),

                // 3. Charts Row
                FadeSlideEntry(
                  delay: const Duration(milliseconds: 150),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildAssetChartCard(metrics, context)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildUsersChartCard(metrics, context)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildAssetChartCard(metrics, context),
                            const SizedBox(height: 20),
                            _buildUsersChartCard(metrics, context),
                          ],
                        ),
                ),
              ],
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                'Executive Analytics & Intelligence Cockpit',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'High-Level Campus Operations, Revenue Realisation, Student Demographics & Asset Utilization',
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
                    Text('REAL-TIME ANALYTICS', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => context.go('/analytics/reports'),
                icon: const Icon(Icons.description_rounded, size: 16),
                label: const Text('Export Reports'),
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

  Widget _buildSummaryCards(DashboardMetrics metrics, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 850 ? 4 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 4 ? 2.3 : 2.0,
          children: [
            _buildMetricTile(metrics.totalRevenue.toDouble(), 'Total Revenue', '₹ ', 'Fee & Transport', Icons.account_balance_wallet_outlined, const Color(0xFF10B981), 0),
            _buildMetricTile(metrics.totalStudents.toDouble(), 'Total Enrolled', '', 'Across 32 Sections', Icons.people_alt_outlined, const Color(0xFF6C5CE7), 0),
            _buildMetricTile(metrics.pendingEnquiries.toDouble(), 'Open Enquiries', '', 'Pipeline Lead Count', Icons.contact_mail_outlined, const Color(0xFFF59E0B), 0),
            _buildMetricTile(metrics.totalAssets.toDouble(), 'Registered Assets', '', 'Hardware & Furniture', Icons.inventory_2_outlined, const Color(0xFF0984E3), 0),
          ],
        );
      },
    );
  }

  Widget _buildMetricTile(double value, String label, String prefix, String sub, IconData icon, Color color, int fractionDigits) {
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
                  prefix: prefix,
                  fractionDigits: fractionDigits,
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

  Widget _buildAssetChartCard(DashboardMetrics metrics, BuildContext context) {
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
          const Text('Asset Allocation Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 2),
          const Text('Inventory status: Available vs Assigned', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: _buildAssetPieChart(metrics, context),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersChartCard(DashboardMetrics metrics, BuildContext context) {
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
          const Text('Campus Demographics', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 2),
          const Text('Student vs Faculty Headcount', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: _buildUsersBarChart(metrics, context),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetPieChart(DashboardMetrics metrics, BuildContext context) {
    final available = metrics.totalAssets - metrics.assignedAssets;
    return PieChart(
      PieChartData(
        sectionsSpace: 4,
        centerSpaceRadius: 50,
        sections: [
          PieChartSectionData(
            color: const Color(0xFF10B981),
            value: available > 0 ? available.toDouble() : 1,
            title: 'Available\n($available)',
            radius: 54,
            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          PieChartSectionData(
            color: const Color(0xFF6C5CE7),
            value: metrics.assignedAssets > 0 ? metrics.assignedAssets.toDouble() : 1,
            title: 'Assigned\n(${metrics.assignedAssets})',
            radius: 54,
            titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersBarChart(DashboardMetrics metrics, BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (metrics.totalStudents > metrics.totalTeachers ? metrics.totalStudents : metrics.totalTeachers).toDouble() * 1.25,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Students', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF475569))),
                    );
                  case 1:
                    return const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Faculty Staff', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF475569))),
                    );
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (val, meta) => Text(val.toInt().toString(), style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) => const FlLine(color: Color(0xFFF1F5F9), strokeWidth: 1)),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: metrics.totalStudents.toDouble(),
                color: const Color(0xFF6C5CE7),
                width: 28,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: metrics.totalTeachers.toDouble(),
                color: const Color(0xFF00B894),
                width: 28,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
