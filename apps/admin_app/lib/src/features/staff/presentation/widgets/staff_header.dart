import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StaffHeader extends StatelessWidget {
  final VoidCallback onAddStaff;
  final VoidCallback onBulkUpload;

  const StaffHeader({
    super.key,
    required this.onAddStaff,
    required this.onBulkUpload,
  });

  @override
  Widget build(BuildContext context) {
    return FadeSlideEntry(
      duration: const Duration(milliseconds: 450),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Faculty & Staff Directory',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Faculty Workloads • Class Teacher Allocations • Payroll Status • Live Leaves',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: onBulkUpload,
                      icon: const Icon(Icons.upload_file_rounded, size: 15),
                      label: const Text('Bulk Onboarding'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4F46E5),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: onAddStaff,
                      icon: const Icon(Icons.person_add_rounded, size: 15),
                      label: const Text('Add Faculty'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 4 Animated Metrics
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 720;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isNarrow ? 2 : 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: isNarrow ? 2.5 : 2.8,
                  children: [
                    _buildAnimatedMetricTile(48, '', ' Faculty Members', '32 Teaching • 16 Admin/Ops', Icons.school_outlined, const Color(0xFF4F46E5), 0),
                    _buildAnimatedMetricTile(98.4, '', '% Today\'s Attendance', '46 Present • 2 On Leave', Icons.how_to_reg_outlined, const Color(0xFF10B981), 1),
                    _buildAnimatedMetricTile(24, 'Avg ', ' Periods/Wk', 'Standard Workload Distribution', Icons.schedule_outlined, const Color(0xFF0284C7), 0),
                    _buildAnimatedMetricTile(100, '', '% Payroll Disbursed', 'August Cycle Cleared', Icons.account_balance_wallet_outlined, const Color(0xFFD946EF), 0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMetricTile(
    double value,
    String prefix,
    String suffix,
    String sub,
    IconData icon,
    Color color,
    int fractionDigits,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  prefix: prefix,
                  suffix: suffix,
                  fractionDigits: fractionDigits,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: color),
                ),
                Text(
                  sub,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
