import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamPaperSchedule {
  final String id;
  final String date;
  final String day;
  final String shift;
  final String subject;
  final String subjectCode;
  final String targetClasses;
  final int totalStudents;
  final String paperSetter;
  final String setterPhone;
  final String moderationStatus;
  final String printStatus;
  final int maxTheoryMarks;
  final int maxInternalMarks;
  final String assignedHall;
  final String leadInvigilator;
  final String evaluator;
  final String evalDeadline;
  final int evaluatedCount;

  const ExamPaperSchedule({
    required this.id,
    required this.date,
    required this.day,
    required this.shift,
    required this.subject,
    required this.subjectCode,
    required this.targetClasses,
    required this.totalStudents,
    required this.paperSetter,
    required this.setterPhone,
    required this.moderationStatus,
    required this.printStatus,
    required this.maxTheoryMarks,
    required this.maxInternalMarks,
    required this.assignedHall,
    required this.leadInvigilator,
    required this.evaluator,
    required this.evalDeadline,
    required this.evaluatedCount,
  });
}

class ExamsListScreen extends ConsumerStatefulWidget {
  const ExamsListScreen({super.key});

  @override
  ConsumerState<ExamsListScreen> createState() => _ExamsListScreenState();
}

class _ExamsListScreenState extends ConsumerState<ExamsListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedClassFilter = 'ALL';
  String _searchQuery = '';

  static const List<ExamPaperSchedule> _examPapers = [
    ExamPaperSchedule(
      id: 'ex_phy_10',
      date: '15 Sep 2026',
      day: 'Monday',
      shift: '09:00 AM - 12:00 PM (Morning)',
      subject: 'Physics & Dynamics',
      subjectCode: 'PHY-101',
      targetClasses: 'Class 10-A, Class 10-B, Class 10-C',
      totalStudents: 126,
      paperSetter: 'Dr. Priya Verma (HOD Science)',
      setterPhone: '+91 98111 22334',
      moderationStatus: 'APPROVED & SEALED 🔒',
      printStatus: '135 Copies Printed & Stored in Locker A',
      maxTheoryMarks: 80,
      maxInternalMarks: 20,
      assignedHall: 'Auditorium Hall A (Desks 1-126)',
      leadInvigilator: 'Prof. Alok Mukherjee',
      evaluator: 'Dr. Priya Verma',
      evalDeadline: '20 Sep 2026',
      evaluatedCount: 120,
    ),
    ExamPaperSchedule(
      id: 'ex_math_10',
      date: '17 Sep 2026',
      day: 'Wednesday',
      shift: '09:00 AM - 12:00 PM (Morning)',
      subject: 'Advanced Mathematics',
      subjectCode: 'MTH-102',
      targetClasses: 'Class 10-A, Class 10-B, Class 10-C',
      totalStudents: 126,
      paperSetter: 'Dr. Priya Verma & Mr. Vikramaditya',
      setterPhone: '+91 98111 22334',
      moderationStatus: 'APPROVED & SEALED 🔒',
      printStatus: '135 Copies Ready',
      maxTheoryMarks: 80,
      maxInternalMarks: 20,
      assignedHall: 'Auditorium Hall A',
      leadInvigilator: 'Mrs. Sunita Rao',
      evaluator: 'Dr. Priya Verma',
      evalDeadline: '22 Sep 2026',
      evaluatedCount: 85,
    ),
    ExamPaperSchedule(
      id: 'ex_chem_11',
      date: '18 Sep 2026',
      day: 'Thursday',
      shift: '09:00 AM - 12:00 PM (Morning)',
      subject: 'Organic & Inorganic Chemistry',
      subjectCode: 'CHM-201',
      targetClasses: 'Class 11 - Science (PCM/B)',
      totalStudents: 78,
      paperSetter: 'Prof. Alok Mukherjee',
      setterPhone: '+91 98222 33445',
      moderationStatus: 'MODERATION IN PROGRESS',
      printStatus: 'Proof Reading Pending',
      maxTheoryMarks: 70,
      maxInternalMarks: 30,
      assignedHall: 'Science Wing Room 204 & 205',
      leadInvigilator: 'Mr. Rajesh Nambiar',
      evaluator: 'Prof. Alok Mukherjee',
      evalDeadline: '24 Sep 2026',
      evaluatedCount: 0,
    ),
    ExamPaperSchedule(
      id: 'ex_eng_all',
      date: '21 Sep 2026',
      day: 'Monday',
      shift: '09:00 AM - 12:00 PM (Morning)',
      subject: 'English Core & Literature',
      subjectCode: 'ENG-101',
      targetClasses: 'Class 9, 10, 11, 12 (All Streams)',
      totalStudents: 340,
      paperSetter: 'Mrs. Sunita Rao (HOD Languages)',
      setterPhone: '+91 98333 44556',
      moderationStatus: 'APPROVED & SEALED 🔒',
      printStatus: '360 Copies Printed',
      maxTheoryMarks: 80,
      maxInternalMarks: 20,
      assignedHall: 'Main Hall A + Library Hall B',
      leadInvigilator: 'Dr. Priya Verma',
      evaluator: 'Mrs. Sunita Rao & Team',
      evalDeadline: '28 Sep 2026',
      evaluatedCount: 0,
    ),
    ExamPaperSchedule(
      id: 'ex_eco_12',
      date: '23 Sep 2026',
      day: 'Wednesday',
      shift: '09:00 AM - 12:00 PM (Morning)',
      subject: 'Macro Economics & Banking',
      subjectCode: 'ECO-301',
      targetClasses: 'Class 12 - Commerce',
      totalStudents: 42,
      paperSetter: 'Mr. Rajesh Nambiar (CFA, M.Com)',
      setterPhone: '+91 98444 55667',
      moderationStatus: 'APPROVED & SEALED 🔒',
      printStatus: '50 Copies Printed',
      maxTheoryMarks: 80,
      maxInternalMarks: 20,
      assignedHall: 'Commerce Wing Room 301',
      leadInvigilator: 'Ms. Ananya Sengupta',
      evaluator: 'Mr. Rajesh Nambiar',
      evalDeadline: '30 Sep 2026',
      evaluatedCount: 0,
    ),
    ExamPaperSchedule(
      id: 'ex_ai_10',
      date: '25 Sep 2026',
      day: 'Friday',
      shift: '01:30 PM - 03:30 PM (Afternoon)',
      subject: 'Artificial Intelligence & Python Practical',
      subjectCode: 'AI-104',
      targetClasses: 'Class 10-A, 10-B',
      totalStudents: 82,
      paperSetter: 'Ms. Ananya Sengupta (M.Tech AI)',
      setterPhone: '+91 98555 66778',
      moderationStatus: 'APPROVED & SEALED 🔒',
      printStatus: 'Lab Setup & Code Tests Configured',
      maxTheoryMarks: 50,
      maxInternalMarks: 50,
      assignedHall: 'Computer & AI Lab 1 & 2',
      leadInvigilator: 'Ms. Ananya Sengupta',
      evaluator: 'Ms. Ananya Sengupta',
      evalDeadline: '29 Sep 2026',
      evaluatedCount: 0,
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

    final filteredPapers = _examPapers.where((p) {
      final matchesClass = _selectedClassFilter == 'ALL' || p.targetClasses.contains(_selectedClassFilter);
      final matchesSearch = p.subject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.paperSetter.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.subjectCode.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.assignedHall.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesClass && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header & Summary Dials
          _buildExamOverviewHeader(context),
          const SizedBox(height: 20),

          // Search & Filter Row
          _buildFilterAndSearchRow(context),
          const SizedBox(height: 20),

          // Master Tabs (Date Sheet, Seating Plan, Invigilation, Evaluation)
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
                    Tab(icon: Icon(Icons.date_range_rounded, size: 18), text: '1. Date Sheet & Paper Setters'),
                    Tab(icon: Icon(Icons.chair_alt_rounded, size: 18), text: '2. Seating Plan & Halls (420 Desks)'),
                    Tab(icon: Icon(Icons.badge_rounded, size: 18), text: '3. Invigilation Duty Roster'),
                    Tab(icon: Icon(Icons.grading_rounded, size: 18), text: '4. Marks Entry & Report Cards'),
                  ],
                ),
                SizedBox(
                  height: 620,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDateSheetTab(context, filteredPapers),
                      _buildSeatingPlanTab(context),
                      _buildInvigilationRosterTab(context),
                      _buildEvaluationTab(context, filteredPapers),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Bottom Action Hub
          _buildBottomActionHub(context),
        ],
      ),
    );
  }

  Widget _buildExamOverviewHeader(BuildContext context) {
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
                  Row(
                    children: [
                      Text(
                        'Examination Master & Conduct Controller',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: -0.5),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Active Series: CBSE Mid-Term & Half-Yearly Board Assessments (Sep 15 - Sep 28, 2026)',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showSchedulePaperModal(context);
                    },
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Schedule Subject Paper'),
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

          // 4 Metric Chips
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
                  _buildMetricTile('14 Subject Papers', 'Datesheet Finalized', Icons.assignment_rounded, const Color(0xFF6C5CE7)),
                  _buildMetricTile('8 Paper Setters', 'Faculty In-Charge', Icons.person_pin_rounded, const Color(0xFF00B894)),
                  _buildMetricTile('420 Allotted Desks', 'Across 3 Halls', Icons.chair_rounded, const Color(0xFF0984E3)),
                  _buildMetricTile('100% Sealed & Printed', 'Locker Vault Secured 🔒', Icons.lock_clock_rounded, const Color(0xFFE84393)),
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

  Widget _buildFilterAndSearchRow(BuildContext context) {
    const classFilters = ['ALL', 'Class 10', 'Class 11', 'Class 12', 'Class 9'];

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
              hintText: 'Search by Subject Name (Physics, Math), Paper Setter (Dr. Priya), Code, or Exam Hall...',
              hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: classFilters.map((cf) {
              final isSelected = _selectedClassFilter == cf;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cf == 'ALL' ? 'All Classes (340 Scholars)' : cf),
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
                    if (sel) setState(() => _selectedClassFilter = cf);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- TAB 1: DATE SHEET & PAPER SETTER MATRIX ---
  Widget _buildDateSheetTab(BuildContext context, List<ExamPaperSchedule> papers) {
    if (papers.isEmpty) {
      return const Center(child: Text('No exam papers found. Click + Schedule Subject Paper.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: papers.length,
      itemBuilder: (context, index) {
        final p = papers[index];

        return Container(
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
              // Row 1: Date + Day + Subject + Code
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
                          '${p.date} (${p.day})',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        p.subject,
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(6)),
                        child: Text(p.subjectCode, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: p.moderationStatus.contains('SEALED') ? const Color(0xFF00B894).withOpacity(0.12) : const Color(0xFFF39C12).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.moderationStatus,
                      style: TextStyle(
                        color: p.moderationStatus.contains('SEALED') ? const Color(0xFF00B894) : const Color(0xFFD35400),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: Target Classes + Shift + Total Marks
              Row(
                children: [
                  const Icon(Icons.school_rounded, color: Color(0xFF64748B), size: 16),
                  const SizedBox(width: 6),
                  Text('Target: ${p.targetClasses} (${p.totalStudents} Scholars)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time_rounded, color: Color(0xFF64748B), size: 16),
                  const SizedBox(width: 6),
                  Text(p.shift, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(width: 16),
                  const Icon(Icons.score_rounded, color: Color(0xFF64748B), size: 16),
                  const SizedBox(width: 6),
                  Text('Marks: ${p.maxTheoryMarks} Theory + ${p.maxInternalMarks} Internal', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
                ],
              ),
              const SizedBox(height: 10),

              // Row 3: Assigned Paper Setter & Printing status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.edit_note_rounded, color: Color(0xFF6C5CE7), size: 18),
                        const SizedBox(width: 8),
                        Text('Assigned Paper Setter: ', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        Text('${p.paperSetter} (${p.setterPhone})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.print_rounded, color: Color(0xFF00B894), size: 16),
                        const SizedBox(width: 6),
                        Text(p.printStatus, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF00B894))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 2: SEATING PLAN & HALL ALLOTMENTS ---
  Widget _buildSeatingPlanTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Automated Anti-Copying Seating Layouts (420 Total Exam Desks)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
          const SizedBox(height: 14),

          _buildHallCard('Main Auditorium Hall A', '120 Desks Allotted', 'Class 10-A (Roll 101-142) & Class 12-A (Alternate Seating)', 'Lead Invigilator: Prof. Alok Mukherjee + 2 Assistant Staff', 'Desks 001 - 120 (Seating Grid 10x12)'),
          const SizedBox(height: 14),
          _buildHallCard('Library Wing Hall B', '80 Desks Allotted', 'Class 9-A & Class 11-Science (Odd/Even Desks)', 'Lead Invigilator: Mrs. Sunita Rao + 1 Assistant Staff', 'Desks 121 - 200 (Seating Grid 8x10)'),
          const SizedBox(height: 14),
          _buildHallCard('Science Block Room 204 & 205', '80 Desks Allotted', 'Class 10-B & Class 10-C', 'Lead Invigilator: Mr. Rajesh Nambiar', 'Desks 201 - 280 (40 Desks Per Room)'),
        ],
      ),
    );
  }

  Widget _buildHallCard(String hallName, String capacity, String classes, String staff, String grid) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hallName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(capacity, style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Allotted Students: $classes', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
          const SizedBox(height: 4),
          Text('👨‍🏫 $staff', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 4),
          Text('📍 $grid', style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- TAB 3: INVIGILATION DUTY ROSTER ---
  Widget _buildInvigilationRosterTab(BuildContext context) {
    const roster = [
      {'date': '15 Sep (Mon)', 'subject': 'Physics (Class 10)', 'hall': 'Auditorium Hall A', 'lead': 'Prof. Alok Mukherjee', 'asst': 'Mrs. Sunita Rao', 'time': '08:15 AM Reporting', 'status': 'CONFIRMED 🟢'},
      {'date': '17 Sep (Wed)', 'subject': 'Mathematics (Class 10)', 'hall': 'Auditorium Hall A', 'lead': 'Mrs. Sunita Rao', 'asst': 'Mr. Rajesh Nambiar', 'time': '08:15 AM Reporting', 'status': 'CONFIRMED 🟢'},
      {'date': '18 Sep (Thu)', 'subject': 'Chemistry (Class 11)', 'hall': 'Room 204 & 205', 'lead': 'Mr. Rajesh Nambiar', 'asst': 'Ms. Ananya Sengupta', 'time': '08:15 AM Reporting', 'status': 'CONFIRMED 🟢'},
      {'date': '21 Sep (Mon)', 'subject': 'English Core (All Classes)', 'hall': 'Hall A + Hall B', 'lead': 'Dr. Priya Verma', 'asst': 'Prof. Alok + 4 Staff', 'time': '08:00 AM Reporting', 'status': 'CONFIRMED 🟢'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: roster.length,
      itemBuilder: (context, index) {
        final r = roster[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.assignment_ind_rounded, color: Color(0xFF6C5CE7), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${r['date']!} • ${r['subject']!}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                    Text('Location: ${r['hall']!} • Lead: ${r['lead']!} • Asst: ${r['asst']!}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                child: Text(r['status']!, style: const TextStyle(color: Color(0xFF00B894), fontSize: 10, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 4: MARKS ENTRY & EVALUATION ---
  Widget _buildEvaluationTab(BuildContext context, List<ExamPaperSchedule> papers) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: papers.length,
      itemBuilder: (context, index) {
        final p = papers[index];
        final evalPct = (p.evaluatedCount / p.totalStudents) * 100;

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${p.subject} (${p.targetClasses})', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF1E293B))),
                  Text('Evaluator: ${p.evaluator}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Evaluation Progress: ${p.evaluatedCount} / ${p.totalStudents} Papers Checked (${evalPct.toStringAsFixed(1)}%)', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  Text('Deadline: ${p.evalDeadline}', style: const TextStyle(fontSize: 11, color: Color(0xFFD63031), fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: evalPct / 100,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionHub(BuildContext context) {
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('🖨️ Generating 340 Student Admit Cards & Hall Tickets PDF...')));
                },
                icon: const Icon(Icons.print_rounded, size: 18, color: Color(0xFF0984E3)),
                label: const Text('Print Student Hall Tickets', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📥 Exporting CBSE Tabulation Register Master Excel...')));
                },
                icon: const Icon(Icons.file_download_rounded, size: 18, color: Color(0xFF00B894)),
                label: const Text('Export CBSE Tabulation Excel', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('📢 Broadcasted Full Datesheet & Rules on WhatsApp to 340 Parents!')));
            },
            icon: const Icon(Icons.campaign_rounded, size: 18),
            label: const Text('Broadcast Datesheet on WhatsApp'),
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

  // --- MODAL TO SCHEDULE NEW EXAM PAPER ---
  void _showSchedulePaperModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Schedule New Subject Exam Paper', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B))),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: 'Subject Name (e.g. Chemistry & Organic Lab)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                const TextField(decoration: InputDecoration(labelText: 'Target Classes (e.g. Class 10-A, 10-B)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                const TextField(decoration: InputDecoration(labelText: 'Assigned Paper Setter Faculty (e.g. Dr. Priya Verma)', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Exam Date', border: OutlineInputBorder()))),
                    SizedBox(width: 12),
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Max Marks (80)', border: OutlineInputBorder()))),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✨ Exam Paper Scheduled & Assigned to Faculty!')));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7), foregroundColor: Colors.white),
                      child: const Text('Save & Schedule Paper'),
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
