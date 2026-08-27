import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isGpsActive = false;

  @override
  Widget build(BuildContext context) {
    final driverVehicleAsync = ref.watch(driverTransportProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFBF7),
      appBar: AppBar(
        title: const Text('VortiQen Driver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vibrant Header
            const VibrantHeader(
              role: AppRole.driver,
              title: 'Transport Cockpit',
              subtitle: 'Morning Pickup Route 04 - Sector 14 to Campus',
            ),

            const SizedBox(height: 20),

            // Live GPS Broadcasting Control Card
            AnimatedCard(
              borderColor: const Color(0xFFF39C12).withOpacity(0.4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: (_isGpsActive ? const Color(0xFF00B894) : const Color(0xFFF39C12)).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isGpsActive ? Icons.satellite_alt_rounded : Icons.location_off_rounded,
                      color: _isGpsActive ? const Color(0xFF00B894) : const Color(0xFFF39C12),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isGpsActive ? 'Live GPS Broadcasting ON' : 'GPS Offline',
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF1E293B)),
                        ),
                        Text(
                          _isGpsActive ? 'Parents can track your bus on live map.' : 'Tap switch to start sharing live location.',
                          style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _isGpsActive,
                    activeColor: const Color(0xFF00B894),
                    onChanged: (val) {
                      setState(() => _isGpsActive = val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: val ? const Color(0xFF00B894) : const Color(0xFFF39C12),
                          content: Text(val ? 'Live GPS route broadcast started!' : 'GPS broadcast paused.'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Vehicle & Assigned Students Data
            driverVehicleAsync.when(
              data: (vehicle) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vehicle Info Card
                    AnimatedCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Vehicle Plate', vehicle.plateNumber, Icons.directions_bus_rounded),
                          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                          _buildStatItem('Capacity', '${vehicle.capacity} Seats', Icons.airline_seat_recline_normal_rounded),
                          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                          _buildStatItem('Route', vehicle.route?.name ?? 'Route 04', Icons.alt_route_rounded),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Students Checklist
                    Text(
                      'Assigned Students (${vehicle.students.length})',
                      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 12),

                    if (vehicle.students.isEmpty)
                      const Center(child: Text('No students assigned to this route.'))
                    else
                      ...vehicle.students.map((student) {
                        return AnimatedCard(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFF39C12).withOpacity(0.15),
                                child: Text(
                                  student.firstName[0].toUpperCase(),
                                  style: const TextStyle(color: Color(0xFFF39C12), fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${student.firstName} ${student.lastName ?? ""}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Text('Roll No: ${student.rollNo ?? "N/A"}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Boarding checked for ${student.firstName}')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF39C12),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  minimumSize: Size.zero,
                                ),
                                child: const Text('Boarded', style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => const AnimatedCard(child: Text('No vehicle currently assigned to this driver.')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFF39C12), size: 22),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B))),
        Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
      ],
    );
  }
}
