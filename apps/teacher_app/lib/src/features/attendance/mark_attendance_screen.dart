import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class AttendanceScholar {
  final String id;
  final String rollNo;
  final String name;
  final String gender;
  final String guardianPhone;
  final double historicalAttendance;
  String status; // 'PRESENT', 'ABSENT', 'LATE', 'EXCUSED'

  AttendanceScholar({
    required this.id,
    required this.rollNo,
    required this.name,
    required this.gender,
    required this.guardianPhone,
    required this.historicalAttendance,
    this.status = 'PRESENT',
  });
}

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  static const String assignedClassTeacherOf = 'Class 10-A';

  DateTime _selectedDate = DateTime.now();
  String _selectedClass = 'Class 10-A';
  String _searchQuery = '';
  String _selectedFilter = 'ALL'; // 'ALL', 'PRESENT', 'ABSENT', 'LATE'
  bool _isSaving = false;

  bool get isAuthorizedClassTeacher => _selectedClass == assignedClassTeacherOf;

  String getAssignedClassTeacher(String className) {
    switch (className) {
      case 'Class 10-A':
        return 'Prof. Rajesh Sharma (You - Class Teacher)';
      case 'Class 9-B':
        return 'Mrs. Sunita Kapoor (TGT Mathematics)';
      case 'Class 11-A':
        return 'Mr. Arvind Verma (PGT Chemistry)';
      default:
        return 'Authorized Class Faculty';
    }
  }

  final Map<String, List<AttendanceScholar>> _classRosters = {
    'Class 10-A': [
      AttendanceScholar(id: 'stu_101', rollNo: '101', name: 'Aarav Sharma', gender: 'M', guardianPhone: '+91 98112 34501', historicalAttendance: 96.5, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_102', rollNo: '102', name: 'Ananya Iyer', gender: 'F', guardianPhone: '+91 98112 34502', historicalAttendance: 98.0, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_103', rollNo: '103', name: 'Rohan Mehta', gender: 'M', guardianPhone: '+91 98112 34503', historicalAttendance: 89.2, status: 'ABSENT'),
      AttendanceScholar(id: 'stu_104', rollNo: '104', name: 'Diya Patel', gender: 'F', guardianPhone: '+91 98112 34504', historicalAttendance: 94.8, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_105', rollNo: '105', name: 'Kabir Kapoor', gender: 'M', guardianPhone: '+91 98112 34505', historicalAttendance: 91.5, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_106', rollNo: '106', name: 'Ishita Roy', gender: 'F', guardianPhone: '+91 98112 34506', historicalAttendance: 97.4, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_107', rollNo: '107', name: 'Siddharth Rao', gender: 'M', guardianPhone: '+91 98112 34507', historicalAttendance: 85.0, status: 'LATE'),
      AttendanceScholar(id: 'stu_108', rollNo: '108', name: 'Meera Nambiar', gender: 'F', guardianPhone: '+91 98112 34508', historicalAttendance: 99.1, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_109', rollNo: '109', name: 'Vivaan Joshi', gender: 'M', guardianPhone: '+91 98112 34509', historicalAttendance: 93.3, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_110', rollNo: '110', name: 'Sneha Kulkarni', gender: 'F', guardianPhone: '+91 98112 34510', historicalAttendance: 95.6, status: 'PRESENT'),
    ],
    'Class 9-B': [
      AttendanceScholar(id: 'stu_201', rollNo: '201', name: 'Tanya Gupta', gender: 'F', guardianPhone: '+91 98223 45601', historicalAttendance: 97.0, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_202', rollNo: '202', name: 'Aditya Sen', gender: 'M', guardianPhone: '+91 98223 45602', historicalAttendance: 92.4, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_203', rollNo: '203', name: 'Bhavna Chawla', gender: 'F', guardianPhone: '+91 98223 45603', historicalAttendance: 94.1, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_204', rollNo: '204', name: 'Devansh Mishra', gender: 'M', guardianPhone: '+91 98223 45604', historicalAttendance: 88.5, status: 'ABSENT'),
      AttendanceScholar(id: 'stu_205', rollNo: '205', name: 'Gauri Shinde', gender: 'F', guardianPhone: '+91 98223 45605', historicalAttendance: 96.8, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_206', rollNo: '206', name: 'Harsh Vardhan', gender: 'M', guardianPhone: '+91 98223 45606', historicalAttendance: 90.0, status: 'PRESENT'),
    ],
    'Class 11-A': [
      AttendanceScholar(id: 'stu_301', rollNo: '301', name: 'Yashwardhan Singh', gender: 'M', guardianPhone: '+91 98334 56701', historicalAttendance: 95.0, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_302', rollNo: '302', name: 'Zoya Khan', gender: 'F', guardianPhone: '+91 98334 56702', historicalAttendance: 98.5, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_303', rollNo: '303', name: 'Kartik Saxena', gender: 'M', guardianPhone: '+91 98334 56703', historicalAttendance: 91.0, status: 'PRESENT'),
      AttendanceScholar(id: 'stu_304', rollNo: '304', name: 'Nandini Verma', gender: 'F', guardianPhone: '+91 98334 56704', historicalAttendance: 93.8, status: 'LATE'),
    ],
  };

  void _showUnauthorizedAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🔒 Permission Restricted: You are assigned Class Teacher for Class 10-A. Attendance for $_selectedClass can only be submitted by ${getAssignedClassTeacher(_selectedClass)}.',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFEF4444),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Switch to 10-A',
          textColor: Colors.white,
          onPressed: () => setState(() => _selectedClass = 'Class 10-A'),
        ),
      ),
    );
  }

  void _markAllPresent() {
    if (!isAuthorizedClassTeacher) {
      _showUnauthorizedAlert();
      return;
    }

    setState(() {
      final roster = _classRosters[_selectedClass] ?? [];
      for (var s in roster) {
        s.status = 'PRESENT';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All scholars marked PRESENT for Class 10-A! 🎯'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _markAllAbsent() {
    if (!isAuthorizedClassTeacher) {
      _showUnauthorizedAlert();
      return;
    }

    setState(() {
      final roster = _classRosters[_selectedClass] ?? [];
      for (var s in roster) {
        s.status = 'ABSENT';
      }
    });
  }

  void _setScholarStatus(AttendanceScholar s, String status) {
    if (!isAuthorizedClassTeacher) {
      _showUnauthorizedAlert();
      return;
    }

    setState(() {
      s.status = status;
    });
  }

  void _saveAttendance() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() => _isSaving = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attendance Register Locked & Saved for $_selectedClass (${DateFormat('dd MMM yyyy').format(_selectedDate)})! ✅'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final roster = _classRosters[_selectedClass] ?? [];

    // Filter roster
    final filteredRoster = roster.where((s) {
      final matchesQuery = _searchQuery.isEmpty ||
          s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.rollNo.contains(_searchQuery);

      if (!matchesQuery) return false;
      if (_selectedFilter == 'PRESENT') return s.status == 'PRESENT';
      if (_selectedFilter == 'ABSENT') return s.status == 'ABSENT';
      if (_selectedFilter == 'LATE') return s.status == 'LATE';
      return true;
    }).toList();

    // Calculate metrics
    final total = roster.length;
    final presentCount = roster.where((s) => s.status == 'PRESENT').length;
    final absentCount = roster.where((s) => s.status == 'ABSENT').length;
    final lateCount = roster.where((s) => s.status == 'LATE').length;
    final excusedCount = roster.where((s) => s.status == 'EXCUSED').length;
    final double attendancePct = total == 0 ? 0 : ((presentCount + lateCount) / total) * 100;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP LIVE DATE & ISOLATED CLOCK BANNER
          FadeSlideEntry(
            duration: const Duration(milliseconds: 250),
            child: _buildTopLiveDateTimeBanner(),
          ),
          const SizedBox(height: 18),

          // 2. CLASS SELECTOR & DATE SWITCHER
          FadeSlideEntry(
            delay: const Duration(milliseconds: 60),
            child: _buildClassAndDateControls(),
          ),
          const SizedBox(height: 18),

          // 3. ATTENDANCE METRICS COUNTERS
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: _buildAttendanceMetrics(total, presentCount, absentCount, lateCount, excusedCount, attendancePct),
          ),
          const SizedBox(height: 16),

          // 4. ACTION TOOLBAR & SEARCH
          FadeSlideEntry(
            delay: const Duration(milliseconds: 140),
            child: _buildRosterActionToolbar(total, filteredRoster.length),
          ),
          const SizedBox(height: 14),

          // 5. SCHOLAR ATTENDANCE LIST
          FadeSlideEntry(
            delay: const Duration(milliseconds: 180),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredRoster.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final scholar = filteredRoster[index];
                return _buildScholarAttendanceCard(scholar, index + 1);
              },
            ),
          ),
          const SizedBox(height: 24),

          // 6. SAVE REGISTER BUTTON
          FadeSlideEntry(
            delay: const Duration(milliseconds: 220),
            child: isAuthorizedClassTeacher
                ? SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _isSaving ? null : _saveAttendance,
                      icon: _isSaving
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(Icons.cloud_done_rounded, size: 20),
                      label: Text(
                        _isSaving ? 'Locking Attendance...' : 'Save & Broadcast Attendance Register ($presentCount/$total Present)',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lock_person_rounded, color: Color(0xFFEF4444), size: 22),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attendance Submission Locked for $_selectedClass',
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF991B1B)),
                                ),
                                Text(
                                  'Only assigned Class Teacher (${getAssignedClassTeacher(_selectedClass)}) can submit daily register.',
                                  style: const TextStyle(fontSize: 11, color: Color(0xFFB91C1C)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() => _selectedClass = 'Class 10-A'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                          ),
                          child: const Text('Open Class 10-A'),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // 1. Top Prominent Live Date & Time Header (with self-ticking digital clock)
  Widget _buildTopLiveDateTimeBanner() {
    final isToday = DateUtils.isSameDay(_selectedDate, DateTime.now());
    final dateFullStr = DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          // Left: Real-time Date and Live Status
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.calendar_month_rounded, color: Color(0xFF10B981), size: 28),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        dateFullStr,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (isToday)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('TODAY', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w900)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Daily Attendance & Roll Call Register',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),

          // Right: Real-time Live Digital Clock (Isolated sub-widget)
          const _LiveDigitalClockWidget(),
        ],
      ),
    );
  }

  // 2. Class, Section and Date Switcher Controls
  Widget _buildClassAndDateControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              // Class Dropdown with Lock Status
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.school_outlined, size: 20, color: Color(0xFF6C5CE7)),
                  const SizedBox(width: 8),
                  const Text('Select Class: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedClass,
                        isDense: true,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1E293B), fontSize: 13),
                        items: _classRosters.keys.map((c) {
                          final isAllocated = c == assignedClassTeacherOf;
                          return DropdownMenuItem(
                            value: c,
                            child: Row(
                              children: [
                                Icon(
                                  isAllocated ? Icons.stars_rounded : Icons.lock_outline_rounded,
                                  size: 15,
                                  color: isAllocated ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isAllocated ? '$c (My Class Teacher)' : '$c (Subject Only)',
                                  style: TextStyle(
                                    fontWeight: isAllocated ? FontWeight.w900 : FontWeight.w600,
                                    color: isAllocated ? const Color(0xFF10B981) : const Color(0xFF475569),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedClass = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Date Picker & Previous/Next Day Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded, size: 22, color: Color(0xFF64748B)),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                      });
                    },
                    tooltip: 'Previous Day',
                  ),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2027),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_rounded, size: 16, color: Color(0xFF6C5CE7)),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat('dd MMM yyyy').format(_selectedDate),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFF64748B)),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.add(const Duration(days: 1));
                      });
                    },
                    tooltip: 'Next Day',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Authorization Status Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isAuthorizedClassTeacher ? const Color(0xFF10B981).withValues(alpha: 0.08) : const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isAuthorizedClassTeacher ? const Color(0xFF10B981).withValues(alpha: 0.25) : const Color(0xFFEF4444).withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isAuthorizedClassTeacher ? Icons.verified_user_rounded : Icons.lock_person_rounded,
                  color: isAuthorizedClassTeacher ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isAuthorizedClassTeacher
                        ? 'Authorized Class Teacher: You have full permissions to take and submit the official daily register for Class 10-A.'
                        : 'Restricted Subject Faculty View: Official register for $_selectedClass is governed by ${getAssignedClassTeacher(_selectedClass)}. Attendance marking is locked to the designated Class Teacher.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isAuthorizedClassTeacher ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                    ),
                  ),
                ),
                if (!isAuthorizedClassTeacher)
                  InkWell(
                    onTap: () => setState(() => _selectedClass = 'Class 10-A'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Switch to 10-A', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Attendance Live Metrics (Present, Absent, Late, Rate)
  Widget _buildAttendanceMetrics(int total, int present, int absent, int late, int excused, double pct) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth < 650 ? 2 : 4;
        return GridView.count(
          crossAxisCount: crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossCount == 4 ? 2.3 : 2.0,
          children: [
            _buildMetricCard('Total Scholars', '$total', '', 'Enrolled in $_selectedClass', Icons.groups_rounded, const Color(0xFF6C5CE7)),
            _buildMetricCard('Present Today', '$present', ' (${pct.toStringAsFixed(1)}%)', 'Active in Classroom', Icons.check_circle_rounded, const Color(0xFF10B981)),
            _buildMetricCard('Absent', '$absent', '', 'Unexcused & Leaves', Icons.cancel_rounded, const Color(0xFFEF4444)),
            _buildMetricCard('Late Arrivals', '$late', '', 'Grace Period Admitted', Icons.access_time_filled_rounded, const Color(0xFFF59E0B)),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(String title, String mainValue, String suffix, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: mainValue,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: color),
                    children: [
                      TextSpan(
                        text: suffix,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: color.withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Action Toolbar: Quick All-Present & Search Filter
  Widget _buildRosterActionToolbar(int total, int filteredCount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          // Filter Chips
          Wrap(
            spacing: 6,
            children: ['ALL', 'PRESENT', 'ABSENT', 'LATE'].map((filter) {
              final isSel = _selectedFilter == filter;
              return ChoiceChip(
                label: Text(filter),
                selected: isSel,
                onSelected: (val) {
                  if (val) setState(() => _selectedFilter = filter);
                },
                selectedColor: const Color(0xFF10B981).withValues(alpha: 0.15),
                labelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: isSel ? FontWeight.w800 : FontWeight.w600,
                  color: isSel ? const Color(0xFF10B981) : const Color(0xFF64748B),
                ),
              );
            }).toList(),
          ),

          // Search Field & Quick 1-Tap All-Present Button
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                height: 36,
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search scholar...',
                    hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _markAllPresent,
                icon: const Icon(Icons.done_all_rounded, size: 15),
                label: const Text('All Present'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.12),
                  foregroundColor: const Color(0xFF10B981),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
              const SizedBox(width: 6),
              OutlinedButton.icon(
                onPressed: _markAllAbsent,
                icon: const Icon(Icons.clear_all_rounded, size: 15),
                label: const Text('All Absent'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: BorderSide(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 5. Scholar Attendance Item Card
  Widget _buildScholarAttendanceCard(AttendanceScholar scholar, int index) {
    final status = scholar.status;
    final isPresent = status == 'PRESENT';
    final isAbsent = status == 'ABSENT';
    final isLate = status == 'LATE';
    final isExcused = status == 'EXCUSED';

    final Color statusColor = isPresent
        ? const Color(0xFF10B981)
        : isAbsent
            ? const Color(0xFFEF4444)
            : isLate
                ? const Color(0xFFF59E0B)
                : const Color(0xFF6C5CE7);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isAbsent ? const Color(0xFFFEF2F2) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: statusColor.withValues(alpha: isPresent ? 0.2 : 0.4),
          width: isPresent ? 1 : 1.5,
        ),
      ),
      child: Row(
        children: [
          // Roll No Avatar Badge
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              scholar.rollNo,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: statusColor),
            ),
          ),
          const SizedBox(width: 14),

          // Name and Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      scholar.name,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${scholar.historicalAttendance}% Overall',
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Guardian: ${scholar.guardianPhone}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),

          // 4 Status Action Pills (P, A, L, E)
          Wrap(
            spacing: 6,
            children: [
              _buildStatusPill(scholar, 'P', 'PRESENT', const Color(0xFF10B981), isPresent),
              _buildStatusPill(scholar, 'A', 'ABSENT', const Color(0xFFEF4444), isAbsent),
              _buildStatusPill(scholar, 'L', 'LATE', const Color(0xFFF59E0B), isLate),
              _buildStatusPill(scholar, 'E', 'EXCUSED', const Color(0xFF6C5CE7), isExcused),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(AttendanceScholar s, String label, String statusKey, Color color, bool isSelected) {
    return InkWell(
      onTap: () => _setScholarStatus(s, statusKey),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : color.withValues(alpha: 0.25),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            color: isSelected ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}

// Dedicated isolated live ticking digital clock
class _LiveDigitalClockWidget extends StatefulWidget {
  const _LiveDigitalClockWidget();

  @override
  State<_LiveDigitalClockWidget> createState() => _LiveDigitalClockWidgetState();
}

class _LiveDigitalClockWidgetState extends State<_LiveDigitalClockWidget> {
  late DateTime _time;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _time = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _time = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('hh:mm:ss a').format(_time);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PulsingLiveDot(size: 6, pulseScale: 2.2, color: Color(0xFF10B981)),
          const SizedBox(width: 8),
          const Text(
            'LIVE TIME: ',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            timeStr,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFF38BDF8),
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
