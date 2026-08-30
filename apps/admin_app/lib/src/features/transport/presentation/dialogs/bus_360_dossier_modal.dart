import 'package:flutter/material.dart';
import '../../domain/transport_models.dart';

class Bus360DossierModal extends StatelessWidget {
  final VehicleFleetInfo vehicle;

  const Bus360DossierModal({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 750,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.directions_bus_rounded, color: Color(0xFF6C5CE7), size: 28),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.busNumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            '${vehicle.model} • Capacity: ${vehicle.capacity} Seats',
                            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Driver & Crew Section
              _buildSectionTitle('Driver & Crew Assignment', Icons.badge_rounded),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.driverName,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(height: 2),
                          Text('Phone: ${vehicle.driverPhone}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text('License: ${vehicle.driverLicense}', style: const TextStyle(fontSize: 11, color: Color(0xFF00B894), fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.attendantName,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(height: 2),
                          Text('Attendant Phone: ${vehicle.attendantPhone}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          const Text('Duty: Student Safety & Boarding Roster', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // RTO Fitness & Legal Compliance
              _buildSectionTitle('RTO Fitness & Legal Compliance', Icons.verified_user_rounded),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildComplianceCard('RTO Fitness', vehicle.fitnessExpiry, Icons.check_circle_rounded, const Color(0xFF00B894))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildComplianceCard('Insurance Policy', vehicle.insuranceExpiry, Icons.shield_rounded, const Color(0xFF0984E3))),
                  const SizedBox(width: 10),
                  Expanded(child: _buildComplianceCard('Pollution (PUC)', vehicle.pucExpiry, Icons.energy_savings_leaf_rounded, const Color(0xFF6C5CE7))),
                ],
              ),
              const SizedBox(height: 20),

              // Fuel & Servicing Stats
              _buildSectionTitle('Fuel Mileage & Maintenance Schedule', Icons.local_gas_station_rounded),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('Last Refuel Date', vehicle.lastFuelDate),
                        _buildStatItem('Fuel Quantity', vehicle.lastFuelQuantity),
                        _buildStatItem('Last Refuel Cost', vehicle.lastFuelCost),
                        _buildStatItem('Mileage Avg', vehicle.fuelMileage, isHighlight: true),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('Last Major Service', vehicle.lastServiceDate),
                        _buildStatItem('Next Scheduled Service', vehicle.nextServiceDate, isAlert: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Modal Footer Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exporting vehicle dossier report for ${vehicle.busNumber}...')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: const Text('Export Dossier PDF'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6C5CE7)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isHighlight = false, bool isAlert = false}) {
    Color textColor = const Color(0xFF1E293B);
    if (isHighlight) textColor = const Color(0xFF6C5CE7);
    if (isAlert) textColor = const Color(0xFFE17055);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: textColor),
        ),
      ],
    );
  }
}
