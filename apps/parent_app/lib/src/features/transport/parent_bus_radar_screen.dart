import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentBusRadarScreen extends StatefulWidget {
  final String childName;
  final String routeName;
  final String busNo;

  const ParentBusRadarScreen({
    super.key,
    this.childName = 'Aarav Sharma',
    this.routeName = 'Route 14 • North City Line',
    this.busNo = 'UP-16-BT-4092',
  });

  @override
  State<ParentBusRadarScreen> createState() => _ParentBusRadarScreenState();
}

class _ParentBusRadarScreenState extends State<ParentBusRadarScreen> {
  final bool _isEmergencyAlert = false;
  final int _currentSpeed = 36; // km/h
  final String _currentLocation = 'Near Sector 62 Metro Junction (1.2 km away)';
  final String _eta = '7 Mins';
  final String _driverName = 'Mr. Rameshwar Singh';
  final String _driverPhone = '+91 98765 43210';
  final String _attendantName = 'Mrs. Sunita Devi';

  final List<Map<String, dynamic>> _routeStops = [
    {
      'stop': 'School Campus Main Gate',
      'time': '02:30 PM',
      'status': 'DEPARTED',
      'isPassed': true,
      'isChildStop': false,
    },
    {
      'stop': 'Sector 50 Central Park',
      'time': '02:42 PM',
      'status': 'DEPARTED',
      'isPassed': true,
      'isChildStop': false,
    },
    {
      'stop': 'Sector 62 Metro Junction',
      'time': '02:55 PM',
      'status': 'EN ROUTE',
      'isPassed': false,
      'isChildStop': false,
    },
    {
      'stop': 'Palm Greens Apartments Gate 2 (Aarav\'s Stop)',
      'time': '03:04 PM',
      'status': 'ESTIMATED 7 MINS',
      'isPassed': false,
      'isChildStop': true,
    },
    {
      'stop': 'Green Valley Sector 78 Terminal',
      'time': '03:20 PM',
      'status': 'SCHEDULED',
      'isPassed': false,
      'isChildStop': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live School Bus Radar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
            Text(
              'Tracking: ${widget.childName} • ${widget.routeName}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emergency Broadcast Banner if triggered
              if (_isEmergencyAlert)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC2626),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Route Alert: Mild Traffic congestion near Sector 62 Flyover. Bus running 4 mins behind regular schedule.',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              // Radar Screen Layout
              ResponsiveTwoPane(
                breakpoint: 900,
                leftFlex: 7,
                rightFlex: 5,
                leftPane: _buildRadarMapViewport(),
                rightPane: _buildTransitTimelineAndDriverCard(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadarMapViewport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Map Container
        Container(
          height: 380,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF334155)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Radar Map Grid Visual
              Positioned.fill(
                child: CustomPaint(
                  painter: _RadarGridPainter(),
                ),
              ),
              // Pulsing concentric radar rings
              const Center(
                child: PulsingLiveDot(
                  color: Color(0xFF00B894),
                  size: 24,
                ),
              ),
              // Bus Marker
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF39C12),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF39C12).withValues(alpha: 0.6),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.directions_bus_filled, color: Colors.white, size: 26),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF39C12)),
                      ),
                      child: Text(
                        widget.busNo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Telemetry Overlay HUD
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: Row(
                    children: [
                      const PulsingLiveDot(color: Color(0xFF10B981), size: 10),
                      const SizedBox(width: 8),
                      const Text(
                        'LIVE GPS ACTIVE',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Speed: $_currentSpeed km/h',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // ETA Badge
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Arrival in $_eta',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Location card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Row(
            children: [
              const Icon(Icons.near_me_rounded, color: Color(0xFF38BDF8), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CURRENT VEHICLE LOCATION',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _currentLocation,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransitTimelineAndDriverCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Driver Contact Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ON-DUTY TRANSIT CREW',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFF39C12).withValues(alpha: 0.2),
                    child: const Icon(Icons.person, color: Color(0xFFF39C12), size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _driverName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Driver • $_driverPhone',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone, color: Color(0xFF10B981)),
                    tooltip: 'Call Driver',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calling Driver $_driverName...')),
                      );
                    },
                  ),
                ],
              ),
              const Divider(color: Color(0xFF334155), height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF00B894).withValues(alpha: 0.2),
                    child: const Icon(Icons.support_agent, color: Color(0xFF00B894), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Bus Attendant: $_attendantName',
                      style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Stop Timeline
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ROUTE 14 TRANSIT STOPS',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 14),
              ..._routeStops.map((stop) {
                final isPassed = stop['isPassed'] == true;
                final isChildStop = stop['isChildStop'] == true;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: isChildStop
                                  ? const Color(0xFF6366F1)
                                  : isPassed
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF64748B),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isChildStop ? Colors.white : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          if (stop != _routeStops.last)
                            Container(
                              width: 2,
                              height: 28,
                              color: isPassed ? const Color(0xFF10B981) : const Color(0xFF334155),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stop['stop'],
                              style: TextStyle(
                                color: isChildStop ? const Color(0xFF818CF8) : Colors.white,
                                fontWeight: isChildStop ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  stop['time'],
                                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isPassed
                                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                        : isChildStop
                                            ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                                            : const Color(0xFF334155),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    stop['status'],
                                    style: TextStyle(
                                      color: isPassed
                                          ? const Color(0xFF10B981)
                                          : isChildStop
                                              ? const Color(0xFF818CF8)
                                              : const Color(0xFF94A3B8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
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
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _RadarGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF334155).withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    const spacing = 35.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
