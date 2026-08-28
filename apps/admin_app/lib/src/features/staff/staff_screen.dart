import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherFullProfile {
  final String id;
  final String empId;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final String bloodGroup;
  final String dob;
  final String gender;
  final String joiningDate;
  final String experience;
  final String qualifications;
  final String aadhaarNo;
  final String address;

  // Class Teacher & Subjects
  final String classTeacherOf; // e.g. Class 10 - Section A
  final String roomNumber;
  final List<Map<String, String>> subjectsTaught;
  final int weeklyPeriods;

  // Salary & Payroll
  final double baseSalary;
  final double allowances;
  final double deductions;
  final double netSalary;
  final String payrollStatus;
  final String bankAccount;
  final List<Map<String, String>> payslipHistory;

  // Attendance
  final double attendancePct;
  final int totalDays;
  final int presentDays;
  final int leavesTaken;
  final int remainingLeaves;
  final String todayStatus;

  // Timetable
  final List<Map<String, String>> dailySchedule;
  final String rating;

  const TeacherFullProfile({
    required this.id,
    required this.empId,
    required this.name,
    required this.designation,
    required this.department,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.dob,
    required this.gender,
    required this.joiningDate,
    required this.experience,
    required this.qualifications,
    required this.aadhaarNo,
    required this.address,
    required this.classTeacherOf,
    required this.roomNumber,
    required this.subjectsTaught,
    required this.weeklyPeriods,
    required this.baseSalary,
    required this.allowances,
    required this.deductions,
    required this.netSalary,
    required this.payrollStatus,
    required this.bankAccount,
    required this.payslipHistory,
    required this.attendancePct,
    required this.totalDays,
    required this.presentDays,
    required this.leavesTaken,
    required this.remainingLeaves,
    required this.todayStatus,
    required this.dailySchedule,
    required this.rating,
  });
}

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _selectedDept = 'ALL';
  String _searchQuery = '';

  static const List<TeacherFullProfile> _mockTeachers = [
    TeacherFullProfile(
      id: 'tch_01',
      empId: 'EMP-2021-084',
      name: 'Dr. Priya Verma',
      designation: 'Senior Faculty & HOD Science',
      department: 'Science & Mathematics',
      email: 'priya.verma@school.edu',
      phone: '+91 98111 22334',
      bloodGroup: 'O+ (Positive)',
      dob: '12 November 1984',
      gender: 'Female',
      joiningDate: '15 June 2021',
      experience: '5 Years 2 Months at DPIS (14 Yrs Total)',
      qualifications: 'Ph.D in Applied Physics (DU), M.Sc Physics, B.Ed (Gold Medalist)',
      aadhaarNo: 'XXXX-XXXX-7721',
      address: 'B-402, Faculty Enclave, Mathura Road, New Delhi',
      classTeacherOf: 'Class 10 - Section A',
      roomNumber: 'Room 204 (Science Block)',
      subjectsTaught: [
        {'subject': 'Physics & Mechanics', 'classes': 'Class 10-A, Class 10-B, Class 12-A', 'periods': '16 Periods/wk'},
        {'subject': 'Advanced Mathematics', 'classes': 'Class 10-A, Class 11-Science', 'periods': '12 Periods/wk'},
      ],
      weeklyPeriods: 28,
      baseSalary: 65000,
      allowances: 8500,
      deductions: 4000,
      netSalary: 69500,
      payrollStatus: 'PAID (August 2026)',
      bankAccount: 'HDFC Bank (A/C: XXXX-8849)',
      payslipHistory: [
        {'month': 'August 2026', 'amount': '₹ 69,500', 'status': 'PAID (01-Sep)', 'ref': 'PAY_AUG_8849'},
        {'month': 'July 2026', 'amount': '₹ 69,500', 'status': 'PAID (01-Aug)', 'ref': 'PAY_JUL_8812'},
        {'month': 'June 2026', 'amount': '₹ 69,500', 'status': 'PAID (01-Jul)', 'ref': 'PAY_JUN_8741'},
      ],
      attendancePct: 97.6,
      totalDays: 84,
      presentDays: 82,
      leavesTaken: 2,
      remainingLeaves: 10,
      todayStatus: 'PRESENT IN SCHOOL',
      dailySchedule: [
        {'time': '08:30 - 09:15', 'task': 'Class 10-A Homeroom & Roll Call', 'room': 'Room 204', 'type': 'CLASS_TEACHER'},
        {'time': '09:15 - 10:00', 'task': 'Class 12-A Physics Dynamics', 'room': 'Room 302', 'type': 'TEACHING'},
        {'time': '10:30 - 11:15', 'task': 'Class 10-A Physics Lab (LIVE NOW)', 'room': 'Lab Block 2', 'type': 'LIVE'},
        {'time': '11:15 - 12:00', 'task': 'Class 10-B Advanced Mathematics', 'room': 'Room 205', 'type': 'TEACHING'},
        {'time': '01:30 - 02:15', 'task': 'Class 11-Science Mathematics Lab', 'room': 'Lab Block 3', 'type': 'TEACHING'},
      ],
      rating: '4.9 ★ (Outstanding)',
    ),
    TeacherFullProfile(
      id: 'tch_02',
      empId: 'EMP-2022-098',
      name: 'Prof. Alok Mukherjee',
      designation: 'Associate Professor & Chemistry Head',
      department: 'Science & Mathematics',
      email: 'alok.m@school.edu',
      phone: '+91 98222 33445',
      bloodGroup: 'B+ (Positive)',
      dob: '24 May 1982',
      gender: 'Male',
      joiningDate: '01 April 2022',
      experience: '4 Years 4 Months at DPIS (12 Yrs Total)',
      qualifications: 'M.Sc Organic Chemistry (IIT Roorkee), B.Ed, CSIR NET Qualified',
      aadhaarNo: 'XXXX-XXXX-3341',
      address: 'Flat 12, Teacher Colony, Sector 14, New Delhi',
      classTeacherOf: 'Class 10 - Section B',
      roomNumber: 'Room 205',
      subjectsTaught: [
        {'subject': 'Chemistry & Organic Labs', 'classes': 'Class 9-B, Class 10-B, Class 11-Science', 'periods': '18 Periods/wk'},
      ],
      weeklyPeriods: 26,
      baseSalary: 58000,
      allowances: 7500,
      deductions: 3500,
      netSalary: 62000,
      payrollStatus: 'PAID (August 2026)',
      bankAccount: 'ICICI Bank (A/C: XXXX-4412)',
      payslipHistory: [
        {'month': 'August 2026', 'amount': '₹ 62,000', 'status': 'PAID', 'ref': 'PAY_AUG_3311'},
      ],
      attendancePct: 95.2,
      totalDays: 84,
      presentDays: 80,
      leavesTaken: 4,
      remainingLeaves: 8,
      todayStatus: 'ON LEAVE (Medical - 2 Days)',
      dailySchedule: [
        {'time': '08:30 - 09:15', 'task': 'Class 10-B Attendance (Covered by Mrs. Emily)', 'room': 'Room 205', 'type': 'SUBSTITUTE'},
        {'time': '10:30 - 11:15', 'task': 'Class 10-A Physics Lab (Covered by Prof. Alok Substitute)', 'room': 'Lab 2', 'type': 'SUBSTITUTE'},
      ],
      rating: '4.8 ★ (Exemplary)',
    ),
    TeacherFullProfile(
      id: 'tch_03',
      empId: 'EMP-2020-045',
      name: 'Mrs. Sunita Rao',
      designation: 'HOD Languages & Humanities',
      department: 'Languages & Literature',
      email: 'sunita.rao@school.edu',
      phone: '+91 98333 44556',
      bloodGroup: 'A+ (Positive)',
      dob: '08 March 1980',
      gender: 'Female',
      joiningDate: '10 July 2020',
      experience: '6 Years 1 Month at DPIS (16 Yrs Total)',
      qualifications: 'M.A. English Literature (JNU), M.Phil, B.Ed',
      aadhaarNo: 'XXXX-XXXX-9901',
      address: 'House 55, Green Park Main, New Delhi',
      classTeacherOf: 'Class 9 - Section A',
      roomNumber: 'Room 108',
      subjectsTaught: [
        {'subject': 'English Literature & Drama', 'classes': 'Class 8-A, Class 9-A, Class 10-A', 'periods': '22 Periods/wk'},
      ],
      weeklyPeriods: 28,
      baseSalary: 62000,
      allowances: 8000,
      deductions: 3800,
      netSalary: 66200,
      payrollStatus: 'PAID (August 2026)',
      bankAccount: 'SBI (A/C: XXXX-9981)',
      payslipHistory: [],
      attendancePct: 98.8,
      totalDays: 84,
      presentDays: 83,
      leavesTaken: 1,
      remainingLeaves: 11,
      todayStatus: 'PRESENT IN SCHOOL',
      dailySchedule: [
        {'time': '08:30 - 09:15', 'task': 'Class 9-A Homeroom', 'room': 'Room 108', 'type': 'CLASS_TEACHER'},
        {'time': '10:30 - 11:15', 'task': 'Class 9-A Julius Caesar Drama', 'room': 'Room 108', 'type': 'TEACHING'},
      ],
      rating: '4.9 ★ (Outstanding)',
    ),
    TeacherFullProfile(
      id: 'tch_04',
      empId: 'EMP-2023-112',
      name: 'Mr. Rajesh Nambiar',
      designation: 'Faculty Lead - Commerce & Economics',
      department: 'Commerce & Economics',
      email: 'rajesh.n@school.edu',
      phone: '+91 98444 55667',
      bloodGroup: 'AB+ (Positive)',
      dob: '18 January 1986',
      gender: 'Male',
      joiningDate: '01 April 2023',
      experience: '3 Years 4 Months at DPIS (10 Yrs Total)',
      qualifications: 'M.Com, Chartered Financial Analyst (CFA Level 2), B.Ed',
      aadhaarNo: 'XXXX-XXXX-4419',
      address: 'Tower C, Express View Apartments, Noida',
      classTeacherOf: 'Class 12 - Section Commerce',
      roomNumber: 'Commerce Wing 2',
      subjectsTaught: [
        {'subject': 'Accountancy & Business Studies', 'classes': 'Class 11-C, Class 12-C', 'periods': '20 Periods/wk'},
        {'subject': 'Macro Economics', 'classes': 'Class 12-C', 'periods': '8 Periods/wk'},
      ],
      weeklyPeriods: 28,
      baseSalary: 55000,
      allowances: 7000,
      deductions: 3200,
      netSalary: 58800,
      payrollStatus: 'PAID (August 2026)',
      bankAccount: 'Axis Bank (A/C: XXXX-1192)',
      payslipHistory: [],
      attendancePct: 96.4,
      totalDays: 84,
      presentDays: 81,
      leavesTaken: 3,
      remainingLeaves: 9,
      todayStatus: 'PRESENT IN SCHOOL',
      dailySchedule: [
        {'time': '08:30 - 09:15', 'task': 'Class 12-C Homeroom', 'room': 'Commerce Wing 2', 'type': 'CLASS_TEACHER'},
        {'time': '10:30 - 11:15', 'task': 'Class 12-C Macro Economics', 'room': 'Commerce Wing 2', 'type': 'TEACHING'},
      ],
      rating: '4.7 ★ (Very Good)',
    ),
    TeacherFullProfile(
      id: 'tch_05',
      empId: 'EMP-2024-140',
      name: 'Ms. Ananya Sengupta',
      designation: 'Instructor - Computer Science & AI',
      department: 'Technology & CS',
      email: 'ananya.s@school.edu',
      phone: '+91 98555 66778',
      bloodGroup: 'B- (Negative)',
      dob: '02 October 1992',
      gender: 'Female',
      joiningDate: '10 January 2024',
      experience: '2 Years 7 Months at DPIS (6 Yrs Total)',
      qualifications: 'B.Tech in Computer Science (IIIT), M.Tech AI & Data Science',
      aadhaarNo: 'XXXX-XXXX-1102',
      address: 'Sector 62, Cyber City, Gurgaon',
      classTeacherOf: 'Class 11 - AI & Robotics Club Lead',
      roomNumber: 'AI Lab Block 1',
      subjectsTaught: [
        {'subject': 'Python Programming & AI Basics', 'classes': 'Class 10-A, Class 11-Science', 'periods': '16 Periods/wk'},
      ],
      weeklyPeriods: 24,
      baseSalary: 52000,
      allowances: 6500,
      deductions: 3000,
      netSalary: 55500,
      payrollStatus: 'PAID (August 2026)',
      bankAccount: 'HDFC Bank (A/C: XXXX-7711)',
      payslipHistory: [],
      attendancePct: 99.4,
      totalDays: 84,
      presentDays: 83,
      leavesTaken: 1,
      remainingLeaves: 11,
      todayStatus: 'PRESENT IN SCHOOL',
      dailySchedule: [
        {'time': '09:15 - 10:00', 'task': 'Class 10-A AI Python Lab', 'room': 'AI Lab 1', 'type': 'TEACHING'},
      ],
      rating: '5.0 ★ (Star Educator 🌟)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filteredTeachers = _mockTeachers.where((t) {
      final matchesDept = _selectedDept == 'ALL' || t.department.contains(_selectedDept) || (_selectedDept == 'Science & Math' && t.department.contains('Science'));
      final matchesSearch = t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.department.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.classTeacherOf.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.qualifications.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDept && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          _buildTopBar(context),
          const SizedBox(height: 20),

          // Department Filters & Search Row
          _buildFilterAndSearchBar(context),
          const SizedBox(height: 24),

          // Teacher Cards Grid
          _buildTeacherGrid(context, filteredTeachers, isDesktop),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
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
                'Faculty & Teachers Directory',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                '84 Active Teaching Staff • 360° Profile: Degrees, Salary, Daily Period Schedule & Class Teacher Allocations',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✨ Open Add New Faculty Modal')),
              );
            },
            icon: const Icon(Icons.person_add_rounded, size: 16),
            label: const Text('Add New Faculty'),
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
    );
  }

  Widget _buildFilterAndSearchBar(BuildContext context) {
    const depts = [
      {'label': 'All Faculty (84)', 'key': 'ALL'},
      {'label': 'Science & Math', 'key': 'Science & Math'},
      {'label': 'Languages', 'key': 'Languages'},
      {'label': 'Commerce & Eco', 'key': 'Commerce & Eco'},
      {'label': 'Technology & AI', 'key': 'Technology'},
    ];

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
              icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8)),
              hintText: 'Search teacher by Name, Degree, Subject, or Class Teacher of (e.g. Class 10-A, Ph.D, Physics)...',
              hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: depts.map((d) {
              final isSelected = _selectedDept == d['key'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(d['label']!),
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
                    if (selected) setState(() => _selectedDept = d['key']!);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherGrid(BuildContext context, List<TeacherFullProfile> teachers, bool isDesktop) {
    if (teachers.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: const Column(
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No faculty found matching your search.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: teachers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: crossAxisCount == 1 ? 1.4 : 1.18,
          ),
          itemBuilder: (context, index) {
            final t = teachers[index];
            return _buildTeacherCard(context, t);
          },
        );
      },
    );
  }

  Widget _buildTeacherCard(BuildContext context, TeacherFullProfile t) {
    final isOnLeave = t.todayStatus.contains('LEAVE');
    final statusColor = isOnLeave ? const Color(0xFFF39C12) : const Color(0xFF00B894);

    return InkWell(
      onTap: () => _openTeacher360Dossier(context, t),
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
            // Top Row: Avatar + Name + Rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                      child: Text(
                        t.name.split(' ').last[0],
                        style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.name,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.designation,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '🎓 ${t.qualifications.split(',').first}',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Text(
                    t.rating.split(' ').first,
                    style: const TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.w800, fontSize: 11),
                  ),
                ),
              ],
            ),

            // Class Teacher Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Row(
                children: [
                  const Icon(Icons.school_rounded, color: Color(0xFF6C5CE7), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Class Teacher of: ${t.classTeacherOf}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF334155)), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),

            // Salary & Joining Summary Strip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NET SALARY', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    Text('₹ ${t.netSalary.toInt()} / mo', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF00B894))),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('BLOOD GROUP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    Text(t.bloodGroup.split(' ').first, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFE84393))),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('EXPERIENCE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    Text(t.joiningDate.split(' ').last, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
                  ],
                ),
              ],
            ),

            // Footer Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 7, height: 7, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(t.todayStatus.split('(').first.trim(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor)),
                  ],
                ),
                const Text('View 360° Profile ➔', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- 360° TEACHER DOSSIER MODAL ---
  void _openTeacher360Dossier(BuildContext context, TeacherFullProfile t) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Teacher Dossier',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return _Teacher360DossierDialog(teacher: t);
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

class _Teacher360DossierDialog extends StatefulWidget {
  final TeacherFullProfile teacher;

  const _Teacher360DossierDialog({required this.teacher});

  @override
  State<_Teacher360DossierDialog> createState() => _Teacher360DossierDialogState();
}

class _Teacher360DossierDialogState extends State<_Teacher360DossierDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.teacher;
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
              _buildTopHeader(t),

              // Tab Bar Switcher
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
                    Tab(icon: Icon(Icons.badge_outlined, size: 18), text: '1. Degrees & Bio'),
                    Tab(icon: Icon(Icons.school_rounded, size: 18), text: '2. Class Teacher & Subjects'),
                    Tab(icon: Icon(Icons.calendar_month_rounded, size: 18), text: '3. Today\'s Schedule'),
                    Tab(icon: Icon(Icons.receipt_long_rounded, size: 18), text: '4. Salary & Payroll'),
                    Tab(icon: Icon(Icons.how_to_reg_rounded, size: 18), text: '5. Attendance & Leaves'),
                  ],
                ),
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDegreesAndBioTab(t),
                    _buildClassesAndSubjectsTab(t),
                    _buildScheduleTab(t),
                    _buildSalaryTab(t),
                    _buildAttendanceTab(t),
                  ],
                ),
              ),

              // Bottom Actions Bar
              _buildBottomActionBar(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(TeacherFullProfile t) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
            child: Text(
              t.name.split(' ').last[0],
              style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w900, fontSize: 24),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      t.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(t.empId, style: const TextStyle(color: Color(0xFF6C5CE7), fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(t.designation, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    Text('•  Class Teacher: ${t.classTeacherOf}', style: const TextStyle(fontSize: 12, color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700)),
                    const SizedBox(width: 12),
                    Text('•  ${t.rating}', style: const TextStyle(fontSize: 12, color: Color(0xFFD97706), fontWeight: FontWeight.w700)),
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

  // --- TAB 1: DEGREES, QUALIFICATIONS & BIO ---
  Widget _buildDegreesAndBioTab(TeacherFullProfile t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Educational Degrees & Academic Qualifications'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: const Color(0xFFFAF5FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE9D5FF))),
            child: Row(
              children: [
                const Icon(Icons.school_rounded, color: Color(0xFF6C5CE7), size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Certified Qualifications & Universities', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF581C87))),
                      const SizedBox(height: 4),
                      Text(t.qualifications, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1E293B))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Employment & Service Tenure'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Date of Joining School', 'val': t.joiningDate, 'icon': Icons.calendar_today_rounded},
            {'label': 'Total Experience', 'val': t.experience, 'icon': Icons.timeline_rounded},
            {'label': 'Department', 'val': t.department, 'icon': Icons.corporate_fare_rounded},
            {'label': 'Blood Group', 'val': t.bloodGroup, 'icon': Icons.bloodtype_rounded},
            {'label': 'Date of Birth (DOB)', 'val': t.dob, 'icon': Icons.cake_rounded},
            {'label': 'Government Aadhaar UID', 'val': t.aadhaarNo, 'icon': Icons.badge_rounded},
          ]),
          const SizedBox(height: 24),

          _buildSectionTitle('Official Contact & Residential Address'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Mobile Number', 'val': t.phone, 'icon': Icons.phone_rounded},
            {'label': 'Official Email', 'val': t.email, 'icon': Icons.email_rounded},
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Row(
              children: [
                const Icon(Icons.home_rounded, color: Color(0xFF64748B), size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(t.address, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155)))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2: CLASS TEACHER & SUBJECTS TAUGHT ---
  Widget _buildClassesAndSubjectsTab(TeacherFullProfile t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Class Teacher Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('OFFICIAL CLASS TEACHER IN-CHARGE', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(t.classTeacherOf, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text('Assigned Classroom: ${t.roomNumber} (42 Students)', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Text('CLASS IN-CHARGE 🎓', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Subject Teaching Allocations (Weekly Load: ${t.weeklyPeriods} Periods)'),
          const SizedBox(height: 14),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: t.subjectsTaught.length,
            itemBuilder: (context, index) {
              final sub = t.subjectsTaught[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.book_rounded, color: Color(0xFF6C5CE7), size: 22),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sub['subject']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                          const SizedBox(height: 2),
                          Text('Classes Taught: ${sub['classes']!}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                      child: Text(sub['periods']!, style: const TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- TAB 3: TODAY'S SCHEDULE & TIMETABLE ---
  Widget _buildScheduleTab(TeacherFullProfile t) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: t.dailySchedule.length,
      itemBuilder: (context, index) {
        final sch = t.dailySchedule[index];
        final isLive = sch['type'] == 'LIVE';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLive ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isLive ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: isLive ? const Color(0xFF00B894) : const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(8)),
                child: Text(sch['time']!, style: TextStyle(color: isLive ? Colors.white : const Color(0xFF334155), fontSize: 11, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sch['task']!, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: isLive ? const Color(0xFF14532D) : const Color(0xFF1E293B))),
                    const SizedBox(height: 2),
                    Text('Location: ${sch['room']!}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              if (isLive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF00B894), borderRadius: BorderRadius.circular(8)),
                  child: const Text('TEACHING NOW 🟢', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 4: SALARY & PAYROLL ---
  Widget _buildSalaryTab(TeacherFullProfile t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildSalaryCard('Basic Monthly Pay', '₹ ${t.baseSalary.toInt()}', 'Standard Scale', const Color(0xFF6C5CE7))),
              const SizedBox(width: 14),
              Expanded(child: _buildSalaryCard('Allowances (HRA/DA)', '+ ₹ ${t.allowances.toInt()}', 'Benefits Included', const Color(0xFF00B894))),
              const SizedBox(width: 14),
              Expanded(child: _buildSalaryCard('Deductions (PF/TDS)', '- ₹ ${t.deductions.toInt()}', 'Government PF', const Color(0xFFFF7675))),
            ],
          ),
          const SizedBox(height: 20),

          // Net Take Home Box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF00B894), Color(0xFF00CEC9)]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NET MONTHLY SALARY TAKE-HOME', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('₹ ${t.netSalary.toInt()} / Month', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text('Credited To: ${t.bankAccount}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Text(t.payrollStatus, style: const TextStyle(color: Color(0xFF00B894), fontWeight: FontWeight.w900, fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Salary Payslip Disbursal History'),
          const SizedBox(height: 14),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: t.payslipHistory.length,
            itemBuilder: (context, index) {
              final p = t.payslipHistory[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['month']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        Text('Ref: ${p['ref']!} • ${p['status']!}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                    Row(
                      children: [
                        Text(p['amount']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B))),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.download_rounded, color: Color(0xFF6C5CE7), size: 20),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📄 Downloading Official Payslip for ${p['month']}...')));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryCard(String title, String amount, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
          Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  // --- TAB 5: ATTENDANCE & LEAVES ---
  Widget _buildAttendanceTab(TeacherFullProfile t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFDCFCE7))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CUMULATIVE ATTENDANCE', style: TextStyle(fontSize: 10, color: Color(0xFF166534), fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('${t.attendancePct}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF15803D))),
                      Text('${t.presentDays} Days Present (Out of ${t.totalDays})', style: const TextStyle(fontSize: 11, color: Color(0xFF166534))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: const Color(0xFFFAF5FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE9D5FF))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('REMAINING LEAVE BALANCE', style: TextStyle(fontSize: 10, color: Color(0xFF581C87), fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('${t.remainingLeaves} Days', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF6C5CE7))),
                      Text('${t.leavesTaken} Leaves Availed this Session', style: const TextStyle(fontSize: 11, color: Color(0xFF6B21A8))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Biometric Punctuality & Punch Record'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: const Row(
              children: [
                Icon(Icons.fingerprint_rounded, color: Color(0xFF00B894), size: 28),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Morning Biometric In-Punch: 08:12 AM (On-Time 🟢)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                      SizedBox(height: 2),
                      Text('Gate 1 Main Faculty Scanner • Evening Out-Punch Scheduled: 03:30 PM', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(TeacherFullProfile t) {
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp chat opened with ${t.name} (${t.phone})')));
                },
                icon: const Icon(Icons.chat_rounded, color: Color(0xFF00B894), size: 18),
                label: const Text('WhatsApp Faculty', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📞 Calling ${t.name}...')));
                },
                icon: const Icon(Icons.phone_rounded, color: Color(0xFF0984E3), size: 18),
                label: const Text('Direct Call', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📄 Downloading Official 360° Faculty Dossier PDF for ${t.name}...')));
            },
            icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
            label: const Text('Download Faculty Dossier PDF'),
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

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)));
  }

  Widget _buildInfoGrid(List<Map<String, dynamic>> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 3.5,
          ),
          itemBuilder: (context, index) {
            final it = items[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(it['icon'] as IconData, size: 18, color: const Color(0xFF6C5CE7)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(it['label'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(it['val'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
