import 'package:flutter/material.dart';
import '../../domain/transport_models.dart';
import 'route_timeline_stepper.dart';

class FleetVehicleCard extends StatelessWidget {
  final VehicleFleetInfo vehicle;
  final VoidCallback onOpenDossier;

  const FleetVehicleCard({
    super.key,
    required this.vehicle,
    required this.onOpenDossier,
  });

  @override
  Widget build(BuildContext context) {
    final isMoving = vehicle.isMoving;
    final isArrived = vehicle.isArrived;

    Color statusBg;
    Color statusTextColor;
    if (isMoving) {
      statusBg = const Color(0xFF00B894).withValues(alpha: 0.12);
      statusTextColor = const Color(0xFF00B894);
    } else if (isArrived) {
      statusBg = const Color(0xFF0984E3).withValues(alpha: 0.12);
      statusTextColor = const Color(0xFF0984E3);
    } else {
      statusBg = const Color(0xFFE17055).withValues(alpha: 0.12);
      statusTextColor = const Color(0xFFE17055);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Bus Number, Model, Live Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      vehicle.busNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    vehicle.model,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vehicle.liveStatus,
                  style: TextStyle(
                    color: statusTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Route Details & Location info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_rounded, size: 18, color: Color(0xFFE17055)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.routeName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Current Location: ${vehicle.currentLocation} • Speed: ${vehicle.currentSpeed}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Visual Route Timeline Stepper
          if (vehicle.routeStops.isNotEmpty)
            RouteTimelineStepper(
              stops: vehicle.routeStops,
              eta: vehicle.etaToSchool,
            ),
          const SizedBox(height: 14),

          // Footer info: Driver details + Attendance Progress bar + 360 Action
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                // Driver & Attendant
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFE2E8F0),
                      child: Icon(Icons.person, size: 16, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${vehicle.driverName} (${vehicle.driverPhone})',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          'Attendant: ${vehicle.attendantName}',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ],
                ),

                // Boarding Progress Counter & 360 button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B894).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${vehicle.onboardToday} / ${vehicle.totalScholars} Scholars Boarded',
                        style: const TextStyle(
                          color: Color(0xFF00B894),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: onOpenDossier,
                      icon: const Icon(Icons.open_in_new_rounded, size: 14),
                      label: const Text('Bus 360° Dossier'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                        foregroundColor: const Color(0xFF6C5CE7),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
