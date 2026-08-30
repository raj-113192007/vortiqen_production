import 'package:flutter/material.dart';

class StudentsHeader extends StatelessWidget {
  final VoidCallback onEnrollStudent;
  final VoidCallback onBulkImport;

  const StudentsHeader({
    super.key,
    required this.onEnrollStudent,
    required this.onBulkImport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'Student Information System',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Scholastic Profiles • Attendance Records • Fee Clearance • KYC Verification',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: onBulkImport,
                    icon: const Icon(Icons.file_upload_outlined, size: 15),
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
                    onPressed: onEnrollStudent,
                    icon: const Icon(Icons.person_add_alt_rounded, size: 15),
                    label: const Text('Enroll Student'),
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

          // 4 Compact Pulse Metrics
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
                  _buildMetricTile('1,420 Enrolled', '724 Boys • 696 Girls', Icons.school_outlined, const Color(0xFF4F46E5)),
                  _buildMetricTile('96.8% Attendance', '1,374 Present Today', Icons.how_to_reg_outlined, const Color(0xFF10B981)),
                  _buildMetricTile('88.7% Fee Clearance', '1,280 Paid • 140 Due', Icons.account_balance_wallet_outlined, const Color(0xFF0284C7)),
                  _buildMetricTile('412 Bus Commuters', '8 Active GPS Corridors', Icons.directions_bus_outlined, const Color(0xFFD946EF)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String title, String sub, IconData icon, Color color) {
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
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: color),
                  overflow: TextOverflow.ellipsis,
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
