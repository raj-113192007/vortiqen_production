import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DriverVehicleLogScreen extends StatefulWidget {
  const DriverVehicleLogScreen({super.key});

  @override
  State<DriverVehicleLogScreen> createState() => _DriverVehicleLogScreenState();
}

class _DriverVehicleLogScreenState extends State<DriverVehicleLogScreen> {
  final TextEditingController _odometerController = TextEditingController(text: '48240');
  final TextEditingController _fuelLitersController = TextEditingController(text: '45.0');
  final TextEditingController _fuelCostController = TextEditingController(text: '4050');
  bool _isReceiptUploaded = false;

  final Map<String, bool> _inspectionChecklist = {
    'Tyre Pressure & Wheel Nut Torque': true,
    'Foot Brakes, Air Pressure & Handbrake': true,
    'Headlights, Tail Lamps & Hazard Blinkers': true,
    'First Aid Emergency Medical Box Stocked': true,
    'Fire Extinguisher Gauge in Green Zone': true,
    'GPS Telemetry & Speed Limiter (50 km/h) Functioning': true,
  };

  final List<Map<String, dynamic>> _recentLogs = [
    {
      'date': '04 Sep 2026',
      'odometer': '48,120 KM',
      'fuel': '42.5 L',
      'cost': '₹3,825',
      'status': 'VERIFIED',
    },
    {
      'date': '01 Sep 2026',
      'odometer': '47,940 KM',
      'fuel': '50.0 L',
      'cost': '₹4,500',
      'status': 'VERIFIED',
    },
  ];

  @override
  void dispose() {
    _odometerController.dispose();
    _fuelLitersController.dispose();
    _fuelCostController.dispose();
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
            Text('Vehicle & Fuel Logbook', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Bus UP-16-BT-4092 • 32-Seater Eicher Starline', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
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
            leftFlex: 6,
            rightFlex: 5,
            leftPane: _buildFuelEntryAndSafetyPane(),
            rightPane: _buildLogHistoryPane(),
          ),
        ),
      ),
    );
  }

  Widget _buildFuelEntryAndSafetyPane() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Daily Fuel Entry Card
        AnimatedCard(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Log Daily Fuel & Odometer Refill', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _odometerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Current Odometer (KM)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _fuelLitersController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Fuel Added (Liters)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _fuelCostController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Fuel Amount Paid (₹)',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 14),
              // Receipt photo upload
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isReceiptUploaded ? Icons.check_circle : Icons.camera_alt_outlined,
                      color: _isReceiptUploaded ? const Color(0xFF10B981) : const Color(0xFFF39C12),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _isReceiptUploaded ? 'Fuel_Slip_05Sep.jpg (Attached)' : 'Attach Petrol Pump Bill Receipt Photo',
                        style: TextStyle(fontSize: 12, fontWeight: _isReceiptUploaded ? FontWeight.bold : FontWeight.normal),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isReceiptUploaded = !_isReceiptUploaded),
                      child: Text(_isReceiptUploaded ? 'Remove' : 'Capture'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Pre-trip Inspection checklist
        AnimatedCard(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Daily Pre-Trip Safety Checklist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              const SizedBox(height: 12),
              ..._inspectionChecklist.keys.map((item) {
                final isChecked = _inspectionChecklist[item] ?? false;

                return CheckboxListTile(
                  title: Text(item, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  value: isChecked,
                  activeColor: const Color(0xFF10B981),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  onChanged: (val) {
                    if (val != null) setState(() => _inspectionChecklist[item] = val);
                  },
                );
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vehicle Log & Safety Inspection submitted to Fleet Manager!'),
                        backgroundColor: Color(0xFF10B981),
                      ),
                    );
                  },
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Submit Daily Vehicle Audit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF39C12),
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

  Widget _buildLogHistoryPane() {
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
              const Text('Past Refill & Odometer Logs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              Icon(Icons.history, color: Colors.grey[600], size: 20),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentLogs.length,
            separatorBuilder: (_, __) => const Divider(height: 20),
            itemBuilder: (context, index) {
              final log = _recentLogs[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(log['date'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                        child: Text(log['status'], style: const TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Odometer: ${log['odometer']} • Added: ${log['fuel']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 2),
                  Text('Expense: ${log['cost']} (Diesel)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
