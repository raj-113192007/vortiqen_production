import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
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

    Color statusDotColor;
    Color statusBg;
    Color statusTextColor;
    if (isMoving) {
      statusDotColor = const Color(0xFF10B981);
      statusBg = const Color(0xFF10B981).withValues(alpha: 0.1);
      statusTextColor = const Color(0xFF047857);
    } else if (isArrived) {
      statusDotColor = const Color(0xFF3B82F6);
      statusBg = const Color(0xFF3B82F6).withValues(alpha: 0.1);
      statusTextColor = const Color(0xFF1D4ED8);
    } else {
      statusDotColor = const Color(0xFFF59E0B);
      statusBg = const Color(0xFFF59E0B).withValues(alpha: 0.1);
      statusTextColor = const Color(0xFFB45309);
    }

    return HoverLiftCard(
      onTap: onOpenDossier,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Bus Plate, Model, Status Badge with pulse
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F46E5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      vehicle.busNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    vehicle.model,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isMoving)
                      PulsingLiveDot(size: 4.5, pulseScale: 2.2, color: statusDotColor)
                    else
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: statusDotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    const SizedBox(width: 6),
                    Text(
                      vehicle.liveStatus,
                      style: TextStyle(
                        color: statusTextColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Route Details & Location info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.near_me_outlined, size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.routeName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Location: ${vehicle.currentLocation} • Speed: ${vehicle.currentSpeed}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Visual Route Timeline Stepper
          if (vehicle.routeStops.isNotEmpty)
            RouteTimelineStepper(
              stops: vehicle.routeStops,
              eta: vehicle.etaToSchool,
            ),
          const SizedBox(height: 10),

          // Footer info: Driver details + Attendance Counter + 360 Action
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                // Driver & Attendant
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.badge_outlined, size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      '${vehicle.driverName} (${vehicle.driverPhone})',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• Attendant: ${vehicle.attendantName}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),

                // Boarding Progress Counter & 360 button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${vehicle.onboardToday}/${vehicle.totalScholars} Boarded',
                        style: const TextStyle(
                          color: Color(0xFF047857),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: onOpenDossier,
                      icon: const Icon(Icons.open_in_new_rounded, size: 13),
                      label: const Text('View 360'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF4F46E5),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
