import 'package:flutter/material.dart';
import '../../domain/transport_models.dart';
import '../widgets/fleet_vehicle_card.dart';
import '../dialogs/bus_360_dossier_modal.dart';

class FleetTrackingTab extends StatelessWidget {
  final List<VehicleFleetInfo> fleet;
  final VoidCallback onBroadcastAlert;

  const FleetTrackingTab({
    super.key,
    required this.fleet,
    required this.onBroadcastAlert,
  });

  @override
  Widget build(BuildContext context) {
    if (fleet.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bus_rounded, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text(
              'No fleet vehicles matched your search.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Tab Quick Actions Ribbon
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00B894),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${fleet.length} Buses in Live Monitoring Mode',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onBroadcastAlert,
                icon: const Icon(Icons.campaign_rounded, size: 16),
                label: const Text('Broadcast Route Delay / Alert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B894),
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
        const SizedBox(height: 16),

        // List of Vehicle Cards
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fleet.length,
          itemBuilder: (context, index) {
            final v = fleet[index];
            return FleetVehicleCard(
              vehicle: v,
              onOpenDossier: () {
                showDialog(
                  context: context,
                  builder: (ctx) => Bus360DossierModal(vehicle: v),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
