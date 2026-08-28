import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../onboarding/presentation/data_onboarding_hub_screen.dart';

class StudentFullProfile {
  final String id;
  final String grNo;
  final String rollNo;
  final String name;
  final String className;
  final String section;
  final String gender;
  final String dob;
  final String bloodGroup;
  final String house;
  final String admissionDate;
  final String classTeacher;
  final String category;
  
  // Parents
  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final String parentPhone;
  final String parentEmail;
  final String emergencyPhone;
  final String residentialAddress;

  // Attendance
  final double attendancePct;
  final int totalDays;
  final int presentDays;
  final int leaveDays;
  final int absentDays;

  // Fees
  final String feeStatus;
  final double annualFee;
  final double feePaidAmount;
  final double feeDueAmount;
  final String nextDueDate;
  final List<Map<String, String>> feeHistory;

  // Academics
  final double overallPercentage;
  final String classRank;
  final List<Map<String, dynamic>> subjectMarks;
  final String principalRemarks;

  // Documents
  final String aadhaarNumber;
  final bool aadhaarVerified;
  final String busRoute;
  final String busStop;

  const StudentFullProfile({
    required this.id,
    required this.grNo,
    required this.rollNo,
    required this.name,
    required this.className,
    required this.section,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.house,
    required this.admissionDate,
    required this.classTeacher,
    required this.category,
    required this.fatherName,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherOccupation,
    required this.parentPhone,
    required this.parentEmail,
    required this.emergencyPhone,
    required this.residentialAddress,
    required this.attendancePct,
    required this.totalDays,
    required this.presentDays,
    required this.leaveDays,
    required this.absentDays,
    required this.feeStatus,
    required this.annualFee,
    required this.feePaidAmount,
    required this.feeDueAmount,
    required this.nextDueDate,
    required this.feeHistory,
    required this.overallPercentage,
    required this.classRank,
    required this.subjectMarks,
    required this.principalRemarks,
    required this.aadhaarNumber,
    required this.aadhaarVerified,
    required this.busRoute,
    required this.busStop,
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

  static const List<StudentFullProfile> _students = [
    StudentFullProfile(
      id: 'stu_01',
      grNo: 'GR-2024-101',
      rollNo: '101',
      name: 'Aarav Sharma',
      className: 'Class 10',
      section: 'A',
      gender: 'Male',
      dob: '14 August 2010',
      bloodGroup: 'B+ (Positive)',
      house: 'Vanguard Blue House',
      admissionDate: '12 April 2022',
      classTeacher: 'Dr. Priya Verma',
      category: 'General',
      fatherName: 'Rajesh Sharma',
      fatherOccupation: 'Senior Software Architect',
      motherName: 'Sunita Sharma',
      motherOccupation: 'Assistant Professor',
      parentPhone: '+91 98111 22334',
      parentEmail: 'rajesh.sharma@gmail.com',
      emergencyPhone: '+91 98999 44321',
      residentialAddress: 'Flat 402, Royale Palm Heights, Sector 14, Mathura Road, New Delhi',
      attendancePct: 98.4,
      totalDays: 84,
      presentDays: 82,
      leaveDays: 2,
      absentDays: 0,
      feeStatus: 'PAID',
      annualFee: 54000,
      feePaidAmount: 54000,
      feeDueAmount: 0,
      nextDueDate: '15 Oct 2026 (Term 3)',
      feeHistory: [
        {'title': 'Term 1 Tuition & Annual Charges', 'amount': '₹ 27,000', 'date': '10 Apr 2026', 'status': 'PAID ONLINE', 'ref': 'TXN_8849102'},
        {'title': 'Term 2 Tuition & Science Lab Fee', 'amount': '₹ 27,000', 'date': '05 Aug 2026', 'status': 'PAID ONLINE', 'ref': 'TXN_9102834'},
      ],
      overallPercentage: 94.8,
      classRank: 'Rank 2 in Class 10-A',
      subjectMarks: [
        {'subject': 'Advanced Mathematics', 'marks': 98, 'max': 100, 'grade': 'A+', 'teacher': 'Dr. Priya Verma'},
        {'subject': 'Physics & Dynamics', 'marks': 94, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Chemistry & Lab Practicals', 'marks': 92, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Computer Science & AI', 'marks': 99, 'max': 100, 'grade': 'O (Outstanding)', 'teacher': 'Ms. Ananya Sengupta'},
        {'subject': 'English Literature & Grammar', 'marks': 89, 'max': 100, 'grade': 'A', 'teacher': 'Mrs. Sunita Rao'},
      ],
      principalRemarks: 'Aarav is an exceptionally diligent scholar with sharp analytical thinking and excellent classroom participation.',
      aadhaarNumber: 'XXXX-XXXX-4921',
      aadhaarVerified: true,
      busRoute: 'Route 04 (Civil Lines Express)',
      busStop: 'Sector 14 Main Gate (DL 01 PB 4488)',
    ),
    StudentFullProfile(
      id: 'stu_02',
      grNo: 'GR-2024-102',
      rollNo: '102',
      name: 'Ananya Iyer',
      className: 'Class 10',
      section: 'A',
      gender: 'Female',
      dob: '05 November 2010',
      bloodGroup: 'O+ (Positive)',
      house: 'Phoenix Red House',
      admissionDate: '15 June 2021',
      classTeacher: 'Dr. Priya Verma',
      category: 'General',
      fatherName: 'Venkatesh Iyer',
      fatherOccupation: 'Chartered Accountant',
      motherName: 'Lakshmi Iyer',
      motherOccupation: 'School Principal (Primary)',
      parentPhone: '+91 98222 33445',
      parentEmail: 'venkat.iyer@fintech.in',
      emergencyPhone: '+91 98777 66554',
      residentialAddress: 'B-12, Greenview Enclave, Civil Lines, New Delhi',
      attendancePct: 99.1,
      totalDays: 84,
      presentDays: 83,
      leaveDays: 1,
      absentDays: 0,
      feeStatus: 'PAID',
      annualFee: 54000,
      feePaidAmount: 54000,
      feeDueAmount: 0,
      nextDueDate: '15 Oct 2026',
      feeHistory: [
        {'title': 'Term 1 Tuition Fee', 'amount': '₹ 27,000', 'date': '08 Apr 2026', 'status': 'PAID NETBANKING', 'ref': 'TXN_7749102'},
        {'title': 'Term 2 Tuition Fee', 'amount': '₹ 27,000', 'date': '02 Aug 2026', 'status': 'PAID UPI', 'ref': 'TXN_8819203'},
      ],
      overallPercentage: 97.2,
      classRank: 'Rank 1 in Class 10-A (Topper 🏆)',
      subjectMarks: [
        {'subject': 'Advanced Mathematics', 'marks': 100, 'max': 100, 'grade': 'O (Centum)', 'teacher': 'Dr. Priya Verma'},
        {'subject': 'Physics & Dynamics', 'marks': 97, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Chemistry & Lab Practicals', 'marks': 96, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Computer Science & AI', 'marks': 98, 'max': 100, 'grade': 'A+', 'teacher': 'Ms. Ananya Sengupta'},
        {'subject': 'English Literature & Grammar', 'marks': 95, 'max': 100, 'grade': 'A+', 'teacher': 'Mrs. Sunita Rao'},
      ],
      principalRemarks: 'Exemplary academic topper with unmatched discipline. Recommended for National Olympiad representation.',
      aadhaarNumber: 'XXXX-XXXX-8834',
      aadhaarVerified: true,
      busRoute: 'Route 01 (North Campus)',
      busStop: 'Civil Lines Crossing (DL 01 PB 1102)',
    ),
    StudentFullProfile(
      id: 'stu_03',
      grNo: 'GR-2024-103',
      rollNo: '103',
      name: 'Rohan Mehta',
      className: 'Class 10',
      section: 'B',
      gender: 'Male',
      dob: '22 March 2010',
      bloodGroup: 'A+ (Positive)',
      house: 'Titan Green House',
      admissionDate: '10 July 2023',
      classTeacher: 'Prof. Alok Mukherjee',
      category: 'OBC',
      fatherName: 'Sanjay Mehta',
      fatherOccupation: 'Automobile Retailer',
      motherName: 'Kavita Mehta',
      motherOccupation: 'Home Maker',
      parentPhone: '+91 98333 44556',
      parentEmail: 'sanjay.mehta@autoindia.com',
      emergencyPhone: '+91 98444 88776',
      residentialAddress: 'House 88, Dayanand Colony, Lajpat Nagar, New Delhi',
      attendancePct: 92.5,
      totalDays: 84,
      presentDays: 77,
      leaveDays: 5,
      absentDays: 2,
      feeStatus: 'DUE',
      annualFee: 54000,
      feePaidAmount: 49500,
      feeDueAmount: 4500,
      nextDueDate: 'OVERDUE (Due Since 15 Aug)',
      feeHistory: [
        {'title': 'Term 1 Tuition & Transport', 'amount': '₹ 32,000', 'date': '12 Apr 2026', 'status': 'PAID CASH', 'ref': 'RCP_44921'},
        {'title': 'Term 2 Partial Payment', 'amount': '₹ 17,500', 'date': '10 Aug 2026', 'status': 'PAID UPI', 'ref': 'TXN_339102'},
      ],
      overallPercentage: 86.4,
      classRank: 'Rank 11 in Class 10-B',
      subjectMarks: [
        {'subject': 'Advanced Mathematics', 'marks': 84, 'max': 100, 'grade': 'A', 'teacher': 'Dr. Priya Verma'},
        {'subject': 'Physics & Dynamics', 'marks': 88, 'max': 100, 'grade': 'A', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Chemistry & Lab Practicals', 'marks': 82, 'max': 100, 'grade': 'B+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Computer Science & AI', 'marks': 92, 'max': 100, 'grade': 'A+', 'teacher': 'Ms. Ananya Sengupta'},
        {'subject': 'English Literature & Grammar', 'marks': 86, 'max': 100, 'grade': 'A', 'teacher': 'Mrs. Sunita Rao'},
      ],
      principalRemarks: 'Good potential in science and sports. Encouraged to clear fee balance and attend revision practicals.',
      aadhaarNumber: 'XXXX-XXXX-3312',
      aadhaarVerified: true,
      busRoute: 'Self Commute / Private Van',
      busStop: 'Parent Drop-off',
    ),
    StudentFullProfile(
      id: 'stu_04',
      grNo: 'GR-2024-104',
      rollNo: '104',
      name: 'Diya Patel',
      className: 'Class 9',
      section: 'A',
      gender: 'Female',
      dob: '18 September 2011',
      bloodGroup: 'AB+ (Positive)',
      house: 'Solaris Yellow House',
      admissionDate: '01 April 2024',
      classTeacher: 'Mrs. Sunita Rao',
      category: 'General',
      fatherName: 'Kirit Patel',
      fatherOccupation: 'Textile Exporter',
      motherName: 'Bhavna Patel',
      motherOccupation: 'Architect',
      parentPhone: '+91 98444 55667',
      parentEmail: 'kirit.patel@exports.in',
      emergencyPhone: '+91 98111 77665',
      residentialAddress: 'Villa 14, Lotus Boulevard, Sector 100, Noida',
      attendancePct: 96.0,
      totalDays: 84,
      presentDays: 80,
      leaveDays: 4,
      absentDays: 0,
      feeStatus: 'PAID',
      annualFee: 50000,
      feePaidAmount: 50000,
      feeDueAmount: 0,
      nextDueDate: '15 Oct 2026',
      feeHistory: [
        {'title': 'Term 1 & Term 2 Advance Settlement', 'amount': '₹ 50,000', 'date': '02 Apr 2026', 'status': 'PAID CHEQUE (HDFC)', 'ref': 'CHQ_884910'},
      ],
      overallPercentage: 91.5,
      classRank: 'Rank 4 in Class 9-A',
      subjectMarks: [
        {'subject': 'Mathematics Foundation', 'marks': 92, 'max': 100, 'grade': 'A+', 'teacher': 'Dr. Priya Verma'},
        {'subject': 'Integrated Science', 'marks': 90, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Social Studies & Civics', 'marks': 88, 'max': 100, 'grade': 'A', 'teacher': 'Mr. Rajesh Nambiar'},
        {'subject': 'English Literature', 'marks': 95, 'max': 100, 'grade': 'A+', 'teacher': 'Mrs. Sunita Rao'},
      ],
      principalRemarks: 'Creative mind with keen interest in arts and literary competitions.',
      aadhaarNumber: 'XXXX-XXXX-9102',
      aadhaarVerified: true,
      busRoute: 'Route 02 (West Sector)',
      busStop: 'Sector 100 Express Gate',
    ),
    StudentFullProfile(
      id: 'stu_05',
      grNo: 'GR-2024-105',
      rollNo: '105',
      name: 'Kabir Kapoor',
      className: 'Class 11',
      section: 'Science',
      gender: 'Male',
      dob: '30 January 2009',
      bloodGroup: 'O- (Rare Negative)',
      house: 'Vanguard Blue House',
      admissionDate: '20 August 2020',
      classTeacher: 'Prof. Alok Mukherjee',
      category: 'General',
      fatherName: 'Anil Kapoor',
      fatherOccupation: 'Civil Contractor',
      motherName: 'Ritu Kapoor',
      motherOccupation: 'Dentist',
      parentPhone: '+91 98555 66778',
      parentEmail: 'anil.kapoor@infra.co.in',
      emergencyPhone: '+91 98222 11998',
      residentialAddress: 'Penthouse 12, Tower B, Supertech Emerald, Sector 93A, Noida',
      attendancePct: 94.2,
      totalDays: 84,
      presentDays: 79,
      leaveDays: 3,
      absentDays: 2,
      feeStatus: 'DUE',
      annualFee: 62000,
      feePaidAmount: 54800,
      feeDueAmount: 7200,
      nextDueDate: 'OVERDUE (Due Since 20 Aug)',
      feeHistory: [
        {'title': 'Term 1 Lab & Science Tuition', 'amount': '₹ 31,000', 'date': '15 Apr 2026', 'status': 'PAID ONLINE', 'ref': 'TXN_110293'},
        {'title': 'Term 2 Installment 1', 'amount': '₹ 23,800', 'date': '12 Aug 2026', 'status': 'PAID UPI', 'ref': 'TXN_449210'},
      ],
      overallPercentage: 92.4,
      classRank: 'Rank 3 in Class 11 Science',
      subjectMarks: [
        {'subject': 'Physics Advanced', 'marks': 95, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Chemistry Advanced', 'marks': 91, 'max': 100, 'grade': 'A+', 'teacher': 'Prof. Alok Mukherjee'},
        {'subject': 'Mathematics & Calculus', 'marks': 94, 'max': 100, 'grade': 'A+', 'teacher': 'Dr. Priya Verma'},
        {'subject': 'Computer Science Python', 'marks': 96, 'max': 100, 'grade': 'A+', 'teacher': 'Ms. Ananya Sengupta'},
      ],
      principalRemarks: 'High aptitude in STEM and robotics. Outstanding team player in science exhibition.',
      aadhaarNumber: 'XXXX-XXXX-7721',
      aadhaarVerified: true,
      busRoute: 'Route 04 (Civil Lines Express)',
      busStop: 'Sector 93A Main Roundabout',
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
          s.parentPhone.contains(_searchQuery) ||
          s.fatherName.toLowerCase().contains(_searchQuery.toLowerCase());
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
                'Students & Scholars Hub',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Live Roster • 1,420 Enrolled Scholars • 360° Academic & Fee Dossier Matrix',
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('✨ Quick Admission Modal: Create student profile & auto-generate GR No')),
                  );
                },
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
                    hintText: 'Search student by Name, Roll No, GR-Number, Father\'s Name, or Phone...',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
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
                    tooltip: 'Table View',
                  ),
                  IconButton(
                    icon: Icon(Icons.grid_view_rounded, color: _isGridView ? const Color(0xFF6C5CE7) : const Color(0xFF94A3B8), size: 20),
                    onPressed: () => setState(() => _isGridView = true),
                    tooltip: 'Cards View',
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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

  Widget _buildStudentTable(BuildContext context, List<StudentFullProfile> students, bool isDesktop) {
    if (students.isEmpty) return _buildEmptyState();

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
                Expanded(flex: 2, child: Text('DOSSIER', textAlign: TextAlign.end, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
              ],
            ),
          ),
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

  Widget _buildStudentTableRow(BuildContext context, StudentFullProfile s) {
    final isPaid = s.feeStatus == 'PAID';

    return InkWell(
      onTap: () => _openAnimatedStudentDossier(context, s),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                    child: Text(s.name[0], style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 14)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                        Text('${s.grNo} • Adm: ${s.admissionDate}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.fatherName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF1E293B))),
                        Text(s.parentPhone, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Color(0xFF00B894)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Ping to ${s.fatherName} (${s.parentPhone})')));
                    },
                    tooltip: 'WhatsApp Parent',
                  ),
                ],
              ),
            ),
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
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.open_in_new_rounded, size: 16, color: Color(0xFF6C5CE7)),
                  onPressed: () => _openAnimatedStudentDossier(context, s),
                  tooltip: 'Open 360° Dossier',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCardGrid(BuildContext context, List<StudentFullProfile> students, bool isDesktop) {
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
              onTap: () => _openAnimatedStudentDossier(context, s),
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
                              Text('${s.className} - ${s.section} • Adm: ${s.admissionDate}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
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
                            Text('${s.attendancePct}% (${s.presentDays}d)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF00B894))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('PARENT PHONE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                            Text(s.parentPhone, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
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
                        Text('Father: ${s.fatherName}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        const Text('360° Dossier ➔', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
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

  // --- 5. ULTRA-RICH ANIMATED 360° STUDENT DOSSIER MODAL ---
  void _openAnimatedStudentDossier(BuildContext context, StudentFullProfile s) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Student Dossier',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return _StudentDossierModal(student: s);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------
// FULL 360° STUDENT DOSSIER COMPONENT WITH 5 TABS
// ----------------------------------------------------
class _StudentDossierModal extends StatefulWidget {
  final StudentFullProfile student;

  const _StudentDossierModal({required this.student});

  @override
  State<_StudentDossierModal> createState() => _StudentDossierModalState();
}

class _StudentDossierModalState extends State<_StudentDossierModal> with SingleTickerProviderStateMixin {
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
    final s = widget.student;
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
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Dossier Header
              _buildTopHeader(s),

              // Tab Bar Switcher
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  border: Border(
                    top: BorderSide(color: Color(0xFFE2E8F0)),
                    bottom: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
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
                    Tab(icon: Icon(Icons.badge_outlined, size: 18), text: '1. Admission & Bio'),
                    Tab(icon: Icon(Icons.family_restroom_rounded, size: 18), text: '2. Parents & Contact'),
                    Tab(icon: Icon(Icons.receipt_long_rounded, size: 18), text: '3. Fees Ledger'),
                    Tab(icon: Icon(Icons.assessment_rounded, size: 18), text: '4. Marksheet & Grades'),
                    Tab(icon: Icon(Icons.verified_user_rounded, size: 18), text: '5. KYC & Aadhaar Vault'),
                  ],
                ),
              ),

              // Tab Content Area
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAdmissionTab(s),
                    _buildParentsTab(s),
                    _buildFeesTab(s),
                    _buildAcademicsTab(s),
                    _buildKycAadhaarTab(s),
                  ],
                ),
              ),

              // Bottom Actions Bar
              _buildBottomActionBar(s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(StudentFullProfile s) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        children: [
          // Student Avatar with Online Badge
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF6C5CE7).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Center(
                  child: Text(
                    s.name[0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B894),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),

          // Student Identity Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      s.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: -0.5),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${s.className} - Section ${s.section}',
                        style: const TextStyle(color: Color(0xFF6C5CE7), fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Roll #${s.rollNo}',
                        style: const TextStyle(color: Color(0xFF475569), fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('GR Number: ${s.grNo}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    const SizedBox(width: 14),
                    Text('•  Class Teacher: ${s.classTeacher}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    const SizedBox(width: 14),
                    Text('•  House: ${s.house}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
          ),

          // Close Icon
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8), size: 24),
          ),
        ],
      ),
    );
  }

  // --- TAB 1: ADMISSION & BIO ---
  Widget _buildAdmissionTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Academic Enrolment & School Metadata'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Admission Date', 'val': s.admissionDate, 'icon': Icons.calendar_today_rounded},
            {'label': 'General Register (GR)', 'val': s.grNo, 'icon': Icons.receipt_rounded},
            {'label': 'Current Grade & Section', 'val': '${s.className} (Section ${s.section})', 'icon': Icons.school_rounded},
            {'label': 'Class Teacher', 'val': s.classTeacher, 'icon': Icons.person_rounded},
            {'label': 'Assigned House', 'val': s.house, 'icon': Icons.flag_rounded},
            {'label': 'Student Category', 'val': s.category, 'icon': Icons.category_rounded},
          ]),
          const SizedBox(height: 24),

          _buildSectionTitle('Personal & Biological Details'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Date of Birth (DOB)', 'val': s.dob, 'icon': Icons.cake_rounded},
            {'label': 'Gender', 'val': s.gender, 'icon': Icons.wc_rounded},
            {'label': 'Blood Group', 'val': s.bloodGroup, 'icon': Icons.bloodtype_rounded},
            {'label': 'Aadhaar UID', 'val': s.aadhaarNumber, 'icon': Icons.credit_card_rounded},
          ]),
          const SizedBox(height: 24),

          _buildSectionTitle('Campus Transport Details'),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF39C12).withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.directions_bus_rounded, color: Color(0xFFF39C12), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.busRoute, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text('Assigned Boarding Stop: ${s.busStop}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                  child: const Text('GPS PASS ACTIVE', style: TextStyle(color: Color(0xFF00B894), fontSize: 11, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2: PARENTS & CONTACT ---
  Widget _buildParentsTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Father / Guardian Details'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Father\'s Full Name', 'val': s.fatherName, 'icon': Icons.person_rounded},
            {'label': 'Occupation & Designation', 'val': s.fatherOccupation, 'icon': Icons.work_rounded},
            {'label': 'Primary Mobile Number', 'val': s.parentPhone, 'icon': Icons.phone_rounded},
            {'label': 'Email ID', 'val': s.parentEmail, 'icon': Icons.email_rounded},
          ]),
          const SizedBox(height: 24),

          _buildSectionTitle('Mother\'s Details'),
          const SizedBox(height: 14),
          _buildInfoGrid([
            {'label': 'Mother\'s Full Name', 'val': s.motherName, 'icon': Icons.person_outline_rounded},
            {'label': 'Occupation', 'val': s.motherOccupation, 'icon': Icons.work_outline_rounded},
            {'label': 'Alternate Emergency Contact', 'val': s.emergencyPhone, 'icon': Icons.emergency_rounded},
            {'label': 'SMS Alert Status', 'val': 'Subscribed & Active', 'icon': Icons.sms_rounded},
          ]),
          const SizedBox(height: 24),

          _buildSectionTitle('Registered Residential Address'),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.home_rounded, color: Color(0xFF6C5CE7), size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    s.residentialAddress,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF334155), fontWeight: FontWeight.w600, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 3: FEES LEDGER ---
  Widget _buildFeesTab(StudentFullProfile s) {
    final isPaid = s.feeStatus == 'PAID';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Summary Row
          Row(
            children: [
              Expanded(
                child: _buildFeeMetricCard('Annual Fee Structure', '₹ ${s.annualFee.toInt()}', 'All Terms Included', const Color(0xFF6C5CE7)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFeeMetricCard('Total Paid Amount', '₹ ${s.feePaidAmount.toInt()}', 'Receipts Generated', const Color(0xFF00B894)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFeeMetricCard(
                  'Pending Fee Balance',
                  isPaid ? '₹ 0 (Cleared)' : '₹ ${s.feeDueAmount.toInt()}',
                  s.nextDueDate,
                  isPaid ? const Color(0xFF00B894) : const Color(0xFFFF7675),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Fee Payment Receipts & Installment History'),
          const SizedBox(height: 14),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: s.feeHistory.length,
            itemBuilder: (context, index) {
              final item = s.feeHistory[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFF00B894).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.check_circle_rounded, color: Color(0xFF00B894), size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                          const SizedBox(height: 2),
                          Text('Ref: ${item['ref']} • Date: ${item['date']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item['amount']!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B))),
                        Text(item['status']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF00B894))),
                      ],
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.download_rounded, color: Color(0xFF6C5CE7), size: 20),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📄 Downloading Official Receipt ${item['ref']}...')));
                      },
                      tooltip: 'Download Receipt PDF',
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

  Widget _buildFeeMetricCard(String title, String amount, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 6),
          Text(amount, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color, letterSpacing: -0.5)),
          const SizedBox(height: 2),
          Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // --- TAB 4: MARKSHEET & ACADEMICS ---
  Widget _buildAcademicsTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Overall Rank Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: const Color(0xFF6C5CE7).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mid-Term Summative Assessment (2026)', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('${s.overallPercentage}% Overall Grade', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Text(s.classRank, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('Subject-wise Performance Breakdown'),
          const SizedBox(height: 14),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: s.subjectMarks.map((sub) {
                final pct = (sub['marks'] as int) / (sub['max'] as int);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sub['subject'] as String, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                            Text('Faculty: ${sub['teacher']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${sub['marks']} / ${sub['max']}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF00B894))),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: SizedBox(
                                height: 5,
                                child: LinearProgressIndicator(
                                  value: pct,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFF00B894)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(sub['grade'] as String, style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 12)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Principal Remarks Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFFAF5FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE9D5FF))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote_rounded, color: Color(0xFF6C5CE7), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Principal & Faculty Assessment Remarks', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF581C87))),
                      const SizedBox(height: 4),
                      Text(s.principalRemarks, style: const TextStyle(fontSize: 12, color: Color(0xFF6B21A8), height: 1.4)),
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

  // --- TAB 5: KYC & AADHAAR VAULT ---
  Widget _buildKycAadhaarTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Official Government KYC & Documents Vault'),
          const SizedBox(height: 14),

          // Aadhaar Card Visual Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF334155)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 14, offset: const Offset(0, 6)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.fingerprint_rounded, color: Colors.white, size: 28),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('GOVERNMENT OF INDIA', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            Text('Aadhaar Identification Card', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF00B894), borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          Icon(Icons.verified_rounded, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text('VERIFIED OCR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Center(child: Icon(Icons.person_rounded, color: Colors.white54, size: 32)),
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('DOB: ${s.dob} • Gender: ${s.gender}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                        const SizedBox(height: 8),
                        Text(s.aadhaarNumber, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 3)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Additional Uploaded Documents Grid
          _buildSectionTitle('Verified Document Attachments'),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _buildDocCard('Birth Certificate', 'Verified (Municipal Corp)', Icons.description_rounded, const Color(0xFF00B894))),
              const SizedBox(width: 12),
              Expanded(child: _buildDocCard('Transfer Certificate (TC)', 'Verified from Previous School', Icons.assignment_turned_in_rounded, const Color(0xFF0984E3))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDocCard('Immunization / Medical Record', 'Blood Group: ${s.bloodGroup}', Icons.medical_services_rounded, const Color(0xFFE84393))),
              const SizedBox(width: 12),
              Expanded(child: _buildDocCard('Address Proof (Utility Bill)', 'Electricity Bill Verified', Icons.home_work_rounded, const Color(0xFFF39C12))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(String title, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF1E293B))),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: Color(0xFF00B894), size: 16),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(StudentFullProfile s) {
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('💬 WhatsApp Ping sent to ${s.parentPhone}')));
                },
                icon: const Icon(Icons.chat_rounded, color: Color(0xFF00B894), size: 18),
                label: const Text('WhatsApp Parent', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📞 Calling Father ${s.fatherName} (${s.parentPhone})...')));
                },
                icon: const Icon(Icons.phone_rounded, color: Color(0xFF0984E3), size: 18),
                label: const Text('Call Father', style: TextStyle(color: Color(0xFF334155), fontWeight: FontWeight.w700)),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('📄 Generating 360° Complete Dossier PDF for ${s.name}...')));
            },
            icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
            label: const Text('Download 360° Dossier PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
    );
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
