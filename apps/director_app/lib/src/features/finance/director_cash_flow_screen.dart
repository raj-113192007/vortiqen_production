import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorCashFlowScreen extends StatelessWidget {
  const DirectorCashFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Financial Governance & Cash Flow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Institutional Treasury • FY 2026-27', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Color(0xFFD4AF37)),
            tooltip: 'Export Financial Audit Report',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading Board of Directors Financial Statement PDF...')),
              );
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
              // KPI Row
              Row(
                children: [
                  Expanded(
                    child: _buildFinanceCard(
                      title: 'YTD Total Revenue',
                      value: '₹ 4.82 Cr',
                      sub: '92.7% of annual ₹ 5.20 Cr target',
                      color: const Color(0xFFD4AF37),
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildFinanceCard(
                      title: 'MTD Inflow (Sep)',
                      value: '₹ 42.8 Lakhs',
                      sub: '+8.4% compared to last month',
                      color: const Color(0xFF10B981),
                      icon: Icons.trending_up_rounded,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildFinanceCard(
                      title: 'Monthly OpEx Burn',
                      value: '₹ 28.4 Lakhs',
                      sub: 'Payroll: ₹21.2L • Fleet/Ops: ₹7.2L',
                      color: const Color(0xFF6366F1),
                      icon: Icons.local_fire_department_outlined,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildFinanceCard(
                      title: 'Total Pending Dues',
                      value: '₹ 38.4 Lakhs',
                      sub: '142 student invoices outstanding',
                      color: const Color(0xFFEF4444),
                      icon: Icons.pending_actions_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Defaulters Aging & Budget Distribution
              ResponsiveTwoPane(
                breakpoint: 880,
                leftFlex: 6,
                rightFlex: 5,
                leftPane: _buildAgingAnalysisPane(),
                rightPane: _buildDepartmentBudgetPane(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinanceCard({
    required String title,
    required String value,
    required String sub,
    required Color color,
    required IconData icon,
  }) {
    return AnimatedCard(
      padding: const EdgeInsets.all(18),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF64748B))),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: color)),
          const SizedBox(height: 4),
          Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildAgingAnalysisPane() {
    final agingBuckets = [
      {'bucket': 'Current Dues (< 30 Days)', 'amount': '₹ 18.2 Lakhs', 'count': '82 Students', 'color': const Color(0xFFF59E0B), 'pct': 0.47},
      {'bucket': 'Overdue (30 - 60 Days)', 'amount': '₹ 12.4 Lakhs', 'count': '42 Students', 'color': const Color(0xFFEA580C), 'pct': 0.32},
      {'bucket': 'Critical Delinquent (> 60 Days)', 'amount': '₹ 7.8 Lakhs', 'count': '18 Students', 'color': const Color(0xFFDC2626), 'pct': 0.21},
    ];

    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fee Defaulter Aging Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Text('Automated SMS & App reminders active for all buckets', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 20),
          ...agingBuckets.map((b) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(b['bucket'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('${b['amount']} (${b['count']})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: b['color'] as Color)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: b['pct'] as double,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation<Color>(b['color'] as Color),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDepartmentBudgetPane() {
    final budgets = [
      {'dept': 'Faculty & Staff Payroll', 'allocated': '₹ 2.54 Cr (52.7%)', 'pct': 0.53, 'color': const Color(0xFF10B981)},
      {'dept': 'Campus Infrastructure & Maintenance', 'allocated': '₹ 84 Lakhs (17.4%)', 'pct': 0.17, 'color': const Color(0xFF3B82F6)},
      {'dept': 'Transport Fleet Fuel & Servicing', 'allocated': '₹ 56 Lakhs (11.6%)', 'pct': 0.12, 'color': const Color(0xFFF59E0B)},
      {'dept': 'STEM Labs & Robotics Equipment', 'allocated': '₹ 48 Lakhs (10.0%)', 'pct': 0.10, 'color': const Color(0xFF8B5CF6)},
      {'dept': 'Digital LMS & Software Licenses', 'allocated': '₹ 40 Lakhs (8.3%)', 'pct': 0.08, 'color': const Color(0xFFEC4899)},
    ];

    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Departmental Capital & OpEx Budget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
          const SizedBox(height: 16),
          ...budgets.map((d) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d['dept'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      Text(d['allocated'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: d['pct'] as double,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation<Color>(d['color'] as Color),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
