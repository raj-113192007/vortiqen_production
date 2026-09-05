import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isGpsActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBF7),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFF39C12), Color(0xFFE67E22)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.directions_bus_filled, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('VortiQen Driver Cockpit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.sos_rounded, color: Color(0xFFEF4444), size: 26),
            tooltip: 'Emergency SOS',
            onPressed: () => context.push('/sos'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFEF4444)),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Driver & Vehicle Hero Card
              _buildDriverHeroCard(),
              const SizedBox(height: 20),
              // Live GPS Broadcasting Control Card
              _buildGpsBroadcastCard(),
              const SizedBox(height: 24),
              // Driver Action Grid
              const Text(
                'Transit Operation Modules',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 14),
              _buildDriverActionGrid(context),
              const SizedBox(height: 24),
              // Active Trip Passenger Live Summary
              _buildTripSummaryCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverHeroCard() {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFF39C12).withValues(alpha: 0.2),
            child: const Icon(Icons.airline_seat_recline_normal, color: Color(0xFFF39C12), size: 34),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mr. Rameshwar Singh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF1E293B))),
                const SizedBox(height: 2),
                Text('Vehicle: UP-16-BT-4092 • 32 Seater Bus', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                Text('Assigned Route: Route 14 (North City Line)', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF86EFAC)),
            ),
            child: const Text('ON DUTY', style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildGpsBroadcastCard() {
    return AnimatedCard(
      padding: const EdgeInsets.all(18),
      color: _isGpsActive ? const Color(0xFF1E293B) : Colors.white,
      border: Border.all(color: _isGpsActive ? Colors.transparent : const Color(0xFFE2E8F0)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (_isGpsActive ? const Color(0xFF10B981) : const Color(0xFFF39C12)).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isGpsActive ? Icons.satellite_alt_rounded : Icons.location_off_rounded,
              color: _isGpsActive ? const Color(0xFF10B981) : const Color(0xFFF39C12),
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isGpsActive ? 'Live GPS Telematics Active' : 'GPS Broadcasting Offline',
                  style: TextStyle(
                    color: _isGpsActive ? Colors.white : const Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isGpsActive ? 'Streaming coordinates to Parent Radar & Admin Fleet Command' : 'Turn on to begin sharing live telemetry.',
                  style: TextStyle(color: _isGpsActive ? const Color(0xFF94A3B8) : Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _isGpsActive,
            activeColor: const Color(0xFF10B981),
            onChanged: (val) {
              setState(() => _isGpsActive = val);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(val ? 'Live GPS broadcast started!' : 'GPS broadcast paused.'),
                  backgroundColor: val ? const Color(0xFF10B981) : const Color(0xFFF39C12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDriverActionGrid(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Shift & Route Control',
        'subtitle': 'Start Trip • 6 Designated Stops',
        'icon': Icons.alt_route_rounded,
        'color': const Color(0xFFF39C12),
        'route': '/shift-route',
      },
      {
        'title': 'Student QR Scanner',
        'subtitle': 'Scan ID Card • 24/28 Boarded',
        'icon': Icons.qr_code_scanner,
        'color': const Color(0xFF10B981),
        'route': '/scanner',
      },
      {
        'title': 'Turn-by-Turn HUD',
        'subtitle': 'Live Navigation & Speedometer',
        'icon': Icons.navigation_outlined,
        'color': const Color(0xFF3B82F6),
        'route': '/navigation',
      },
      {
        'title': 'Vehicle & Fuel Log',
        'subtitle': 'Odometer, Petrol Bill & Safety',
        'icon': Icons.local_gas_station_outlined,
        'color': const Color(0xFF8B5CF6),
        'route': '/vehicle-log',
      },
      {
        'title': 'Emergency SOS Alarm',
        'subtitle': 'Panic Button • Direct Dispatch',
        'icon': Icons.sos_rounded,
        'color': const Color(0xFFEF4444),
        'route': '/sos',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsiveGridCount(mobile: 2, tablet: 3, desktop: 5),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.3,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final a = actions[index];
        final col = a['color'] as Color;

        return AnimatedCard(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: InkWell(
            onTap: () => context.push(a['route'] as String),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: col.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(a['icon'] as IconData, color: col, size: 22),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      a['subtitle'] as String,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTripSummaryCard(BuildContext context) {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Active Morning Trip Manifest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              ElevatedButton.icon(
                onPressed: () => context.push('/scanner'),
                icon: const Icon(Icons.qr_code, size: 16),
                label: const Text('Scan Next Student'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF39C12), foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatTile('Total Assigned', '28 Students', const Color(0xFF3B82F6)),
              Container(width: 1, height: 30, color: const Color(0xFFE2E8F0)),
              _buildStatTile('Boarded (Scanned)', '24 Students', const Color(0xFF10B981)),
              Container(width: 1, height: 30, color: const Color(0xFFE2E8F0)),
              _buildStatTile('Remaining Stops', '2 Stops', const Color(0xFFF59E0B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
      ],
    );
  }
}
