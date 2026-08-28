import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClassroomLiveInfo {
  final String id;
  final String grade;
  final String section;
  final String roomNumber;
  final String classTeacher;
  final String teacherPhone;
  final int totalStrength;
  final int presentCount;
  final int absentCount;
  final double monthlyTuition;
  final double labFee;
  final double annualFee;
  final double feeCollectionPct;
  final String currentPeriod;
  final String currentSubject;
  final String currentTeacherTeaching;
  final String currentTopic;
  final String nextPeriod;
  final List<Map<String, dynamic>> students;
  final List<Map<String, String>> timetable;

  const ClassroomLiveInfo({
    required this.id,
    required this.grade,
    required this.section,
    required this.roomNumber,
    required this.classTeacher,
    required this.teacherPhone,
    required this.totalStrength,
    required this.presentCount,
    required this.absentCount,
    required this.monthlyTuition,
    required this.labFee,
    required this.annualFee,
    required this.feeCollectionPct,
    required this.currentPeriod,
    required this.currentSubject,
    required this.currentTeacherTeaching,
    required this.currentTopic,
    required this.nextPeriod,
    required this.students,
    required this.timetable,
  });
}

class AcademicsScreen extends ConsumerStatefulWidget {
  const AcademicsScreen({super.key});

  @override
  ConsumerState<AcademicsScreen> createState() => _AcademicsScreenState();
}

class _AcademicsScreenState extends ConsumerState<AcademicsScreen> {
  String _selectedFilter = 'ALL';
  String _searchQuery = '';

