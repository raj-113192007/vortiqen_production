import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DriverSosScreen extends StatefulWidget {
  const DriverSosScreen({super.key});

  @override
  State<DriverSosScreen> createState() => _DriverSosScreenState();
}

class _DriverSosScreenState extends State<DriverSosScreen> {
  bool _isSosTriggered = false;
  String _selectedReason = 'MECHANICAL_BREAKDOWN';

  final List<Map<String, dynamic>> _sosTypes = [
    {
      'key': 'MECHANICAL_BREAKDOWN',
      'title': 'Mechanical Breakdown / Engine Failure',
      'subtitle': 'Bus halted safely; replacement vehicle required',
      'icon': Icons.car_repair,
      'color': const Color(0xFFF59E0B),
    },
    {
      'key': 'MEDICAL_EMERGENCY',
      'title': 'Medical Emergency / Student Sickness',
      'subtitle': 'First aid required / Request nearest ambulance',
      'icon': Icons.medical_services_outlined,
      'color': const Color(0xFFEF4444),
    },
    {
      'key': 'ACCIDENT',
      'title': 'Road Traffic Accident / Collision',
      'subtitle': 'Urgent police, admin, and parent emergency dispatch',
      'icon': Icons.warning_amber_rounded,
      'color': const Color(0xFFDC2626),
    },
    {
      'key': 'WEATHER_BLOCK',
      'title': 'Route Waterlogged / Fallen Tree',
      'subtitle': 'Road impassable; requesting alternate route clearance',
      'icon': Icons.thunderstorm_outlined,
      'color': const Color(0xFF3B82F6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1B18),
      appBar: AppBar(
        title: const Text('Emergency SOS Distress Center', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: const Color(0xFF2C1810),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // High-Priority Alert Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFDC2626), Color(0xFF991B1B)]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFDC2626).withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.sos_rounded, color: Color(0xFFDC2626), size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isSosTriggered ? '🚨 DISTRESS SIGNAL ACTIVE' : 'PANIC DISTRESS DISPATCH',
                            style: const TextStyle(color: Color(0xFFFECACA), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isSosTriggered
                                ? 'GPS coordinates continuously transmitting to Central Police & Fleet Command'
                                : 'Broadcasts instant GPS & sirens to Admin, Police & Parents',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Select Emergency Distress Category', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 14),
              // Category options
              ..._sosTypes.map((t) {
                final isSelected = _selectedReason == t['key'];
                final color = t['color'] as Color;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => setState(() => _selectedReason = t['key'] as String),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withValues(alpha: 0.15) : const Color(0xFF292524),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? color : const Color(0xFF44403C),
                          width: isSelected ? 2.0 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
                            child: Icon(t['icon'] as IconData, color: color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text(t['subtitle'] as String, style: const TextStyle(color: Color(0xFFA8A29E), fontSize: 12)),
                              ],
                            ),
                          ),
                          Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? color : Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // Big Red SOS Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isSosTriggered = !_isSosTriggered);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isSosTriggered
                            ? '🚨 SOS EMERGENCY BROADCAST SENT! Fleet command & emergency responders alerted.'
                            : 'SOS Alert cleared.'),
                        backgroundColor: const Color(0xFFDC2626),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  },
                  icon: const Icon(Icons.warning_rounded, size: 24),
                  label: Text(
                    _isSosTriggered ? 'CANCEL / CLEAR ACTIVE SOS ALERT' : 'TRIGGER EMERGENCY SOS BROADCAST',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSosTriggered ? const Color(0xFF475569) : const Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Direct Emergency Numbers
              const Text('Government & Institutional Hotlines', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildEmergencyDialButton('112 (National Police / ER)', Icons.local_police_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildEmergencyDialButton('108 (Ambulance Service)', Icons.local_hospital_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyDialButton(String text, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dialing $text...')),
        );
      },
      icon: Icon(icon, size: 16),
      label: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF292524),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
