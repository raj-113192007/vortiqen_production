import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleFleetInfo {
  final String id;
  final String busNumber;
  final String model;
  final int capacity;
  final String routeName;
  final int totalStops;
  final int totalScholars;
  final int onboardToday;
  final int absentToday;
  final String driverName;
  final String driverPhone;
  final String driverLicense;
  final String attendantName;
  final String attendantPhone;
  final String liveStatus;
  final String currentSpeed;
  final String currentLocation;
  final String etaToSchool;
  // Fuel & Servicing
  final String lastFuelDate;
  final String lastFuelQuantity;
  final String lastFuelCost;
  final String fuelMileage;
  final String lastServiceDate;
  final String nextServiceDate;
  final String fitnessExpiry;
  final String insuranceExpiry;
  final String pucExpiry;
  final List<Map<String, dynamic>> studentsOnboard;
  final List<Map<String, String>> fuelLogs;

  const VehicleFleetInfo({
    required this.id,
    required this.busNumber,
    required this.model,
    required this.capacity,
    required this.routeName,
    required this.totalStops,
    required this.totalScholars,
    required this.onboardToday,
    required this.absentToday,
    required this.driverName,
    required this.driverPhone,
    required this.driverLicense,
    required this.attendantName,
    required this.attendantPhone,
    required this.liveStatus,
    required this.currentSpeed,
    required this.currentLocation,
    required this.etaToSchool,
    required this.lastFuelDate,
    required this.lastFuelQuantity,
    required this.lastFuelCost,
    required this.fuelMileage,
    required this.lastServiceDate,
    required this.nextServiceDate,
    required this.fitnessExpiry,
    required this.insuranceExpiry,
    required this.pucExpiry,
    required this.studentsOnboard,
    required this.fuelLogs,
  });
}

class TransportScreen extends ConsumerStatefulWidget {
  const TransportScreen({super.key});