  static const List<ClassroomLiveInfo> _classrooms = [
    ClassroomLiveInfo(
      id: 'cls_10a',
      grade: 'Class 10',
      section: 'A',
      roomNumber: 'Room 204 (Science Block)',
      classTeacher: 'Dr. Priya Verma',
      teacherPhone: '+91 98111 22334',
      totalStrength: 42,
      presentCount: 40,
      absentCount: 2,
      monthlyTuition: 4000,
      labFee: 800,
      annualFee: 54000,
      feeCollectionPct: 88.4,
      currentPeriod: 'Period 4 (10:30 AM - 11:15 AM)',
      currentSubject: 'Physics & Dynamics',
      currentTeacherTeaching: 'Prof. Alok Mukherjee (In-Class 🟢)',
      currentTopic: 'Newtonian Motion & Friction Mechanics (Lab Practicals)',
      nextPeriod: 'Period 5 (11:15 AM) • Advanced Mathematics with Dr. Priya Verma',
      students: [
        {'name': 'Aarav Sharma', 'roll': '101', 'status': 'PRESENT', 'attendance': '98.4%', 'parent': 'Rajesh Sharma', 'phone': '+91 98111 22334'},
        {'name': 'Ananya Iyer', 'roll': '102', 'status': 'PRESENT', 'attendance': '99.1%', 'parent': 'Venkatesh Iyer', 'phone': '+91 98222 33445'},
        {'name': 'Rohan Mehta', 'roll': '103', 'status': 'ABSENT', 'attendance': '92.5%', 'parent': 'Sanjay Mehta', 'phone': '+91 98333 44556'},
        {'name': 'Diya Patel', 'roll': '104', 'status': 'PRESENT', 'attendance': '96.0%', 'parent': 'Kirit Patel', 'phone': '+91 98444 55667'},
        {'name': 'Kabir Kapoor', 'roll': '105', 'status': 'ABSENT', 'attendance': '94.2%', 'parent': 'Anil Kapoor', 'phone': '+91 98555 66778'},
        {'name': 'Sneha Kulkarni', 'roll': '106', 'status': 'PRESENT', 'attendance': '97.8%', 'parent': 'Madhav Kulkarni', 'phone': '+91 98666 77889'},
      ],
      timetable: [
        {'time': '08:30 - 09:15', 'sub': 'Assembly & Homeroom', 'teacher': 'Dr. Priya Verma'},
        {'time': '09:15 - 10:00', 'sub': 'English Literature', 'teacher': 'Mrs. Sunita Rao'},
        {'time': '10:00 - 10:30', 'sub': 'Chemistry & Reactions', 'teacher': 'Prof. Alok Mukherjee'},
        {'time': '10:30 - 11:15', 'sub': 'Physics & Dynamics (LIVE)', 'teacher': 'Prof. Alok Mukherjee'},
        {'time': '11:15 - 12:00', 'sub': 'Advanced Mathematics', 'teacher': 'Dr. Priya Verma'},
        {'time': '12:00 - 12:45', 'sub': 'Lunch & Sports Break', 'teacher': 'Coach Vikram'},
        {'time': '12:45 - 01:30', 'sub': 'Computer Science & AI', 'teacher': 'Ms. Ananya Sengupta'},
      ],
    ),
    ClassroomLiveInfo(
      id: 'cls_10b',
      grade: 'Class 10',
      section: 'B',
      roomNumber: 'Room 205',
      classTeacher: 'Prof. Alok Mukherjee',
      teacherPhone: '+91 98222 33445',
      totalStrength: 40,
      presentCount: 39,
      absentCount: 1,
      monthlyTuition: 4000,
      labFee: 800,
      annualFee: 54000,
      feeCollectionPct: 85.0,
      currentPeriod: 'Period 4 (10:30 AM - 11:15 AM)',
      currentSubject: 'Advanced Mathematics',
      currentTeacherTeaching: 'Dr. Priya Verma (In-Class 🟢)',
      currentTopic: 'Quadratic Equations & Trigonometric Identities',
      nextPeriod: 'Period 5 (11:15 AM) • Chemistry with Prof. Alok',
      students: [
        {'name': 'Vikramaditya Rao', 'roll': '101', 'status': 'PRESENT', 'attendance': '97.2%', 'parent': 'Rao S.', 'phone': '+91 98111 99881'},
        {'name': 'Tanvi Deshmukh', 'roll': '102', 'status': 'PRESENT', 'attendance': '98.0%', 'parent': 'Deshmukh A.', 'phone': '+91 98111 99882'},
        {'name': 'Harshvardhan Jain', 'roll': '103', 'status': 'ABSENT', 'attendance': '89.4%', 'parent': 'Jain V.', 'phone': '+91 98111 99883'},
      ],
      timetable: [
        {'time': '08:30 - 09:15', 'sub': 'Mathematics', 'teacher': 'Dr. Priya Verma'},
        {'time': '09:15 - 10:00', 'sub': 'Physics Lab', 'teacher': 'Prof. Alok'},
        {'time': '10:30 - 11:15', 'sub': 'Advanced Mathematics (LIVE)', 'teacher': 'Dr. Priya Verma'},
      ],
    ),
    ClassroomLiveInfo(
      id: 'cls_9a',
      grade: 'Class 9',
      section: 'A',
      roomNumber: 'Room 108',
      classTeacher: 'Mrs. Sunita Rao',
      teacherPhone: '+91 98333 44556',
      totalStrength: 45,
      presentCount: 44,
      absentCount: 1,
      monthlyTuition: 3800,
      labFee: 700,
      annualFee: 51000,
      feeCollectionPct: 91.2,
      currentPeriod: 'Period 4 (10:30 AM - 11:15 AM)',
      currentSubject: 'English Literature & Drama',
      currentTeacherTeaching: 'Mrs. Sunita Rao (In-Class 🟢)',
      currentTopic: 'Shakespeare\'s Julius Caesar (Act 3 Scene 2)',
      nextPeriod: 'Period 5 (11:15 AM) • Social Studies with Mr. Rajesh',
      students: [
        {'name': 'Diya Patel', 'roll': '104', 'status': 'PRESENT', 'attendance': '96.0%', 'parent': 'Kirit Patel', 'phone': '+91 98444 55667'},
      ],
      timetable: [],
    ),
    ClassroomLiveInfo(
      id: 'cls_11sci',
      grade: 'Class 11',
      section: 'Science (PCM/B)',
      roomNumber: 'Lab Block 3',
      classTeacher: 'Dr. Priya Verma',
      teacherPhone: '+91 98111 22334',
      totalStrength: 38,
      presentCount: 37,
      absentCount: 1,
      monthlyTuition: 5000,
      labFee: 1500,
      annualFee: 65000,
      feeCollectionPct: 94.0,
      currentPeriod: 'Period 4 (10:30 AM - 11:15 AM)',
      currentSubject: 'Organic Chemistry Lab',
      currentTeacherTeaching: 'Prof. Alok Mukherjee (In-Class 🟢)',
      currentTopic: 'Hydrocarbons & Isomerism Titration',
      nextPeriod: 'Period 5 (11:15 AM) • Calculus with Dr. Priya',
      students: [
        {'name': 'Kabir Kapoor', 'roll': '105', 'status': 'PRESENT', 'attendance': '94.2%', 'parent': 'Anil Kapoor', 'phone': '+91 98555 66778'},
      ],
      timetable: [],
    ),
    ClassroomLiveInfo(
      id: 'cls_12comm',
      grade: 'Class 12',
      section: 'Commerce & Eco',
      roomNumber: 'Commerce Wing 2',
      classTeacher: 'Mr. Rajesh Nambiar',
      teacherPhone: '+91 98444 55667',
      totalStrength: 36,
      presentCount: 35,
      absentCount: 1,
      monthlyTuition: 4700,
      labFee: 500,
      annualFee: 58000,
      feeCollectionPct: 90.0,
      currentPeriod: 'Period 4 (10:30 AM - 11:15 AM)',
      currentSubject: 'Macro Economics & Banking',
      currentTeacherTeaching: 'Mr. Rajesh Nambiar (In-Class 🟢)',
      currentTopic: 'Fiscal Policy & Reserve Bank Operations',
      nextPeriod: 'Period 5 (11:15 AM) • Accountancy',
      students: [
        {'name': 'Sneha Kulkarni', 'roll': '106', 'status': 'PRESENT', 'attendance': '97.8%', 'parent': 'Madhav Kulkarni', 'phone': '+91 98666 77889'},
      ],
      timetable: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filtered = _classrooms.where((c) {
      final matchesFilter = _selectedFilter == 'ALL' || c.grade == _selectedFilter;
      final matchesSearch = c.grade.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.section.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.classTeacher.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.currentSubject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.roomNumber.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Bar
          _buildTopHeader(context),
          const SizedBox(height: 20),

          // Search & Filter Tabs
          _buildFilterBar(context),
          const SizedBox(height: 24),

          // Classroom Cockpit Cards Grid
          _buildClassroomGrid(context, filtered, isDesktop),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
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
                'Live Classrooms & Academic Cockpit',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Real-Time Class Tracker • Current Ongoing Period, Teaching Faculty, Live Attendance & Fees Matrix',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF00B894), size: 10),
                    SizedBox(width: 6),
                    Text('PERIOD 4 ACTIVE (10:30 AM)', style: TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    const filters = ['ALL', 'Class 10', 'Class 9', 'Class 11', 'Class 12'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              hintText: 'Search by Class (e.g. Class 10), Teacher Name, Room No, or Current Subject...',
              hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) {
              final isSelected = _selectedFilter == f;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f == 'ALL' ? 'All Classes (32 Sections)' : f),
                  selected: isSelected,
                  selectedColor: const Color(0xFF6C5CE7),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12,
                  ),
                  side: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onSelected: (sel) {
                    if (sel) setState(() => _selectedFilter = f);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildClassroomGrid(BuildContext context, List<ClassroomLiveInfo> classrooms, bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: classrooms.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: crossAxisCount == 1 ? 1.4 : 1.15,
          ),
          itemBuilder: (context, index) {
            final c = classrooms[index];
            return _buildClassCard(context, c);
          },
        );
      },
    );
  }

  Widget _buildClassCard(BuildContext context, ClassroomLiveInfo c) {
    final attendancePct = (c.presentCount / c.totalStrength) * 100;

    return InkWell(
      onTap: () => _openClass360Dossier(context, c),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header: Grade & Room + Teacher
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${c.grade} - Section ${c.section}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(c.roomNumber, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('₹ ${c.annualFee.toInt()}/yr', style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11)),
                ),
              ],
            ),

