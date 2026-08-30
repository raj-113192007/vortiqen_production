import 'package:flutter/material.dart';
import '../../domain/transport_models.dart';
import '../dialogs/add_fuel_entry_modal.dart';

class FuelLedgerTab extends StatefulWidget {
  final List<VehicleFleetInfo> fleet;

  const FuelLedgerTab({
    super.key,
    required this.fleet,
  });

  @override
  State<FuelLedgerTab> createState() => _FuelLedgerTabState();
}

class _FuelLedgerTabState extends State<FuelLedgerTab> {
  late List<FuelLogEntry> _allLogs;

  @override
  void initState() {
    super.initState();
    _allLogs = widget.fleet.expand((v) => v.fuelLogs).toList();
  }

  void _addLog(Map<String, String> log) {
    setState(() {
      _allLogs.insert(
        0,
        FuelLogEntry(
          id: 'fl_${DateTime.now().millisecondsSinceEpoch}',
          date: 'Today, 30 Aug 2026',
          busNumber: log['busNumber'] ?? 'DL 01 PB 4488',
          litres: log['litres'] ?? '50 L',
          cost: log['cost'] ?? '₹ 4,500',
          odometer: log['odometer'] ?? '48,600 KM',
          fuelPump: log['fuelPump'] ?? 'IOCL Station',
          referenceNumber: 'IOCL_${DateTime.now().millisecond}',
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New Fuel slip successfully logged into ledger.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Analytics Summary Cards
        Row(
          children: [
            Expanded(child: _buildKpiCard('Total MTD Fuel Spend', '₹ 1,48,250', Icons.currency_rupee_rounded, const Color(0xFF0984E3))),
            const SizedBox(width: 12),
            Expanded(child: _buildKpiCard('Fleet Avg Mileage', '5.3 KM / L', Icons.speed_rounded, const Color(0xFF00B894))),
            const SizedBox(width: 12),
            Expanded(child: _buildKpiCard('Refuels Logged MTD', '${_allLogs.length} Entries', Icons.receipt_long_rounded, const Color(0xFF6C5CE7))),
          ],
        ),
        const SizedBox(height: 20),

        // Action & Filter Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.local_gas_station_rounded, size: 18, color: Color(0xFF0984E3)),
                  SizedBox(width: 8),
                  Text(
                    'Diesel & CNG Expense Ledger',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AddFuelEntryModal(onSave: _addLog),
                  );
                },
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Log New Fuel Slip'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0984E3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Fuel Entries List
        if (_allLogs.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No fuel entries recorded yet.'),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allLogs.length,
            itemBuilder: (context, index) {
              final f = _allLogs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.01),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0984E3).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.local_gas_station_rounded, color: Color(0xFF0984E3), size: 22),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${f.date} • ${f.busNumber}',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Filled ${f.litres} @ ${f.fuelPump} • Odometer: ${f.odometer}',
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          f.cost,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF00B894)),
                        ),
                        Text('Ref: ${f.referenceNumber}', style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
