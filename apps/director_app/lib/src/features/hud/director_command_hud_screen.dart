import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorCommandHudScreen extends StatelessWidget {
  const DirectorCommandHudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institutional Command HUD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            Text('Live Telemetry • Delhi Public School Campus', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
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
              // Realtime Rollup Metrics
              Row(
                children: [
                  Expanded(
                    child: _buildTelemetryCard(
                      title: 'Live Student Roll Call',
                      value: '94.8%',
                      subtitle: '1,373 / 1,448 Present Today',
                      color: const Color(0xFF10B981),
                      icon: Icons.how_to_reg,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildTelemetryCard(
                      title: 'Faculty On Duty',
                      value: '97.8%',
                      subtitle: '90 / 92 Staff Checked In',
                      color: const Color(0xFF38BDF8),
                      icon: Icons.badge,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildTelemetryCard(
                      title: 'Transport Fleet Status',
                      value: '18 / 18 Active',
                      subtitle: '0 SOS Alerts • GPS Normal',
                      color: const Color(0xFFFBBF24),
                      icon: Icons.directions_bus,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildTelemetryCard(
                      title: 'Campus Perimeter AI',
                      value: 'SECURE',
                      subtitle: '36 CCTV Feeds Streaming',
                      color: const Color(0xFFA78BFA),
                      icon: Icons.security,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Campus Operations Grid
              ResponsiveTwoPane(
                breakpoint: 880,
                leftFlex: 6,
                rightFlex: 5,
                leftPane: _buildCampusOperationsFeed(context),
                rightPane: _buildExecutiveEmergencyBroadcast(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTelemetryCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildCampusOperationsFeed(BuildContext context) {
    final events = [
      {'time': '02:30 PM', 'event': 'Afternoon Bus Fleet Departure for 18 designated routes', 'tag': 'FLEET', 'color': Color(0xFFFBBF24)},
      {'time': '01:15 PM', 'event': 'CBSE Grade 10 Physics Practical Exam concluded in Lab 2', 'tag': 'ACADEMICS', 'color': Color(0xFF38BDF8)},
      {'time': '11:45 AM', 'event': 'Quarterly Fire Extinguisher & Hydrant Audit Passed', 'tag': 'SAFETY', 'color': Color(0xFF10B981)},
      {'time': '09:00 AM', 'event': 'Morning Assembly & Special Merit Recognition by Principal', 'tag': 'CAMPUS', 'color': Color(0xFFA78BFA)},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live Campus Operational Timeline', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Icon(Icons.timeline, color: Color(0xFF94A3B8), size: 18),
            ],
          ),
          const SizedBox(height: 16),
          ...events.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e['time'] as String, style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: (e['color'] as Color).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                    child: Text(e['tag'] as String, style: TextStyle(color: e['color'] as Color, fontWeight: FontWeight.bold, fontSize: 10)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(e['event'] as String, style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 13)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildExecutiveEmergencyBroadcast(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Director\'s Priority Broadcast Desk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            'Transmit immediate official message to all 1,448 parents and 92 faculty devices.',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Type institutional announcement or weather advisory notice...',
              hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
              filled: true,
              fillColor: const Color(0xFF0F172A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF334155))),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Official Institutional Circular broadcasted to all Parent & Teacher apps!'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded, size: 16),
              label: const Text('Send Broadcast Notice', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0F172A),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
