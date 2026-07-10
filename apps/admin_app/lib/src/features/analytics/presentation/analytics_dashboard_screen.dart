import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.description),
            tooltip: 'View Reports',
            onPressed: () => context.go('/analytics/reports'),
          ),
        ],
      ),
      body: metricsAsync.when(
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(metrics, context),
              const SizedBox(height: 32),
              Text('Asset Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildAssetPieChart(metrics, context),
              ),
              const SizedBox(height: 32),
              Text('Users Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildUsersBarChart(metrics, context),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSummaryCards(DashboardMetrics metrics, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.5,
          children: [
            _buildCard('Total Revenue', '₹${metrics.totalRevenue}', Colors.green, context),
            _buildCard('Total Students', '${metrics.totalStudents}', Colors.blue, context),
            _buildCard('Pending Enquiries', '${metrics.pendingEnquiries}', Colors.orange, context),
            _buildCard('Total Assets', '${metrics.totalAssets}', Colors.purple, context),
          ],
        );
      },
    );
  }

  Widget _buildCard(String title, String value, Color color, BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetPieChart(DashboardMetrics metrics, BuildContext context) {
    final available = metrics.totalAssets - metrics.assignedAssets;
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 60,
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: available.toDouble(),
            title: 'Available\n($available)',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: metrics.assignedAssets.toDouble(),
            title: 'Assigned\n(${metrics.assignedAssets})',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersBarChart(DashboardMetrics metrics, BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (metrics.totalStudents > metrics.totalTeachers ? metrics.totalStudents : metrics.totalTeachers).toDouble() * 1.2,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Students');
                  case 1:
                    return const Text('Teachers');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: metrics.totalStudents.toDouble(),
                color: Colors.blue,
                width: 22,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: metrics.totalTeachers.toDouble(),
                color: Colors.redAccent,
                width: 22,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
