import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorDashboardScreen extends ConsumerWidget {
  const DirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value?.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Text('VortiQen Director'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vibrant Header
            VibrantHeader(
              role: AppRole.director,
              title: 'Executive Boardroom',
              subtitle: 'Delhi Public International School • Academic Year 2026-27',
              userName: user?.name ?? 'Director',
            ),

            const SizedBox(height: 28),

            // Top Financial & Operational Metric Cards
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: 'Total Annual Revenue',
                    value: '₹ 4.82 Cr',
                    subtitle: '+14.2% YoY growth',
                    icon: Icons.currency_rupee_rounded,
                    color: const Color(0xFFD4AF37),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    title: 'Total Enrolled Students',
                    value: '1,448',
                    subtitle: '98.4% retention rate',
                    icon: Icons.school_rounded,
                    color: const Color(0xFF0984E3),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    title: 'Faculty & Staff Strength',
                    value: '92 Members',
                    subtitle: '1:16 Student-Teacher ratio',
                    icon: Icons.badge_rounded,
                    color: const Color(0xFF00B894),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    title: 'Fee Collection Index',
                    value: '91.8%',
                    subtitle: '₹ 38.4 Lakhs pending',
                    icon: Icons.pie_chart_rounded,
                    color: const Color(0xFFE84393),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Strategic Insights
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Academic Performance Snapshot
                Expanded(
                  flex: 3,
                  child: AnimatedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Institutional Health & KPI Matrix',
                              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF1E293B)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Grade A+', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildKpiRow('Average Board Examination Score', '86.4%', 0.864, const Color(0xFF00B894)),
                        const SizedBox(height: 14),
                        _buildKpiRow('Daily Campus Attendance Average', '94.1%', 0.941, const Color(0xFF0984E3)),
                        const SizedBox(height: 14),
                        _buildKpiRow('Parent Satisfaction Rating (NPS)', '4.8 / 5.0', 0.96, const Color(0xFFD4AF37)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Quick Export & Executive Actions
                Expanded(
                  flex: 2,
                  child: AnimatedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Executive Directives',
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF1E293B)),
                        ),
                        const SizedBox(height: 16),
                        _buildActionTile(
                          icon: Icons.picture_as_pdf_rounded,
                          title: 'Download Board Presentation PDF',
                          subtitle: 'Comprehensive monthly performance deck',
                          color: const Color(0xFFD4AF37),
                        ),
                        const SizedBox(height: 12),
                        _buildActionTile(
                          icon: Icons.account_balance_wallet_rounded,
                          title: 'Approve Staff Payroll (Aug 2026)',
                          subtitle: '92 employees • ₹ 32.4 Lakhs total',
                          color: const Color(0xFF00B894),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return AnimatedCard(
      borderColor: color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B), fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF00B894), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildKpiRow(String label, String valText, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF334155), fontWeight: FontWeight.w500)),
            Text(valText, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFFE2E8F0),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  Widget _buildActionTile({required IconData icon, required String title, required String subtitle, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12, color: const Color(0xFF1E293B))),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
