import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../../domain/transport_models.dart';
import '../dialogs/log_service_modal.dart';

class MaintenanceTab extends StatelessWidget {
  final List<VehicleFleetInfo> fleet;
  final VoidCallback? onRefresh;

  const MaintenanceTab({
    super.key,
    required this.fleet,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Compliance Overview Ribbon
        FadeSlideEntry(
          duration: const Duration(milliseconds: 350),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.verified_user_rounded, size: 18, color: Color(0xFF10B981)),
                    SizedBox(width: 8),
                    Text(
                      'Fleet RTO Fitness & Preventive Maintenance Vault',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => LogServiceModal(
                        onSave: (val) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Maintenance log saved for ${val['busNumber']}.')),
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Log Service / Overhaul'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // List of Maintenance Cards
        FadeSlideEntry(
          delay: const Duration(milliseconds: 100),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fleet.length,
            itemBuilder: (context, index) {
              final v = fleet[index];
              final hasAlert = v.insuranceExpiry.toLowerCase().contains('due') || v.nextServiceDate.toLowerCase().contains('soon');

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: HoverLiftCard(
                  padding: const EdgeInsets.all(18),
                  borderRadius: 16,
                  borderColor: hasAlert ? const Color(0xFFF59E0B) : const Color(0xFFE2E8F0),
                  hoverBorderColor: hasAlert ? const Color(0xFFF59E0B) : const Color(0xFF6C5CE7).withValues(alpha: 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Bus No & RTO Fitness Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                v.busNumber,
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(width: 8),
                              Text('(${v.model})', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'RTO Fitness: ${v.fitnessExpiry}',
                              style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 2: Last & Next Service
                      Row(
                        children: [
                          Expanded(child: _buildDetailPill('Last Overhaul / Servicing', v.lastServiceDate, Icons.build_rounded, const Color(0xFF0984E3))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildDetailPill(
                              'Next Due Date',
                              v.nextServiceDate,
                              Icons.event_rounded,
                              hasAlert ? const Color(0xFFF59E0B) : const Color(0xFF6C5CE7),
                              isAlert: hasAlert,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Row 3: Insurance & PUC
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailPill(
                              'Insurance Policy',
                              v.insuranceExpiry,
                              Icons.security_rounded,
                              hasAlert ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
                              isAlert: hasAlert,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: _buildDetailPill('Pollution Control (PUC)', v.pucExpiry, Icons.energy_savings_leaf_rounded, const Color(0xFF6C5CE7))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailPill(String title, String val, IconData icon, Color color, {bool isAlert = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAlert ? const Color(0xFFFFFBEB) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isAlert ? const Color(0xFFFDE68A) : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  val,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isAlert ? const Color(0xFFB45309) : const Color(0xFF1E293B),
                  ),
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
