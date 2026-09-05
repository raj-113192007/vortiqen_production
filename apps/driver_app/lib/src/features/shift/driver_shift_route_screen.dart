import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DriverShiftRouteScreen extends StatefulWidget {
  const DriverShiftRouteScreen({super.key});

  @override
  State<DriverShiftRouteScreen> createState() => _DriverShiftRouteScreenState();
}

class _DriverShiftRouteScreenState extends State<DriverShiftRouteScreen> {
  bool _isTripActive = false;
  String _selectedShift = 'MORNING'; // MORNING or EVENING
  final TextEditingController _startOdoController = TextEditingController(text: '48210');
  final TextEditingController _endOdoController = TextEditingController();

  final List<Map<String, dynamic>> _stops = [
    {
      'stopName': 'School Campus Main Gate',
      'scheduledTime': '06:45 AM',
      'studentCount': 0,
      'status': 'PASSED',
      'isCompleted': true,
    },
    {
      'stopName': 'Sector 50 Central Park',
      'scheduledTime': '07:05 AM',
      'studentCount': 6,
      'status': 'PASSED',
      'isCompleted': true,
    },
    {
      'stopName': 'Sector 62 Metro Junction',
      'scheduledTime': '07:20 AM',
      'studentCount': 8,
      'status': 'CURRENT STOP',
      'isCompleted': false,
    },
    {
      'stopName': 'Palm Greens Apartments Gate 2',
      'scheduledTime': '07:35 AM',
      'studentCount': 7,
      'status': 'UPCOMING',
      'isCompleted': false,
    },
    {
      'stopName': 'Green Valley Sector 78 Terminal',
      'scheduledTime': '07:50 AM',
      'studentCount': 7,
      'status': 'UPCOMING',
      'isCompleted': false,
    },
    {
      'stopName': 'School Campus Return',
      'scheduledTime': '08:15 AM',
      'studentCount': 0,
      'status': 'FINAL DESTINATION',
      'isCompleted': false,
    },
  ];

  @override
  void dispose() {
    _startOdoController.dispose();
    _endOdoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBF7),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Route & Shift Command', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Route 14 • Bus UP-16-BT-4092', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: ResponsiveTwoPane(
            breakpoint: 860,
            leftFlex: 5,
            rightFlex: 6,
            leftPane: _buildShiftControlPane(),
            rightPane: _buildStopsManifestPane(),
          ),
        ),
      ),
    );
  }

  Widget _buildShiftControlPane() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shift Toggle Card
        AnimatedCard(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Active Shift Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Morning Pickup (06:30 AM)')),
                      selected: _selectedShift == 'MORNING',
                      selectedColor: const Color(0xFFF39C12),
                      labelStyle: TextStyle(
                        color: _selectedShift == 'MORNING' ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _selectedShift = 'MORNING');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Afternoon Drop (02:00 PM)')),
                      selected: _selectedShift == 'EVENING',
                      selectedColor: const Color(0xFFE67E22),
                      labelStyle: TextStyle(
                        color: _selectedShift == 'EVENING' ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _selectedShift = 'EVENING');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Live Trip Status & Odometer Card
        AnimatedCard(
          padding: const EdgeInsets.all(20),
          color: _isTripActive ? const Color(0xFF1E293B) : Colors.white,
          border: Border.all(color: _isTripActive ? Colors.transparent : const Color(0xFFE2E8F0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isTripActive ? 'TRIP IN PROGRESS' : 'TRIP NOT STARTED',
                    style: TextStyle(
                      color: _isTripActive ? const Color(0xFF10B981) : const Color(0xFF64748B),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 0.8,
                    ),
                  ),
                  if (_isTripActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(20)),
                      child: const Text('GPS BROADCASTING', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                _isTripActive ? 'Broadcasting live location to 28 parents & fleet portal' : 'Enter start odometer reading and press Start Trip.',
                style: TextStyle(
                  color: _isTripActive ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _startOdoController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: _isTripActive ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Start Odometer (KM)',
                  labelStyle: TextStyle(color: _isTripActive ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isTripActive ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isTripActive = !_isTripActive);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isTripActive ? 'Trip Started! GPS stream is now live.' : 'Trip Finished! Manifest saved.'),
                        backgroundColor: _isTripActive ? const Color(0xFF10B981) : const Color(0xFFF39C12),
                      ),
                    );
                  },
                  icon: Icon(_isTripActive ? Icons.stop_circle_outlined : Icons.play_circle_fill, size: 20),
                  label: Text(_isTripActive ? 'End Trip & Save Route Logs' : 'Start Route Trip Now', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTripActive ? const Color(0xFFEF4444) : const Color(0xFFF39C12),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStopsManifestPane() {
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
              const Text('Designated Stop Manifest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(4)),
                child: const Text('28 Students En Route', style: TextStyle(color: Color(0xFFD97706), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stops.length,
            separatorBuilder: (_, __) => const Divider(height: 20),
            itemBuilder: (context, index) {
              final stop = _stops[index];
              final isPassed = stop['isPassed'] == true;
              final isCurrent = stop['status'] == 'CURRENT STOP';

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isPassed
                          ? const Color(0xFF10B981)
                          : isCurrent
                              ? const Color(0xFFF39C12)
                              : const Color(0xFFE2E8F0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isPassed ? Icons.check : (isCurrent ? Icons.directions_bus : Icons.location_on_outlined),
                        color: (isPassed || isCurrent) ? Colors.white : const Color(0xFF64748B),
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stop['stopName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isCurrent ? const Color(0xFFF39C12) : const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Scheduled: ${stop['scheduledTime']} • Pickups: ${stop['studentCount']} Students',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isPassed
                          ? const Color(0xFFDCFCE7)
                          : isCurrent
                              ? const Color(0xFFFEF3C7)
                              : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      stop['status'],
                      style: TextStyle(
                        color: isPassed
                            ? const Color(0xFF16A34A)
                            : isCurrent
                                ? const Color(0xFFD97706)
                                : const Color(0xFF64748B),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
