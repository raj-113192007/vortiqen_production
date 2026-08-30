import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/transport_models.dart';
import 'presentation/widgets/transport_header.dart';
import 'presentation/tabs/fleet_tracking_tab.dart';
import 'presentation/tabs/fuel_ledger_tab.dart';
import 'presentation/tabs/maintenance_tab.dart';
import 'presentation/tabs/student_boarding_tab.dart';
import 'presentation/dialogs/add_vehicle_modal.dart';

class TransportScreen extends ConsumerStatefulWidget {
  const TransportScreen({super.key});

  @override
  ConsumerState<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends ConsumerState<TransportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  late List<VehicleFleetInfo> _fleetVehicles;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    _fleetVehicles = TransportMockData.getFleet();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleAddNewVehicle(Map<String, dynamic> data) {
    setState(() {
      _fleetVehicles.add(
        VehicleFleetInfo(
          id: 'vh_${DateTime.now().millisecondsSinceEpoch}',
          busNumber: '${data['busNumber']} (New Bus)',
          model: data['model'] ?? 'Standard School Bus',
          capacity: data['capacity'] ?? 40,
          routeName: data['routeName'] ?? 'Newly Configured Route',
          totalStops: 8,
          totalScholars: 0,
          onboardToday: 0,
          absentToday: 0,
          driverName: data['driverName'] ?? 'Assigned Driver',
          driverPhone: data['driverPhone'] ?? '+91 98000 00000',
          driverLicense: 'Verified Commercial HMV 🟢',
          attendantName: 'Assigned Attendant',
          attendantPhone: '+91 98000 11111',
          liveStatus: 'PARKED IN DEPOT 🅿️',
          currentSpeed: '0 km/h',
          currentLocation: 'School Depot Bay',
          etaToSchool: 'At Campus',
          lastFuelDate: 'Today',
          lastFuelQuantity: 'Full Tank',
          lastFuelCost: '₹ 0.00',
          fuelMileage: '5.0 KM / Litre',
          lastServiceDate: 'Initial Inspection Passed',
          nextServiceDate: 'In 90 Days',
          fitnessExpiry: 'Valid for 1 Year',
          insuranceExpiry: 'Comprehensive Active',
          pucExpiry: 'Valid',
          routeStops: [
            RouteStopInfo(stopName: data['routeName'] ?? 'Start Point', scheduledTime: '07:00 AM', isCompleted: true, isCurrent: true),
            const RouteStopInfo(stopName: 'School Campus', scheduledTime: '08:00 AM', isCompleted: false),
          ],
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✨ New Fleet Vehicle registered successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filteredFleet = _fleetVehicles.where((v) {
      final q = _searchQuery.toLowerCase();
      return v.busNumber.toLowerCase().contains(q) ||
          v.routeName.toLowerCase().contains(q) ||
          v.driverName.toLowerCase().contains(q);
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
          TransportHeader(
            onAddVehicle: () {
              showDialog(
                context: context,
                builder: (ctx) => AddVehicleModal(onSave: _handleAddNewVehicle),
              );
            },
          ),
          const SizedBox(height: 20),

          // Search Bar
          _buildSearchBar(),
          const SizedBox(height: 20),

          // Modern Pill Navigation TabBar Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: !isDesktop,
                    indicator: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF6C5CE7).withValues(alpha: 0.3)),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: const Color(0xFF6C5CE7),
                    unselectedLabelColor: const Color(0xFF64748B),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.directions_bus_rounded, size: 18),
                        text: 'Fleet & Live GPS Tracking',
                      ),
                      Tab(
                        icon: Icon(Icons.local_gas_station_rounded, size: 18),
                        text: 'Fuel & Expense Ledger',
                      ),
                      Tab(
                        icon: Icon(Icons.car_repair_rounded, size: 18),
                        text: 'Servicing & Compliance',
                      ),
                      Tab(
                        icon: Icon(Icons.how_to_reg_rounded, size: 18),
                        text: 'Student Boarding Roll',
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),

                // Tab View Contents (Dynamic & Scrollable without rigid fixed height)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildActiveTabContent(filteredFleet),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTabContent(List<VehicleFleetInfo> filteredFleet) {
    switch (_tabController.index) {
      case 0:
        return FleetTrackingTab(
          fleet: filteredFleet,
          onBroadcastAlert: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('📢 WhatsApp Bus Route Alert triggered for parents & drivers!')),
            );
          },
        );
      case 1:
        return FuelLedgerTab(fleet: _fleetVehicles);
      case 2:
        return MaintenanceTab(fleet: _fleetVehicles);
      case 3:
        return StudentBoardingTab(fleet: _fleetVehicles);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSearchBar() {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: const InputDecoration(
          icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
          hintText: 'Search by Bus Number (DL 01 PB 4488), Route Corridor, or Driver Name...',
          hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
