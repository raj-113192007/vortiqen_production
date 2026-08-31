import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ClassFeeRule {
  final String grade;
  final String stream;
  final double tuitionFee;
  final double labFee;
  final double examFee;
  final double sportsFee;
  final int totalStudents;

  double get monthlyTotal => tuitionFee + labFee;
  double get annualTotal => (monthlyTotal * 12) + examFee + sportsFee;

  const ClassFeeRule({
    required this.grade,
    this.stream = 'General',
    required this.tuitionFee,
    required this.labFee,
    required this.examFee,
    required this.sportsFee,
    required this.totalStudents,
  });
}

class BusRouteSlab {
  final String routeId;
  final String routeName;
  final String busNumber;
  final String driverName;
  final int totalStops;
  final int enrolledStudents;
  final int totalCapacity;
  final double monthlyFee;
  final String zone;

  const BusRouteSlab({
    required this.routeId,
    required this.routeName,
    required this.busNumber,
    required this.driverName,
    required this.totalStops,
    required this.enrolledStudents,
    required this.totalCapacity,
    required this.monthlyFee,
    required this.zone,
  });
}

class AcademicClassMaster {
  final String className;
  final String section;
  final String classTeacher;
  final String roomNumber;
  final int currentStrength;
  final int maxCapacity;

  const AcademicClassMaster({
    required this.className,
    required this.section,
    required this.classTeacher,
    required this.roomNumber,
    required this.currentStrength,
    required this.maxCapacity,
  });

  AcademicClassMaster copyWith({
    String? className,
    String? section,
    String? classTeacher,
    String? roomNumber,
    int? currentStrength,
    int? maxCapacity,
  }) {
    return AcademicClassMaster(
      className: className ?? this.className,
      section: section ?? this.section,
      classTeacher: classTeacher ?? this.classTeacher,
      roomNumber: roomNumber ?? this.roomNumber,
      currentStrength: currentStrength ?? this.currentStrength,
      maxCapacity: maxCapacity ?? this.maxCapacity,
    );
  }
}

class SchoolMasterHubScreen extends ConsumerStatefulWidget {
  const SchoolMasterHubScreen({super.key});

  @override
  ConsumerState<SchoolMasterHubScreen> createState() => _SchoolMasterHubScreenState();
}

