import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/staff_models.dart';
import 'presentation/widgets/staff_header.dart';
import 'presentation/widgets/teacher_card.dart';
import 'presentation/dialogs/teacher_360_modal.dart';
import 'presentation/dialogs/add_staff_modal.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _selectedDept = 'ALL';
  String _searchQuery = '';
  late List<TeacherProfile> _teachers;

  @override
  void initState() {
    super.initState();
    _teachers = StaffMockData.getTeachers();
  }

  void _openAddStaffModal() {
    showDialog(
      context: context,
      builder: (_) => AddStaffModal(
        onSave: (data) {
          setState(() {
            _teachers.insert(
              0,
              TeacherProfile(
                id: 'tch_${DateTime.now().millisecondsSinceEpoch}',
                empId: 'EMP-2026-${_teachers.length + 100}',
                name: data['name'] ?? 'Faculty Member',
                designation: data['designation'] ?? 'Lecturer',
                department: data['department'] ?? 'Science & Math',
                email: data['email'] ?? 'faculty@school.edu',
                phone: data['phone'] ?? '+91 98000 00000',
                bloodGroup: 'B+',
                dob: '01 Jan 1990',
                gender: 'Female',
                joiningDate: 'Today',
                experience: '3 Yrs',
                qualifications: 'M.Sc, B.Ed',
                address: 'New Delhi Campus Enclave',
                classTeacherOf: 'Unassigned',
                roomNumber: 'Faculty Hall',
                subjectsTaught: const [
                  SubjectAllocation(subject: 'General Science', classes: 'Class 8-A', periods: '14 P/wk'),
                ],
                weeklyPeriods: 14,
                baseSalary: 45000,
                allowances: 5000,
                deductions: 2000,
                netSalary: 48000,
                payrollStatus: 'Active',
                bankAccount: 'HDFC (A/C: XXXX-1122)',
                payslipHistory: const [],
                attendancePct: 100.0,
                totalDays: 1,
                presentDays: 1,
                leavesTaken: 0,
                remainingLeaves: 12,
                todayStatus: 'Present',
                dailySchedule: const [],
                rating: 5.0,
              ),
            );
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${data['name']} successfully onboarded to faculty register.'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        },
      ),
    );
  }

  void _openTeacherDossier(TeacherProfile teacher) {
    showDialog(
      context: context,
      builder: (_) => Teacher360Modal(teacher: teacher),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTeachers = _teachers.where((t) {
      final matchesDept = _selectedDept == 'ALL' || t.department == _selectedDept;
      final matchesQuery = _searchQuery.isEmpty ||
          t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.empId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.subjectsTaught.any((s) => s.subject.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesDept && matchesQuery;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Executive Staff Header with KPIs
          StaffHeader(onAddStaff: _openAddStaffModal),
          const SizedBox(height: 18),

          // Search and Department Filter Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 10,
              children: [
                // Department Filter Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildDeptChip('All Faculty (${_teachers.length})', 'ALL'),
                      const SizedBox(width: 6),
                      _buildDeptChip('Science & Math', 'Science & Math'),
                      const SizedBox(width: 6),
                      _buildDeptChip('Humanities & Lang', 'Humanities & Languages'),
                      const SizedBox(width: 6),
                      _buildDeptChip('IT & Computer Sci', 'IT & Computer Science'),
                    ],
                  ),
                ),

                // Search Field
                SizedBox(
                  width: 240,
                  height: 36,
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B)),
                    decoration: InputDecoration(
                      hintText: 'Search faculty, ID, subject...',
                      hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      prefixIcon: const Icon(Icons.search_rounded, size: 16, color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF4F46E5)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Faculty Cards List
          if (filteredTeachers.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Column(
                children: [
                  Icon(Icons.person_search_outlined, size: 36, color: Color(0xFF94A3B8)),
                  SizedBox(height: 10),
                  Text(
                    'No faculty found matching criteria.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTeachers.length,
              itemBuilder: (context, index) {
                final teacher = filteredTeachers[index];
                return TeacherCard(
                  teacher: teacher,
                  onOpenDossier: () => _openTeacherDossier(teacher),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDeptChip(String label, String dept) {
    final isSelected = _selectedDept == dept;
    return InkWell(
      onTap: () => setState(() => _selectedDept = dept),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
