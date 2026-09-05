import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StudentTransportScreen extends ConsumerStatefulWidget {
  const StudentTransportScreen({super.key});

  @override
  ConsumerState<StudentTransportScreen> createState() => _StudentTransportScreenState();
}

class _StudentTransportScreenState extends ConsumerState<StudentTransportScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  final List<Map<String, dynamic>> _stops = [
    {'name': 'Green Park Main Terminal', 'time': '07:30 AM', 'status': 'PASSED'},
    {'name': 'Sector 12 Metro Station', 'time': '07:42 AM', 'status': 'PASSED'},
    {'name': 'Lotus Valley Crossing (Next Stop)', 'time': '07:50 AM', 'status': 'NEXT'},
    {'name': 'Your Stop: Sector 15 Heights', 'time': '07:58 AM', 'status': 'UPCOMING'},
    {'name': 'VortiQen School Campus Gate 2', 'time': '08:15 AM', 'status': 'UPCOMING'},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Live Bus GPS Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos, color: Colors.red),
            tooltip: 'Emergency SOS',
            onPressed: () => _showSosDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: ResponsiveTwoPane(
            breakpoint: 880,
            leftFlex: 1,
            rightFlex: 1,
            spacing: 24,
            leftPane: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Live Interactive Map Simulation Card
                _buildLiveMapCard(context, primaryColor),
                const SizedBox(height: 16),

                // 2. ETA & Live Status Banner
                _buildEtaCard(context, primaryColor),
                const SizedBox(height: 16),

                // 3. Driver & Vehicle Profile Card
                _buildDriverCard(context, primaryColor),
              ],
            ),
            rightPane: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 4. Route Stop Progression Timeline
                _buildRouteTimeline(context, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveMapCard(BuildContext context, Color primaryColor) {
    final mapHeight = context.isTabletOrDesktop ? 240.0 : 190.0;

    return Container(
      width: double.infinity,
      height: mapHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF334155)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Map Grid & Roads Graphic
          CustomPaint(
            size: Size(double.infinity, mapHeight),
            painter: _MapGridPainter(),
          ),

          // Live Moving Bus Marker
          Positioned(
            left: 140,
            top: 75,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 44 + (_pulseController.value * 16),
                      height: 44 + (_pulseController.value * 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF39C12).withValues(alpha: 0.3 * (1 - _pulseController.value)),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFF39C12), Color(0xFFE67E22)]),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Color(0xFFF39C12), blurRadius: 12, spreadRadius: 2),
                        ],
                      ),
                      child: const Icon(Icons.directions_bus, color: Colors.white, size: 20),
                    ),
                  ],
                );
              },
            ),
          ),

          // Top Info Pill
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00B894),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('GPS LIVE: 38 km/h  •  Route #7', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Recenter Button
          Positioned(
            bottom: 14,
            right: 14,
            child: FloatingActionButton.small(
              heroTag: 'recenter_gps',
              backgroundColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bus location centered on GPS map'), duration: Duration(seconds: 1)),
                );
              },
              child: const Icon(Icons.my_location, color: Color(0xFF0984E3)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEtaCard(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00B894).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.timer_outlined, color: Color(0xFF00B894), size: 26),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arriving in 8 mins',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF15803D), letterSpacing: -0.3),
                ),
                SizedBox(height: 2),
                Text(
                  'Next Pickup: Sector 15 Heights (Your Stop)',
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFF39C12).withValues(alpha: 0.15),
            child: const Icon(Icons.person, color: Color(0xFFF39C12), size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Rajesh Kumar', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(' 4.9', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 2),
                Text('Bus No: DL-01-AB-4092  •  Capacity: 42 Seats', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calling Driver Rajesh Kumar (+91 98765 43210)... 📞')),
              );
            },
            icon: const Icon(Icons.phone_in_talk, color: Color(0xFF00B894)),
            tooltip: 'Call Driver',
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTimeline(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Route #7 Stop Sequence',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stops.length,
            itemBuilder: (context, index) {
              final stop = _stops[index];
              final isPassed = stop['status'] == 'PASSED';
              final isNext = stop['status'] == 'NEXT';

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: isPassed
                              ? const Color(0xFF00B894)
                              : isNext
                                  ? const Color(0xFFF39C12)
                                  : const Color(0xFFE2E8F0),
                          shape: BoxShape.circle,
                          border: isNext ? Border.all(color: Colors.orange.shade200, width: 3) : null,
                        ),
                        child: isPassed ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                      ),
                      if (index != _stops.length - 1)
                        Container(
                          width: 2,
                          height: 36,
                          color: isPassed ? const Color(0xFF00B894) : const Color(0xFFE2E8F0),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stop['name'],
                            style: TextStyle(
                              fontWeight: isNext ? FontWeight.w900 : FontWeight.w700,
                              fontSize: 13,
                              color: isPassed ? Colors.grey[700] : const Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'Scheduled: ${stop['time']}',
                            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isNext)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('ARRIVING', style: TextStyle(color: Color(0xFFB45309), fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSosDialog(BuildContext context) {
    AdaptiveModal.show(
      context: context,
      maxWidth: 480,
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Text('Emergency SOS Alert', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        'This will immediately notify School Transport Head, Principal, and Parents with your real-time bus location.',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('SOS Emergency Alert Sent to School Admin & Parents! 🚨'),
                backgroundColor: Colors.red,
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          child: const Text('Trigger Emergency SOS'),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Simulated Road curve
    final roadPaint = Paint()
      ..color = const Color(0xFF0984E3).withValues(alpha: 0.4)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(20, 40)
      ..lineTo(90, 80)
      ..lineTo(160, 80)
      ..lineTo(240, 140)
      ..lineTo(size.width - 20, 160);

    canvas.drawPath(path, roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