            // Class Teacher Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Row(
                children: [
                  const Icon(Icons.person_pin_rounded, color: Color(0xFF6C5CE7), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Class Teacher: ${c.classTeacher}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF334155)), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),

            // LIVE PERIOD HIGHLIGHT BOX
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4), // Soft Green
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDCFCE7)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.live_tv_rounded, color: Color(0xFF00B894), size: 14),
                          SizedBox(width: 6),
                          Text('LIVE ONGOING PERIOD', style: TextStyle(color: Color(0xFF15803D), fontSize: 10, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Text('Period 4', style: TextStyle(color: Colors.green[800], fontSize: 10, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(c.currentSubject, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF14532D))),
                  const SizedBox(height: 2),
                  Text('👨‍🏫 ${c.currentTeacherTeaching}', style: const TextStyle(fontSize: 11, color: Color(0xFF166534), fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            // Attendance & Strength Strip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                      child: Text('${c.presentCount} Present', style: const TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 6),
                    if (c.absentCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFFF7675).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                        child: Text('${c.absentCount} Absent', style: const TextStyle(color: Color(0xFFD63031), fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                  ],
                ),
                Text('Open 360° Cockpit ➔', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- CLASS 360° LIVE DOSSIER MODAL ---
  void _openClass360Dossier(BuildContext context, ClassroomLiveInfo c) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Class Cockpit',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return _Class360DossierDialog(classroom: c);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }
}

class _Class360DossierDialog extends StatefulWidget {
  final ClassroomLiveInfo classroom;

  const _Class360DossierDialog({required this.classroom});

  @override
  State<_Class360DossierDialog> createState() => _Class360DossierDialogState();
}

class _Class360DossierDialogState extends State<_Class360DossierDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final c = widget.classroom;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isDesktop ? 960 : size.width * 0.95,
          height: size.height * 0.88,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            children: [
              // Top Header
              _buildTopHeader(c),

              // Tab Switcher
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  border: Border(top: BorderSide(color: Color(0xFFE2E8F0)), bottom: BorderSide(color: Color(0xFFE2E8F0))),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: const Color(0xFF6C5CE7),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFF6C5CE7),
                  unselectedLabelColor: const Color(0xFF64748B),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  tabs: const [
                    Tab(icon: Icon(Icons.live_tv_rounded, size: 18), text: '1. Live Period & Attendance'),
                    Tab(icon: Icon(Icons.account_balance_wallet_rounded, size: 18), text: '2. Class Fee Structure'),
                    Tab(icon: Icon(Icons.people_alt_rounded, size: 18), text: '3. Full Student Roll (42)'),
                    Tab(icon: Icon(Icons.calendar_month_rounded, size: 18), text: '4. Weekly Timetable Grid'),
                  ],
                ),
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLivePeriodAndAttendanceTab(c),
                    _buildClassFeeTab(c),
                    _buildStudentRollTab(c),
                    _buildTimetableTab(c),
                  ],
                ),
              ),

              // Bottom Action Hub
              _buildBottomActionHub(c),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(ClassroomLiveInfo c) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.school_rounded, color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${c.grade} - Section ${c.section}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(c.roomNumber, style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('👩‍🏫 Class Teacher: ${c.classTeacher} (${c.teacherPhone})', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    Text('•  Total Enrolled: ${c.totalStrength} Scholars', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8), size: 24),
          ),
        ],
      ),
    );
  }

  // --- TAB 1: LIVE ONGOING PERIOD & ATTENDANCE ---
  Widget _buildLivePeriodAndAttendanceTab(ClassroomLiveInfo c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Live Period Highlight Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFF00B894), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, color: Colors.white, size: 8),
                              SizedBox(width: 6),
                              Text('LIVE IN CLASSROOM NOW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(c.currentPeriod, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Text(c.roomNumber, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  c.currentSubject,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person_rounded, color: Color(0xFFA29BFE), size: 18),
                    const SizedBox(width: 8),
                    Text('Active Faculty Teaching: ', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    Text(c.currentTeacherTeaching, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.topic_rounded, color: Color(0xFF00CEC9), size: 18),
                    const SizedBox(width: 8),
                    Text('Lecture Topic: ', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    Expanded(child: Text(c.currentTopic, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(Icons.next_plan_outlined, color: Colors.white54, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(c.nextPeriod, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Real-Time Attendance Pulse
          const Text('Today\'s Live Attendance Roll Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFDCFCE7))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('PRESENT STUDENTS', style: TextStyle(fontSize: 10, color: Color(0xFF166534), fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('${c.presentCount} Scholars', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF15803D))),
                      const SizedBox(height: 2),
                      Text('${((c.presentCount / c.totalStrength) * 100).toStringAsFixed(1)}% Present In Class', style: const TextStyle(fontSize: 11, color: Color(0xFF166534))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFFEE2E2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ABSENT TODAY (NOT IN SCHOOL)', style: TextStyle(fontSize: 10, color: Color(0xFF991B1B), fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('${c.absentCount} Absent', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFFDC2626))),
                      const SizedBox(height: 2),
                      const Text('Rohan Mehta, Kabir Kapoor', style: TextStyle(fontSize: 11, color: Color(0xFF991B1B), fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Absent Alert Bar
          if (c.absentCount > 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFFDE68A))),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 22),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '2 students have not reported to morning roll call. Parents have not submitted leave slips.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF92400E), fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('📢 Automated WhatsApp Absence Alert sent to Rohan Mehta & Kabir Kapoor\'s parents!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD97706), foregroundColor: Colors.white, elevation: 0),
                    child: const Text('WhatsApp Parents Now', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // --- TAB 2: CLASS FEE STRUCTURE ---
  Widget _buildClassFeeTab(ClassroomLiveInfo c) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Prescribed Fee Structure for this Grade', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Column(
              children: [
                _buildFeeLine('Monthly Base Tuition Fee', '₹ ${c.monthlyTuition.toInt()} / month', 'Covers core curriculum & classroom teaching'),
                const Divider(height: 20, color: Color(0xFFE2E8F0)),
                _buildFeeLine('Science & Computer Lab Maintenance', '₹ ${c.labFee.toInt()} / month', 'Covers Physics/Chemistry/AI practical kits'),
                const Divider(height: 20, color: Color(0xFFE2E8F0)),
                _buildFeeLine('Annual Examination & Term Assessments', '₹ 2,000 / year', 'Includes printed papers & digital report card'),
                const Divider(height: 20, color: Color(0xFFE2E8F0)),
                _buildFeeLine('Sports & Annual Fest Activities', '₹ 1,500 / year', 'Covers playground gear & inter-school fests'),
                const Divider(height: 24, color: Color(0xFFE2E8F0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOTAL ANNUAL FEE PER STUDENT', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF1E293B))),
                    Text('₹ ${c.annualFee.toInt()} / Year', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF6C5CE7))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Total Class Realisation
          const Text('Class 10-A Collection Realisation Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${c.feeCollectionPct}% Target Collected', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF00B894))),
                    const Text('38 Cleared • 4 Pending', style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    height: 8,
                    child: LinearProgressIndicator(
                      value: c.feeCollectionPct / 100,
                      backgroundColor: const Color(0xFFE2E8F0),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeLine(String title, String amount, String sub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B))),
            const SizedBox(height: 2),
            Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          ],
        ),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF334155))),
      ],
    );
  }

  // --- TAB 3: FULL STUDENT ROLL ---
  Widget _buildStudentRollTab(ClassroomLiveInfo c) {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: c.students.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
      itemBuilder: (context, index) {
        final s = c.students[index];
        final isPresent = s['status'] == 'PRESENT';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
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
                    Text(s['name'], style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                    Text('Roll #${s['roll']} • Parent: ${s['parent']} (${s['phone']})', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isPresent ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isPresent ? 'PRESENT' : 'ABSENT TODAY',
                  style: TextStyle(color: isPresent ? const Color(0xFF2E7D32) : const Color(0xFFC62828), fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Color(0xFF00B894)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Ping to ${s['name']}\'s Parent')));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 4: WEEKLY TIMETABLE GRID ---
  Widget _buildTimetableTab(ClassroomLiveInfo c) {
    if (c.timetable.isEmpty) {
      return const Center(child: Text('Timetable for this section is generated & syncing.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: c.timetable.length,
      itemBuilder: (context, index) {
        final t = c.timetable[index];
        final isLive = t['sub']!.contains('LIVE');

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isLive ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isLive ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: isLive ? const Color(0xFF00B894) : const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(6)),
                child: Text(
                  t['time']!,
                  style: TextStyle(color: isLive ? Colors.white : const Color(0xFF334155), fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['sub']!, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: isLive ? const Color(0xFF14532D) : const Color(0xFF1E293B))),
                    Text('Faculty: ${t['teacher']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              if (isLive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF00B894), borderRadius: BorderRadius.circular(6)),
                  child: const Text('ACTIVE NOW', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionHub(ClassroomLiveInfo c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📹 Connecting to Live CCTV Stream in ${c.roomNumber}...')));
                },
                icon: const Icon(Icons.videocam_rounded, color: Color(0xFF0984E3), size: 18),
                label: const Text('View Classroom CCTV', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📞 Calling Class Teacher ${c.classTeacher}...')));
                },
                icon: const Icon(Icons.phone_rounded, color: Color(0xFF00B894), size: 18),
                label: const Text('Call Teacher', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📢 Broadcast Message drafted to all parents of ${c.grade}-${c.section}!')));
            },
            icon: const Icon(Icons.campaign_rounded, size: 18),
            label: const Text('Broadcast Notice to Class'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
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
}
