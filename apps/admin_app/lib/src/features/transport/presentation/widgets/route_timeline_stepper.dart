import 'package:flutter/material.dart';
import '../../domain/transport_models.dart';

class RouteTimelineStepper extends StatelessWidget {
  final List<RouteStopInfo> stops;
  final String eta;

  const RouteTimelineStepper({
    super.key,
    required this.stops,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    if (stops.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.alt_route_rounded, size: 14, color: Color(0xFF4F46E5)),
                  SizedBox(width: 5),
                  Text(
                    'Route Stops',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Text(
                'ETA: $eta',
                style: const TextStyle(
                  color: Color(0xFF4F46E5),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < stops.length; i++) ...[
                  _buildStopNode(stops[i]),
                  if (i < stops.length - 1) _buildConnectingLine(stops[i], stops[i + 1]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopNode(RouteStopInfo stop) {
    final isCurrent = stop.isCurrent;
    final isCompleted = stop.isCompleted;

    Color nodeColor;
    Color textColor;
    IconData icon;

    if (isCurrent) {
      nodeColor = const Color(0xFF4F46E5);
      textColor = const Color(0xFF4F46E5);
      icon = Icons.directions_bus_filled_rounded;
    } else if (isCompleted) {
      nodeColor = const Color(0xFF10B981);
      textColor = const Color(0xFF334155);
      icon = Icons.check_circle_rounded;
    } else {
      nodeColor = const Color(0xFF94A3B8);
      textColor = const Color(0xFF94A3B8);
      icon = Icons.radio_button_unchecked_rounded;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: isCurrent ? 15 : 13,
          color: nodeColor,
        ),
        const SizedBox(height: 2),
        Text(
          stop.stopName,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
            color: textColor,
          ),
        ),
        Text(
          stop.scheduledTime,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectingLine(RouteStopInfo current, RouteStopInfo next) {
    final isPassed = current.isCompleted;
    return Container(
      width: 32,
      height: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      color: isPassed ? const Color(0xFF10B981) : const Color(0xFFCBD5E1),
    );
  }
}
