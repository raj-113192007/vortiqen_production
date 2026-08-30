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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
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
                  Icon(Icons.alt_route_rounded, size: 16, color: Color(0xFF6C5CE7)),
                  SizedBox(width: 6),
                  Text(
                    'Live Route Progress',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ETA: $eta',
                  style: const TextStyle(
                    color: Color(0xFF6C5CE7),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
      nodeColor = const Color(0xFF6C5CE7);
      textColor = const Color(0xFF6C5CE7);
      icon = Icons.directions_bus_filled_rounded;
    } else if (isCompleted) {
      nodeColor = const Color(0xFF00B894);
      textColor = const Color(0xFF334155);
      icon = Icons.check_circle_rounded;
    } else {
      nodeColor = const Color(0xFFCBD5E1);
      textColor = const Color(0xFF94A3B8);
      icon = Icons.radio_button_unchecked_rounded;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isCurrent ? const Color(0xFF6C5CE7).withValues(alpha: 0.15) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: isCurrent ? 20 : 16,
            color: nodeColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stop.stopName,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w600,
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
      width: 44,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      color: isPassed ? const Color(0xFF00B894) : const Color(0xFFCBD5E1),
    );
  }
}