  @override
  ConsumerState<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends ConsumerState<TransportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  static const List<VehicleFleetInfo> _fleetVehicles = [
    VehicleFleetInfo(
      id: 'vh_01',
      busNumber: 'DL 01 PB 4488 (Bus #04)',
      model: 'Tata Starbus Ultra (42-Seater AC)',
      capacity: 42,
      routeName: 'Route 04: Dwarka Sec 12 ➔ School Campus (via Palam & Janakpuri)',
      totalStops: 14,
      totalScholars: 38,
      onboardToday: 36,
      absentToday: 2,
      driverName: 'Mr. Surendra Pal',
      driverPhone: '+91 98111 55667',
      driverLicense: 'DL-0420188992 (Commercial HMV • Verified 🟢)',
      attendantName: 'Mr. Ramesh Yadav',
      attendantPhone: '+91 98222 66778',
      liveStatus: 'MOVING (Live GPS Active 🟢)',
      currentSpeed: '34 km/h (Speed Governor <40 km/h)',
      currentLocation: 'Near Stop 9 (Janakpuri B-Block Flyover)',
      etaToSchool: '7 Minutes',
      lastFuelDate: '26 Aug 2026',
      lastFuelQuantity: '65 Litres Diesel',
      lastFuelCost: '₹ 5,825.30',
      fuelMileage: '4.8 KM / Litre',
      lastServiceDate: '12 July 2026 (Major 45K Overhaul)',
      nextServiceDate: '12 October 2026 (in 45 days)',
      fitnessExpiry: '15 March 2027 (RTO Valid)',
      insuranceExpiry: '30 Nov 2026 (ICICI Lombard Comprehensive)',
      pucExpiry: '28 Feb 2027 (Valid)',
      studentsOnboard: [
        {'name': 'Aarav Sharma', 'class': 'Class 10-A', 'stop': 'Stop 3: Dwarka Sec 6', 'boardedTime': '07:18 AM', 'status': 'BOARDED 🟢', 'parent': 'Rajesh Sharma', 'phone': '+91 98111 22334'},
        {'name': 'Ananya Iyer', 'class': 'Class 10-A', 'stop': 'Stop 5: Palam Colony', 'boardedTime': '07:28 AM', 'status': 'BOARDED 🟢', 'parent': 'Venkatesh Iyer', 'phone': '+91 98222 33445'},
        {'name': 'Rohan Mehta', 'class': 'Class 10-A', 'stop': 'Stop 7: Janakpuri C-1', 'boardedTime': '--', 'status': 'NOT BOARDED (ABSENT 🔴)', 'parent': 'Sanjay Mehta', 'phone': '+91 98333 44556'},
        {'name': 'Kabir Kapoor', 'class': 'Class 11-Science', 'stop': 'Stop 9: Janakpuri B-Block', 'boardedTime': '--', 'status': 'NOT BOARDED (ABSENT 🔴)', 'parent': 'Anil Kapoor', 'phone': '+91 98555 66778'},
        {'name': 'Diya Patel', 'class': 'Class 9-A', 'stop': 'Stop 11: Vikaspuri More', 'boardedTime': '07:44 AM', 'status': 'BOARDED 🟢', 'parent': 'Kirit Patel', 'phone': '+91 98444 55667'},
      ],
      fuelLogs: [
        {'date': '26 Aug 2026', 'litres': '65 L Diesel', 'cost': '₹ 5,825', 'odo': '48,250 KM', 'pump': 'Indian Oil Corp Sec 10', 'ref': 'IOCL_8841'},
        {'date': '19 Aug 2026', 'litres': '70 L Diesel', 'cost': '₹ 6,270', 'odo': '47,910 KM', 'pump': 'Indian Oil Corp Sec 10', 'ref': 'IOCL_8790'},
        {'date': '12 Aug 2026', 'litres': '68 L Diesel', 'cost': '₹ 6,090', 'odo': '47,580 KM', 'pump': 'Indian Oil Corp Sec 10', 'ref': 'IOCL_8712'},
      ],
    ),
    VehicleFleetInfo(
      id: 'vh_02',
      busNumber: 'DL 01 PB 9921 (Bus #07)',
      model: 'Ashok Leyland Sunshine (36-Seater)',
      capacity: 36,
      routeName: 'Route 07: Rohini Sector 15 ➔ School Campus (via Pitampura & Punjabi Bagh)',
      totalStops: 12,
      totalScholars: 34,
      onboardToday: 33,
      absentToday: 1,
      driverName: 'Mr. Baljit Singh',
      driverPhone: '+91 98333 77889',
      driverLicense: 'DL-0320147712 (Commercial HMV • Verified 🟢)',
      attendantName: 'Mr. Satish Kumar',
      attendantPhone: '+91 98444 88990',
      liveStatus: 'ARRIVED AT SCHOOL CAMPUS 🏁',
      currentSpeed: '0 km/h (Parked in Bay 3)',
      currentLocation: 'Campus Gate 2 Parking Bay 3',
      etaToSchool: '0 Min (Completed)',
      lastFuelDate: '25 Aug 2026',
      lastFuelQuantity: '60 Litres Diesel',
      lastFuelCost: '₹ 5,377.20',
      fuelMileage: '5.1 KM / Litre',
      lastServiceDate: '05 August 2026 (Regular 40K Service)',
      nextServiceDate: '05 November 2026',
      fitnessExpiry: '20 April 2027',
      insuranceExpiry: '15 Dec 2026 (HDFC ERGO)',
      pucExpiry: '10 Jan 2027',
      studentsOnboard: [
        {'name': 'Sneha Kulkarni', 'class': 'Class 10-A', 'stop': 'Stop 4: Pitampura Metro', 'boardedTime': '07:22 AM', 'status': 'BOARDED 🟢', 'parent': 'Madhav Kulkarni', 'phone': '+91 98666 77889'},
      ],
      fuelLogs: [
        {'date': '25 Aug 2026', 'litres': '60 L Diesel', 'cost': '₹ 5,377', 'odo': '39,400 KM', 'pump': 'HPCL Petrol Pump Rohini', 'ref': 'HPCL_4412'},
      ],
    ),
    VehicleFleetInfo(
      id: 'vh_03',
      busNumber: 'DL 01 PB 1102 (Bus #02)',
      model: 'Force Traveller Mini Bus (26-Seater)',
      capacity: 26,
      routeName: 'Route 02: Vasant Kunj ➔ School Campus (via Mahipalpur & Munirka)',
      totalStops: 10,
      totalScholars: 24,
      onboardToday: 24,
      absentToday: 0,
      driverName: 'Mr. Devendra Sharma',
      driverPhone: '+91 98555 99001',
      driverLicense: 'DL-0920193341 (Commercial HMV • Verified 🟢)',
      attendantName: 'Mr. Jagdish Prasad',
      attendantPhone: '+91 98666 00112',
      liveStatus: 'MOVING (Live GPS Active 🟢)',
      currentSpeed: '28 km/h',
      currentLocation: 'Near Munirka D-Block Red Light',
      etaToSchool: '11 Minutes',
      lastFuelDate: '27 Aug 2026',
      lastFuelQuantity: '45 Litres CNG / Diesel',
      lastFuelCost: '₹ 3,960.00',
      fuelMileage: '6.2 KM / Litre',
      lastServiceDate: '20 June 2026',
      nextServiceDate: '20 September 2026 (in 23 days ⚠️)',
      fitnessExpiry: '10 June 2027',
      insuranceExpiry: '10 Oct 2026',
      pucExpiry: '15 Dec 2026',
      studentsOnboard: [],
      fuelLogs: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filtered = _fleetVehicles.where((v) {
      return v.busNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          v.routeName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          v.driverName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Bar & Live Pulse Metrics
          _buildTransportHeader(context),
          const SizedBox(height: 20),

          // Search Bar
          _buildSearchBar(context),
          const SizedBox(height: 20),

          // Master Tabs: Fleet Cards, Fuel Ledger, Maintenance & Servicing, Student Boarding Roll
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: const Color(0xFF6C5CE7),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFF6C5CE7),
                  unselectedLabelColor: const Color(0xFF64748B),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  tabs: const [
                    Tab(icon: Icon(Icons.directions_bus_rounded, size: 18), text: '1. Fleet Vehicles & Live GPS (12 Buses)'),
                    Tab(icon: Icon(Icons.local_gas_station_rounded, size: 18), text: '2. Fuel & Diesel Ledger'),
                    Tab(icon: Icon(Icons.car_repair_rounded, size: 18), text: '3. Servicing, Maintenance & RTO Fitness'),
                    Tab(icon: Icon(Icons.how_to_reg_rounded, size: 18), text: '4. Student Boarding Roll & WhatsApp Alert'),
                  ],
                ),
                SizedBox(
                  height: 640,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFleetVehiclesTab(context, filtered),
                      _buildFuelLedgerTab(context),
                      _buildMaintenanceTab(context),
                      _buildBoardingRollTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Bottom Operations Bar
          _buildBottomOperationsBar(context),
        ],
      ),
    );
  }

  Widget _buildTransportHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fleet & Transport Operations Control Hub',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: -0.5),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Live Fleet GPS Tracking • Fuel & Diesel Ledger • RTO Fitness Vault • Daily Student Boarding Roll',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddVehicleModal(context);
                    },
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Fleet Bus / Route'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4 Pulse Metrics
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 700;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isNarrow ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isNarrow ? 2.3 : 2.6,
                children: [
                  _buildMetricTile('12 / 12 GPS Active', 'All Buses Live Tracked 🟢', Icons.gps_fixed_rounded, const Color(0xFF00B894)),
                  _buildMetricTile('418 Onboard Today', '95.0% Boarding Rate', Icons.people_alt_rounded, const Color(0xFF6C5CE7)),
                  _buildMetricTile('₹ 1,48,250 MTD Fuel', 'Diesel & CNG Total', Icons.local_gas_station_rounded, const Color(0xFF0984E3)),
                  _buildMetricTile('100% RTO Fitness', 'Insurance & PUC Valid', Icons.verified_user_rounded, const Color(0xFFE84393)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String title, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: color), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: const InputDecoration(
          icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
          hintText: 'Search by Bus Number (DL 01 PB 4488), Route Name, or Driver Name (Surendra Pal)...',
          hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // --- TAB 1: FLEET VEHICLES & LIVE GPS TRACKING ---
  Widget _buildFleetVehiclesTab(BuildContext context, List<VehicleFleetInfo> fleet) {
    if (fleet.isEmpty) {
      return const Center(child: Text('No vehicles found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: fleet.length,
      itemBuilder: (context, index) {
        final v = fleet[index];
        final isMoving = v.liveStatus.contains('MOVING');

        return InkWell(
          onTap: () => _openBus360Dossier(context, v),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Bus No + Status + Live Speed
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            v.busNumber,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          v.model,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isMoving ? const Color(0xFF00B894).withOpacity(0.12) : const Color(0xFF0984E3).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        v.liveStatus,
                        style: TextStyle(
                          color: isMoving ? const Color(0xFF00B894) : const Color(0xFF0984E3),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Row 2: Route Name & Current Location
                Text('📍 ${v.routeName}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Current Location: ${v.currentLocation}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    const SizedBox(width: 12),
                    Text('•  ETA: ${v.etaToSchool}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
                  ],
                ),
                const SizedBox(height: 12),

                // Row 3: Driver Details & Onboard Counter
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_pin_circle_rounded, color: Color(0xFF6C5CE7), size: 18),
                          const SizedBox(width: 8),
                          Text('Driver: ${v.driverName} (${v.driverPhone})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                          const SizedBox(width: 16),
                          Text('Attendant: ${v.attendantName}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                            child: Text('${v.onboardToday} / ${v.totalScholars} Boarded', style: const TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(width: 8),
                          const Text('View 360° ➔', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- TAB 2: FUEL & DIESEL LEDGER ---
  Widget _buildFuelLedgerTab(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _fleetVehicles.first.fuelLogs.length,
      itemBuilder: (context, index) {
        final f = _fleetVehicles.first.fuelLogs[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFF0984E3).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.local_gas_station_rounded, color: Color(0xFF0984E3), size: 22),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${f['date']!} • DL 01 PB 4488 (Bus #04)', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text('Filled ${f['litres']!} @ ${f['pump']!} • Odometer: ${f['odo']!}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(f['cost']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF00B894))),
                  Text('Ref: ${f['ref']!}', style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 3: SERVICING & MAINTENANCE ---
  Widget _buildMaintenanceTab(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _fleetVehicles.length,
      itemBuilder: (context, index) {
        final v = _fleetVehicles[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(v.busNumber, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                    child: Text('Fitness: ${v.fitnessExpiry}', style: const TextStyle(color: Color(0xFF00B894), fontSize: 10, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildDetailPill('Last Servicing', v.lastServiceDate, Icons.build_rounded)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDetailPill('Next Due Date', v.nextServiceDate, Icons.event_rounded)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildDetailPill('Insurance (ICICI Lombard)', v.insuranceExpiry, Icons.security_rounded)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDetailPill('Pollution (PUC)', v.pucExpiry, Icons.energy_savings_leaf_rounded)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailPill(String title, String val, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6C5CE7)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
                Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF334155)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 4: STUDENT BOARDING ROLL & WHATSAPP ---
  Widget _buildBoardingRollTab(BuildContext context) {
    final students = _fleetVehicles.first.studentsOnboard;

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final s = students[index];
        final isBoarded = s['status'].contains('BOARDED');

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                child: Text(s['name'][0], style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 13)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${s['name']} (${s['class']})', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                    Text('Pickup: ${s['stop']} • Boarded: ${s['boardedTime']} • Parent: ${s['parent']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isBoarded ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s['status'],
                  style: TextStyle(color: isBoarded ? const Color(0xFF2E7D32) : const Color(0xFFC62828), fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF00B894), size: 18),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Ping to ${s['name']}\'s Parent (${s['phone']})')));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomOperationsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('⛽ Logging new Fuel/Diesel slip entry...')));
                },
                icon: const Icon(Icons.local_gas_station_rounded, size: 18, color: Color(0xFF0984E3)),
                label: const Text('Log Fuel Entry', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('🔧 Logging vehicle servicing & maintenance record...')));
                },
                icon: const Icon(Icons.build_rounded, size: 18, color: Color(0xFF6C5CE7)),
                label: const Text('Log Servicing Record', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📢 Automated WhatsApp Route Delay/Safety Alert sent to parents!')));
            },
            icon: const Icon(Icons.campaign_rounded, size: 18),
            label: const Text('Broadcast Bus Route Alert (WhatsApp)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B894),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // --- BUS 360° DOSSIER MODAL ---
  void _openBus360Dossier(BuildContext context, VehicleFleetInfo v) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(28),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.busNumber, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Color(0xFF1E293B))),
                          Text(v.model, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Driver: ${v.driverName} • License: ${v.driverLicense}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                  const SizedBox(height: 4),
                  Text('Attendant: ${v.attendantName} (${v.attendantPhone})', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text('RTO Fitness & Compliance Status', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                  const SizedBox(height: 10),
                  Text('• RTO Fitness Valid Till: ${v.fitnessExpiry}', style: const TextStyle(fontSize: 12, color: Color(0xFF00B894), fontWeight: FontWeight.w700)),
                  Text('• Insurance Policy: ${v.insuranceExpiry}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                  Text('• Pollution Under Control (PUC): ${v.pucExpiry}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text('Fuel & Servicing History', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                  const SizedBox(height: 8),
                  Text('• Last Fuel Entry: ${v.lastFuelDate} (${v.lastFuelQuantity} @ ${v.lastFuelCost})', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                  Text('• Fuel Average Mileage: ${v.fuelMileage}', style: const TextStyle(fontSize: 12, color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700)),
                  Text('• Last Major Servicing: ${v.lastServiceDate}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                  Text('• Next Servicing Due: ${v.nextServiceDate}', style: const TextStyle(fontSize: 12, color: Color(0xFFD63031), fontWeight: FontWeight.w700)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7), foregroundColor: Colors.white),
                        child: const Text('Close Dossier'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAddVehicleModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Register New Fleet Bus / Route', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B))),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: 'Bus Plate Number (e.g. DL 01 PB 8812)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                const TextField(decoration: InputDecoration(labelText: 'Route Name (e.g. Route 09: Vasant Kunj)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                const TextField(decoration: InputDecoration(labelText: 'Driver Name & Phone', border: OutlineInputBorder())),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✨ Fleet Bus Registered!')));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7), foregroundColor: Colors.white),
                      child: const Text('Save Bus'),
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
}