class _SchoolMasterHubScreenState extends ConsumerState<SchoolMasterHubScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ClassFeeRule> _feeRules = [
    const ClassFeeRule(grade: 'Class 10', stream: 'Secondary CBSE', tuitionFee: 4000, labFee: 800, examFee: 2000, sportsFee: 1500, totalStudents: 82),
    const ClassFeeRule(grade: 'Class 9', stream: 'Secondary CBSE', tuitionFee: 3800, labFee: 700, examFee: 2000, sportsFee: 1500, totalStudents: 85),
    const ClassFeeRule(grade: 'Class 11', stream: 'Senior Science (PCM/B)', tuitionFee: 5000, labFee: 1500, examFee: 2500, sportsFee: 1500, totalStudents: 78),
    const ClassFeeRule(grade: 'Class 11', stream: 'Senior Commerce & Arts', tuitionFee: 4500, labFee: 500, examFee: 2500, sportsFee: 1500, totalStudents: 72),
    const ClassFeeRule(grade: 'Class 12', stream: 'Senior Science (PCM/B)', tuitionFee: 5200, labFee: 1600, examFee: 3000, sportsFee: 1500, totalStudents: 75),
    const ClassFeeRule(grade: 'Class 12', stream: 'Senior Commerce', tuitionFee: 4700, labFee: 500, examFee: 3000, sportsFee: 1500, totalStudents: 70),
    const ClassFeeRule(grade: 'Class 6 - 8', stream: 'Middle School', tuitionFee: 3200, labFee: 400, examFee: 1500, sportsFee: 1200, totalStudents: 240),
    const ClassFeeRule(grade: 'Class 1 - 5', stream: 'Primary Wing', tuitionFee: 2500, labFee: 200, examFee: 1000, sportsFee: 1000, totalStudents: 380),
    const ClassFeeRule(grade: 'Nursery - UKG', stream: 'Kindergarten', tuitionFee: 2200, labFee: 0, examFee: 800, sportsFee: 800, totalStudents: 190),
  ];

  final List<BusRouteSlab> _busRoutes = [
    const BusRouteSlab(
      routeId: 'rt_01',
      routeName: 'Route 01: North Campus & Civil Lines',
      busNumber: 'DL 01 PB 1102',
      driverName: 'Mohan Singh',
      totalStops: 12,
      enrolledStudents: 38,
      totalCapacity: 40,
      monthlyFee: 1800,
      zone: 'Zone 2 (3-7 km)',
    ),
    const BusRouteSlab(
      routeId: 'rt_02',
      routeName: 'Route 02: West Sector Expressway',
      busNumber: 'DL 01 PB 2244',
      driverName: 'Suresh Pal',
      totalStops: 14,
      enrolledStudents: 40,
      totalCapacity: 40,
      monthlyFee: 2400,
      zone: 'Zone 3 (7-15 km)',
    ),
    const BusRouteSlab(
      routeId: 'rt_03',
      routeName: 'Route 03: South Colony & Outer Ring',
      busNumber: 'DL 01 PB 3311',
      driverName: 'Deepak Sharma',
      totalStops: 10,
      enrolledStudents: 35,
      totalCapacity: 40,
      monthlyFee: 1500,
      zone: 'Zone 1 (0-3 km)',
    ),
    const BusRouteSlab(
      routeId: 'rt_04',
      routeName: 'Route 04: Sector 14 Metro Express',
      busNumber: 'DL 01 PB 4488',
      driverName: 'Ramesh Kumar',
      totalStops: 11,
      enrolledStudents: 34,
      totalCapacity: 40,
      monthlyFee: 1800,
      zone: 'Zone 2 (3-7 km)',
    ),
  ];

  final List<AcademicClassMaster> _classList = [
    const AcademicClassMaster(className: 'Class 10', section: 'A', classTeacher: 'Dr. Priya Verma', roomNumber: 'Room 204', currentStrength: 42, maxCapacity: 45),
    const AcademicClassMaster(className: 'Class 10', section: 'B', classTeacher: 'Prof. Alok Mukherjee', roomNumber: 'Room 205', currentStrength: 40, maxCapacity: 45),
    const AcademicClassMaster(className: 'Class 9', section: 'A', classTeacher: 'Mrs. Sunita Rao', roomNumber: 'Room 108', currentStrength: 45, maxCapacity: 45),
    const AcademicClassMaster(className: 'Class 9', section: 'B', classTeacher: 'Mr. Rajesh Nambiar', roomNumber: 'Room 109', currentStrength: 40, maxCapacity: 45),
    const AcademicClassMaster(className: 'Class 11', section: 'Science', classTeacher: 'Dr. Priya Verma', roomNumber: 'Lab Block 3', currentStrength: 38, maxCapacity: 40),
    const AcademicClassMaster(className: 'Class 11', section: 'Commerce', classTeacher: 'Mr. Rajesh Nambiar', roomNumber: 'Commerce Wing 1', currentStrength: 36, maxCapacity: 40),
    const AcademicClassMaster(className: 'Class 12', section: 'Science', classTeacher: 'Prof. Alok Mukherjee', roomNumber: 'Lab Block 4', currentStrength: 39, maxCapacity: 40),
    const AcademicClassMaster(className: 'Class 12', section: 'Commerce', classTeacher: 'Mrs. Sunita Rao', roomNumber: 'Commerce Wing 2', currentStrength: 35, maxCapacity: 40),
  ];

  final List<Map<String, String>> _availableFaculty = const [
    {'name': 'Dr. Priya Verma', 'dept': 'Physics & Natural Sciences', 'phone': '+91 98111 22334'},
    {'name': 'Prof. Alok Mukherjee', 'dept': 'Advanced Mathematics & Calculus', 'phone': '+91 98222 33445'},
    {'name': 'Mrs. Sunita Rao', 'dept': 'Biology & Biotechnology', 'phone': '+91 98666 77889'},
    {'name': 'Mr. Rajesh Nambiar', 'dept': 'Commerce & Accountancy', 'phone': '+91 98777 88990'},
    {'name': 'Ms. Ananya Sengupta', 'dept': 'Computer Science & AI', 'phone': '+91 98333 44556'},
    {'name': 'Dr. Ramesh Iyer', 'dept': 'Organic Chemistry', 'phone': '+91 98444 55667'},
    {'name': 'Mr. Vikram Sethi', 'dept': 'Physical Education & Athletics', 'phone': '+91 98555 66778'},
  ];

  void _showAssignTeacherDialog(BuildContext context, AcademicClassMaster c, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF6C5CE7), size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Assign Class Teacher', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                  Text('Class: ${c.className} - Section ${c.section}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select a teacher to appoint as the official Class Teacher for this section:', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              const SizedBox(height: 12),
              SizedBox(
                height: 260,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _availableFaculty.length,
                  itemBuilder: (context, fIndex) {
                    final f = _availableFaculty[fIndex];
                    final isSelected = f['name'] == c.classTeacher;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF6C5CE7).withValues(alpha: 0.08) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0)),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFF1F5F9),
                          child: Text(f['name']![0], style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1E293B), fontWeight: FontWeight.w800)),
                        ),
                        title: Text(f['name']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                        subtitle: Text('${f['dept']} • ${f['phone']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        trailing: ElevatedButton(
                          onPressed: isSelected
                              ? null
                              : () {
                                  setState(() {
                                    _classList[index] = _classList[index].copyWith(classTeacher: f['name']);
                                  });
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Appointed ${f['name']} as Class Teacher for ${c.className}-${c.section}! 🎓'),
                                      backgroundColor: const Color(0xFF10B981),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected ? const Color(0xFF94A3B8) : const Color(0xFF6C5CE7),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: Text(isSelected ? 'Current' : 'Assign'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeaderBar(context),
          ),
          const SizedBox(height: 20),

          // Tab Bar
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF6C5CE7),
                indicatorWeight: 3,
                labelColor: const Color(0xFF6C5CE7),
                unselectedLabelColor: const Color(0xFF64748B),
                labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: const [
                  Tab(icon: Icon(Icons.account_balance_wallet_rounded, size: 18), text: '1. Class Fee Structure Matrix'),
                  Tab(icon: Icon(Icons.directions_bus_rounded, size: 18), text: '2. Transport Routes & Bus Slabs'),
                  Tab(icon: Icon(Icons.school_rounded, size: 18), text: '3. Academic Classes & Capacities'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Tab Content
          FadeSlideEntry(
            delay: const Duration(milliseconds: 150),
            child: SizedBox(
              height: 650,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeeMatrixTab(context, isDesktop),
                  _buildTransportMasterTab(context, isDesktop),
                  _buildClassMasterTab(context, isDesktop),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School Master & Fee Matrix Engine',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Configure Class-Wise Fees, Bus Distance Slabs, and Section Allotments for 2026-27',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFF10B981)),
                    SizedBox(width: 6),
                    Text('MATRIX LIVE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Master rule saved & live student ledgers recalculated!')),
                  );
                },
                icon: const Icon(Icons.save_rounded, size: 16),
                label: const Text('Save & Apply Rules'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- TAB 1: CLASS FEE MATRIX ---
  Widget _buildFeeMatrixTab(BuildContext context, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('GRADE & STREAM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('TUITION / MO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('LAB & ACTIVITY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('EXAM & SPORTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('ANNUAL TOTAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('ENROLLED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('ACTION', textAlign: TextAlign.end, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _feeRules.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final r = _feeRules[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.grade, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                            Text(r.stream, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: Text('₹ ${r.tuitionFee.toInt()}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13))),
                      Expanded(flex: 2, child: Text('₹ ${r.labFee.toInt()}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF475569)))),
                      Expanded(flex: 2, child: Text('₹ ${(r.examFee + r.sportsFee).toInt()}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF475569)))),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹ ${r.annualTotal.toInt()}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF6C5CE7)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                          child: Text('${r.totalStudents} Students', style: const TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF6C5CE7)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editing Fee Rule for ${r.grade}')));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2: TRANSPORT BUS SLABS ---
  Widget _buildTransportMasterTab(BuildContext context, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: const Row(
              children: [
                Expanded(flex: 4, child: Text('ROUTE NAME & BUS NO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('DISTANCE ZONE SLAB', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('MONTHLY BUS FEE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('OCCUPANCY / CAPACITY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('ACTION', textAlign: TextAlign.end, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _busRoutes.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final b = _busRoutes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: const Color(0xFFF39C12).withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                              child: const Icon(Icons.directions_bus_rounded, color: Color(0xFFF39C12), size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(b.routeName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                                  Text('${b.busNumber} • Driver: ${b.driverName}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                          child: Text(b.zone, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xFF334155))),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('₹ ${b.monthlyFee.toInt()} / mo', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF00B894))),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text('${b.enrolledStudents} / ${b.totalCapacity}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                            const SizedBox(width: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                width: 60,
                                height: 6,
                                child: LinearProgressIndicator(
                                  value: b.enrolledStudents / b.totalCapacity,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFF6C5CE7)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF6C5CE7)),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editing Route Rate for ${b.routeName}')));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 3: CLASSES & CAPACITIES MASTER ---
  Widget _buildClassMasterTab(BuildContext context, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('GRADE & SECTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('CLASS TEACHER', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('ROOM NO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('CURRENT STRENGTH', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text('ACTION', textAlign: TextAlign.end, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _classList.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final c = _classList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text('${c.className} - ${c.section}', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7), fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () => _showAssignTeacherDialog(context, c, index),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(c.classTeacher, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.edit_note_rounded, size: 16, color: Color(0xFF6C5CE7)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c.roomNumber, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Text('${c.currentStrength} / ${c.maxCapacity}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                            const SizedBox(width: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                width: 60,
                                height: 6,
                                child: LinearProgressIndicator(
                                  value: c.currentStrength / c.maxCapacity,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            tooltip: 'Assign Class Teacher',
                            icon: const Icon(Icons.person_add_alt_1_rounded, size: 18, color: Color(0xFF6C5CE7)),
                            onPressed: () => _showAssignTeacherDialog(context, c, index),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
