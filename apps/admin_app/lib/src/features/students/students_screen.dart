import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../onboarding/presentation/data_onboarding_hub_screen.dart';

class StudentDirectoryItem {
  final String id;
  final String grNo;
  final String rollNo;
  final String name;
  final String className;
  final String section;
  final String gender;
  final String parentName;
  final String parentPhone;
  final double attendancePct;
  final String feeStatus;
  final double feeDueAmount;
  final String bloodGroup;
  final String admissionDate;
  final String busRoute;

  const StudentDirectoryItem({
    required this.id,
    required this.grNo,
    required this.rollNo,
    required this.name,
    required this.className,
    required this.section,
    required this.gender,
    required this.parentName,
    required this.parentPhone,
    required this.attendancePct,
    required this.feeStatus,
    required this.feeDueAmount,
    required this.bloodGroup,
    required this.admissionDate,
    required this.busRoute,
  });
}

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  String _selectedClass = 'ALL';
  String _selectedStatus = 'ALL';
  String _searchQuery = '';
  bool _isGridView = false;

  static const List<StudentDirectoryItem> _students = [
    StudentDirectoryItem(
      id: 'stu_01',
      grNo: 'GR-2024-101',
      rollNo: '101',
      name: 'Aarav Sharma',
      className: 'Class 10',
      section: 'A',
      gender: 'M',
      parentName: 'Rajesh Sharma (Father)',
      parentPhone: '+91 98111 22334',
      attendancePct: 98.4,
      feeStatus: 'PAID',
      feeDueAmount: 0,
      bloodGroup: 'B+',
      admissionDate: '12 April 2022',
      busRoute: 'Route 04 (Civil Lines)',
    ),
    StudentDirectoryItem(
      id: 'stu_02',
      grNo: 'GR-2024-102',
      rollNo: '102',
      name: 'Ananya Iyer',
      className: 'Class 10',
      section: 'A',
      gender: 'F',
      parentName: 'Venkatesh Iyer (Father)',
      parentPhone: '+91 98222 33445',
      attendancePct: 99.1,
      feeStatus: 'PAID',
      feeDueAmount: 0,
      bloodGroup: 'O+',
      admissionDate: '15 June 2021',
      busRoute: 'Route 01 (North Gate)',
    ),
    StudentDirectoryItem(
      id: 'stu_03',
      grNo: 'GR-2024-103',
      rollNo: '103',
      name: 'Rohan Mehta',
      className: 'Class 10',
      section: 'B',
      gender: 'M',
      parentName: 'Sanjay Mehta (Father)',
      parentPhone: '+91 98333 44556',
      attendancePct: 92.5,
      feeStatus: 'DUE',
      feeDueAmount: 4500,
      bloodGroup: 'A+',
      admissionDate: '10 July 2023',
      busRoute: 'Self Commute / Private',
    ),
    StudentDirectoryItem(
      id: 'stu_04',
      grNo: 'GR-2024-104',
      rollNo: '104',
      name: 'Diya Patel',
      className: 'Class 9',
      section: 'A',
      gender: 'F',
      parentName: 'Kirit Patel (Father)',
      parentPhone: '+91 98444 55667',
      attendancePct: 96.0,
      feeStatus: 'PAID',
      feeDueAmount: 0,
      bloodGroup: 'AB+',
      admissionDate: '01 April 2024',
      busRoute: 'Route 02 (West Sector)',
    ),
    StudentDirectoryItem(
      id: 'stu_05',
      grNo: 'GR-2024-105',
      rollNo: '105',
      name: 'Kabir Kapoor',
      className: 'Class 11',
      section: 'Science',
      gender: 'M',
      parentName: 'Anil Kapoor (Father)',
      parentPhone: '+91 98555 66778',
      attendancePct: 94.2,
      feeStatus: 'DUE',
      feeDueAmount: 7200,
      bloodGroup: 'O-',
      admissionDate: '20 August 2020',
      busRoute: 'Route 04 (Civil Lines)',
    ),
    StudentDirectoryItem(
      id: 'stu_06',
      grNo: 'GR-2024-106',
      rollNo: '106',
      name: 'Sneha Kulkarni',
      className: 'Class 12',
      section: 'Commerce',
      gender: 'F',
      parentName: 'Madhav Kulkarni (Father)',
      parentPhone: '+91 98666 77889',
      attendancePct: 97.8,
      feeStatus: 'PAID',
      feeDueAmount: 0,
      bloodGroup: 'B-',
      admissionDate: '18 April 2019',
      busRoute: 'Route 03 (South Campus)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filteredStudents = _students.where((s) {
      final matchesClass = _selectedClass == 'ALL' || '${s.className}-${s.section}' == _selectedClass || s.className == _selectedClass;
      final matchesStatus = _selectedStatus == 'ALL' || s.feeStatus == _selectedStatus;
      final matchesSearch = s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.rollNo.contains(_searchQuery) ||
          s.grNo.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.parentName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.parentPhone.contains(_searchQuery);
      return matchesClass && matchesStatus && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Executive Toolbar
          _buildHeaderToolbar(context),
          const SizedBox(height: 20),

          // 2. 4 Metric Summary Chips
          _buildSummaryMetricStrip(context, isDesktop),
          const SizedBox(height: 24),

          // 3. Search & Class Tabs Filter Bar
          _buildFilterBar(context),
          const SizedBox(height: 20),

          // 4. Student Data Presentation (Table or Cards)
          if (_isGridView)
            _buildStudentCardGrid(context, filteredStudents, isDesktop)
          else
            _buildStudentTable(context, filteredStudents, isDesktop),
        ],
      ),
    );
  }

  // --- 1. Top Executive Toolbar ---
  Widget _buildHeaderToolbar(BuildContext context) {
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
                'Students & Scholars Directory',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Live Roster • 1,420 Enrolled Across Grades Nursery - 12th • Term 2 (2026-27)',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DataOnboardingHubScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.cloud_upload_rounded, size: 16),
                label: const Text('Bulk Onboarding (5-in-1)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _showQuickEnrollModal(context),
                icon: const Icon(Icons.person_add_rounded, size: 16, color: Color(0xFF334155)),
                label: const Text('Quick Admission', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Metric Summary Strip ---
  Widget _buildSummaryMetricStrip(BuildContext context, bool isDesktop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 4 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: crossAxisCount == 4 ? 2.4 : 3.0,
          children: [
            _buildStatBox('Total Enrolled', '1,420', '724 Boys • 696 Girls', const Color(0xFF6C5CE7), Icons.school_rounded),
            _buildStatBox('Daily Attendance', '96.8%', '1,374 Present Today', const Color(0xFF00B894), Icons.how_to_reg_rounded),
            _buildStatBox('Fee Clearance', '88.7%', '1,280 Cleared • 140 Due', const Color(0xFF0984E3), Icons.account_balance_wallet_rounded),
            _buildStatBox('Bus Commuters', '412', '8 Active Routes', const Color(0xFFF39C12), Icons.directions_bus_rounded),
          ],
        );
      },
    );
  }

  Widget _buildStatBox(String label, String value, String sub, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: -0.5)),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. Filter Bar ---
  Widget _buildFilterBar(BuildContext context) {
    const classTabs = [
      {'label': 'All Grades (1,420)', 'key': 'ALL'},
      {'label': 'Class 10-A (42)', 'key': 'Class 10-A'},
      {'label': 'Class 10-B (40)', 'key': 'Class 10-B'},
      {'label': 'Class 9-A (45)', 'key': 'Class 9-A'},
      {'label': 'Class 11-Science (38)', 'key': 'Class 11-Science'},
      {'label': 'Class 12-Commerce (36)', 'key': 'Class 12-Commerce'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Search Input
            Expanded(
              child: Container(
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
                    hintText: 'Search student by Name, Roll No, GR-Number, or Parent Phone...',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // View Switcher (Table / Grid)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.table_rows_rounded, color: !_isGridView ? const Color(0xFF6C5CE7) : const Color(0xFF94A3B8), size: 20),
                    onPressed: () => setState(() => _isGridView = false),
                    tooltip: 'Table List View',
                  ),
                  IconButton(
                    icon: Icon(Icons.grid_view_rounded, color: _isGridView ? const Color(0xFF6C5CE7) : const Color(0xFF94A3B8), size: 20),
                    onPressed: () => setState(() => _isGridView = true),
                    tooltip: 'Dossier Cards View',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Class Filter Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: classTabs.map((tab) {
              final isSelected = _selectedClass == tab['key'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(tab['label']!),
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
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedClass = tab['key']!);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- 4. Table View Presentation ---
  Widget _buildStudentTable(BuildContext context, List<StudentDirectoryItem> students, bool isDesktop) {
    if (students.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
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
                Expanded(flex: 4, child: Text('STUDENT & GR-NO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('CLASS & ROLL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 4, child: Text('PARENT & CONTACT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('ATTENDANCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 3, child: Text('FEE STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text('ACTIONS', textAlign: TextAlign.end, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              ],
            ),
          ),

          // Table Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, index) {
              final s = students[index];
              return _buildStudentTableRow(context, s);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudentTableRow(BuildContext context, StudentDirectoryItem s) {
    final isPaid = s.feeStatus == 'PAID';

    return InkWell(
      onTap: () => _showStudentDossier(context, s),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // Student Name & GR
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                    child: Text(
                      s.name[0],
                      style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                        Text(s.grNo, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Class & Section
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                    child: Text('${s.className} - ${s.section}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF334155))),
                  ),
                  const SizedBox(height: 2),
                  Text('Roll #${s.rollNo}', style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                ],
              ),
            ),

            // Parent & Contact
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.parentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF1E293B))),
                        Text(s.parentPhone, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Color(0xFF00B894)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Ping initiated for ${s.parentName}')));
                    },
                    tooltip: 'WhatsApp Parent',
                  ),
                ],
              ),
            ),

            // Attendance
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${s.attendancePct}%', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF00B894))),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: 5,
                      width: 80,
                      child: LinearProgressIndicator(
                        value: s.attendancePct / 100,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fee Status
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isPaid ? const Color(0xFFA5D6A7) : const Color(0xFFFFCDD2)),
                ),
                child: Text(
                  isPaid ? 'PAID' : 'DUE ₹ ${s.feeDueAmount.toInt()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isPaid ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                  ),
                ),
              ),
            ),

            // Actions
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                  onPressed: () => _showStudentDossier(context, s),
                  tooltip: 'View Student 360° Dossier',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 5. Grid View Presentation ---
  Widget _buildStudentCardGrid(BuildContext context, List<StudentDirectoryItem> students, bool isDesktop) {
    if (students.isEmpty) return _buildEmptyState();

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: students.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.45,
          ),
          itemBuilder: (context, index) {
            final s = students[index];
            final isPaid = s.feeStatus == 'PAID';

            return InkWell(
              onTap: () => _showStudentDossier(context, s),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                          child: Text(s.name[0], style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 16)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                              Text('${s.className} - ${s.section} • Roll #${s.rollNo}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isPaid ? 'PAID' : 'DUE',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: isPaid ? const Color(0xFF2E7D32) : const Color(0xFFC62828)),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16, color: Color(0xFFF1F5F9)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ATTENDANCE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                            Text('${s.attendancePct}%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF00B894))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TRANSPORT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                            Text(s.busRoute.split('(').first.trim(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('GR-NUMBER', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                            Text(s.grNo, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(s.parentName, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        Text('View 360° ➔', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF94A3B8)),
          SizedBox(height: 12),
          Text('No students match your active filters.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- 6. 360° Student Dossier Slide-Over Sheet ---
  void _showStudentDossier(BuildContext context, StudentDirectoryItem s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),

                // Student Profile Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                      child: Text(s.name[0], style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w900, fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                          const SizedBox(height: 2),
                          Text('${s.className} - Section ${s.section} • Roll #${s.rollNo} • ${s.grNo}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                                child: Text('Attendance: ${s.attendancePct}%', style: const TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: s.feeStatus == 'PAID' ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(s.feeStatus == 'PAID' ? 'Fee Cleared' : 'Due: ₹ ${s.feeDueAmount.toInt()}', style: TextStyle(color: s.feeStatus == 'PAID' ? const Color(0xFF2E7D32) : const Color(0xFFC62828), fontSize: 11, fontWeight: FontWeight.w800)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 20),

                // Key Info Grid
                const Text('Personal & Academic Profile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _buildDossierField('Blood Group', s.bloodGroup),
                    _buildDossierField('Admission Date', s.admissionDate),
                    _buildDossierField('Transport Fleet', s.busRoute),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildDossierField('Parent / Guardian', s.parentName),
                    _buildDossierField('Primary Phone', s.parentPhone),
                    _buildDossierField('Emergency Contact', '+91 98999 11223'),
                  ],
                ),
                const SizedBox(height: 24),

                // Academic Performance
                const Text('Mid-Term Assessment Grades', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Advanced Mathematics', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('96 / 100 (Grade A+)', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF00B894))),
                        ],
                      ),
                      Divider(height: 16, color: Color(0xFFE2E8F0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Physics & Mechanics', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('92 / 100 (Grade A+)', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF00B894))),
                        ],
                      ),
                      Divider(height: 16, color: Color(0xFFE2E8F0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chemistry & Lab', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('89 / 100 (Grade A)', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0984E3))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📄 Generating Digital Marksheet for ${s.name}...')));
                        },
                        icon: const Icon(Icons.print_rounded, size: 18),
                        label: const Text('Download Marksheet PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C5CE7),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Message sent to ${s.parentPhone}')));
                      },
                      icon: const Icon(Icons.chat_rounded, color: Color(0xFF00B894), size: 18),
                      label: const Text('WhatsApp Parent', style: TextStyle(color: Color(0xFF334155))),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
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

  Widget _buildDossierField(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
        ],
      ),
    );
  }

  void _showQuickEnrollModal(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✨ Quick Student Admission Modal opened')),
    );
  }
}
