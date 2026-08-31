import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class MarkAttendanceScreen extends ConsumerStatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  ConsumerState<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends ConsumerState<MarkAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _currentTime;
  Timer? _clockTimer;
  String? _selectedClassId;
  String? _selectedSectionId;
  String _searchQuery = '';
  
  final Map<String, String> _studentStatuses = {}; // studentId -> status (PRESENT/ABSENT/LATE/EXCUSED)
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  void _loadExistingAttendance(List<Attendance> existing) {
    if (existing.isNotEmpty && _studentStatuses.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          for (var record in existing) {
            _studentStatuses[record.studentId] = record.status;
          }
        });
      });
    }
  }

  void _markAllPresent(List<Student> students) {
    setState(() {
      for (var s in students) {
        _studentStatuses[s.id] = 'PRESENT';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All scholars marked PRESENT for today! 🎯'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _submitAttendance() async {
    if (_selectedClassId == null) return;
    final user = ref.read(authProvider).value?.user;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      final statuses = _studentStatuses.entries.map((e) => {
        'studentId': e.key,
        'status': e.value,
        'remarks': '',
      }).toList();

      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
      await ref.read(attendanceRepositoryProvider).markAttendance(
        dateStr,
        statuses,
        user.id,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance Register Saved Successfully for ${DateFormat('dd MMM yyyy').format(_selectedDate)}! ✅'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving attendance: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String _getStudentName(Student s) {
    if (s.user?.name != null && s.user!.name.isNotEmpty) {
      return s.user!.name;
    }
    final name = '${s.firstName} ${s.lastName ?? ""}'.trim();
    return name.isNotEmpty ? name : 'Scholar';
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);
    final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    
    AsyncValue<List<Student>>? studentsAsync;
    AsyncValue<List<Attendance>>? existingAttendanceAsync;
    
    if (_selectedClassId != null) {
      studentsAsync = ref.watch(studentListProvider({'classId': _selectedClassId, 'sectionId': _selectedSectionId}));
      existingAttendanceAsync = ref.watch(classAttendanceProvider({
        'classId': _selectedClassId,
        'sectionId': _selectedSectionId ?? '',
        'date': dateStr,
      }));
    }

    // Load existing statuses if loaded
    existingAttendanceAsync?.whenData((existing) {
      _loadExistingAttendance(existing);
    });

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP PROMINENT LIVE DATE & TIME HEADER
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildTopLiveDateTimeBanner(),
          ),
          const SizedBox(height: 18),

          // 2. Class & Section Picker Bar with Quick Date Switcher
          FadeSlideEntry(
            delay: const Duration(milliseconds: 80),
            child: _buildClassAndDateControls(classesAsync),
          ),
          const SizedBox(height: 18),

          // 3. Students List & Attendance Roster
          if (_selectedClassId == null)
            _buildSelectClassPrompt()
          else
            studentsAsync!.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(48.0),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => Center(child: Text('Error loading scholars: $err')),
              data: (students) {
                if (students.isEmpty) {
                  return _buildNoStudentsInClass();
                }

                // Calculate metrics
                final total = students.length;
                int presentCount = 0;
                int absentCount = 0;
                int lateCount = 0;
                int excusedCount = 0;

                for (var s in students) {
                  final st = _studentStatuses[s.id] ?? 'PRESENT';
                  if (st == 'PRESENT') presentCount++;
                  if (st == 'ABSENT') absentCount++;
                  if (st == 'LATE') lateCount++;
                  if (st == 'EXCUSED') excusedCount++;
                }

                final filteredStudents = students.where((s) {
                  final q = _searchQuery.toLowerCase();
                  final sName = _getStudentName(s).toLowerCase();
                  return q.isEmpty ||
                      sName.contains(q) ||
                      s.rollNo.toLowerCase().contains(q);
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Attendance Live Counters
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 120),
                      child: _buildAttendanceMetrics(total, presentCount, absentCount, lateCount, excusedCount),
                    ),
                    const SizedBox(height: 16),

                    // Quick Actions & Search Bar
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 160),
                      child: _buildRosterActionToolbar(students, filteredStudents.length),
                    ),
                    const SizedBox(height: 14),

                    // Student Cards List
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student = filteredStudents[index];
                          final currentStatus = _studentStatuses[student.id] ?? 'PRESENT';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildScholarAttendanceCard(student, currentStatus, index + 1),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sticky Bottom Save Register Button
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 240),
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF10B981).withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: _isSaving ? null : _submitAttendance,
                          icon: _isSaving
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.check_circle_rounded, size: 20),
                          label: Text(
                            _isSaving ? 'Submitting Register to Server...' : 'Submit & Save Attendance Register',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  // 1. Prominent Live Date & Time Banner
  Widget _buildTopLiveDateTimeBanner() {
    final timeStr = DateFormat('hh:mm:ss a').format(_currentTime);
    final dateFullStr = DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate);
    final isToday = DateUtils.isSameDay(_selectedDate, DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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

          // Right: Real-time Live Digital Clock + Pulse Dot
          Container(
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
          ),
        ],
      ),
    );
  }

  // 2. Class, Section and Date Switcher Controls
  Widget _buildClassAndDateControls(AsyncValue<List<AcademicClass>> classesAsync) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          // Class Dropdown
          classesAsync.when(
            data: (classes) {
              if (classes.isEmpty) return const Text('No classes found');
              _selectedClassId ??= classes.first.id;

              return Row(
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
                        value: _selectedClassId,
                        isDense: true,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1E293B), fontSize: 13),
                        items: classes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedClassId = val;
                            _studentStatuses.clear();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Text('Loading classes...'),
            error: (e, st) => Text('Error: $e'),
          ),

          // Date Navigation Pills
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 22, color: Color(0xFF64748B)),
                tooltip: 'Previous Day',
                onPressed: () {
                  setState(() {
                    _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                    _studentStatuses.clear();
                  });
                },
              ),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2028),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                      _studentStatuses.clear();
                    });
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
                      const Icon(Icons.edit_calendar_rounded, size: 16, color: Color(0xFF6C5CE7)),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('dd MMM yyyy').format(_selectedDate),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFF64748B)),
                tooltip: 'Next Day',
                onPressed: () {
                  setState(() {
                    _selectedDate = _selectedDate.add(const Duration(days: 1));
                    _studentStatuses.clear();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Attendance Counters Tile
  Widget _buildAttendanceMetrics(int total, int present, int absent, int late, int excused) {
    final rate = total > 0 ? (present / total) * 100 : 0.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth < 650 ? 2 : 4;
        return GridView.count(
          crossAxisCount: crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: crossCount == 4 ? 2.3 : 2.0,
          children: [
            _buildMetricPill(total.toDouble(), 'Total Scholars', '', Icons.group_outlined, const Color(0xFF6C5CE7), 0),
            _buildMetricPill(present.toDouble(), 'Present Today', '(${rate.toStringAsFixed(0)}%)', Icons.check_circle_outline_rounded, const Color(0xFF10B981), 0),
            _buildMetricPill(absent.toDouble(), 'Absent Today', 'SMS Triggered', Icons.cancel_outlined, const Color(0xFFEF4444), 0),
            _buildMetricPill(late.toDouble(), 'Late Arrivals', 'Grace Period', Icons.access_time_rounded, const Color(0xFFF59E0B), 0),
          ],
        );
      },
    );
  }

  Widget _buildMetricPill(double value, String title, String sub, IconData icon, Color color, int digits) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: 12,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  fractionDigits: digits,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                if (sub.isNotEmpty)
                  Text(sub, style: const TextStyle(fontSize: 9, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Roster Toolbar
  Widget _buildRosterActionToolbar(List<Student> allStudents, int filteredCount) {
    return Row(
      children: [
        // Search Input
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: const InputDecoration(
                icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 18),
                hintText: 'Search scholar by name or roll number...',
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Mark All Present Button
        ElevatedButton.icon(
          onPressed: () => _markAllPresent(allStudents),
          icon: const Icon(Icons.done_all_rounded, size: 16),
          label: const Text('Mark All Present'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  // 5. Individual Student Attendance Row Card
  Widget _buildScholarAttendanceCard(Student student, String currentStatus, int indexNumber) {
    final sName = _getStudentName(student);
    final isPresent = currentStatus == 'PRESENT';
    final isAbsent = currentStatus == 'ABSENT';
    final isLate = currentStatus == 'LATE';
    final isExcused = currentStatus == 'EXCUSED';

    Color cardBorderColor = const Color(0xFFE2E8F0);
    if (isAbsent) cardBorderColor = const Color(0xFFEF4444).withValues(alpha: 0.5);
    if (isLate) cardBorderColor = const Color(0xFFF59E0B).withValues(alpha: 0.5);
    if (isExcused) cardBorderColor = const Color(0xFF0984E3).withValues(alpha: 0.5);

    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 12,
      borderColor: cardBorderColor,
      hoverBorderColor: const Color(0xFF10B981).withValues(alpha: 0.4),
      child: Row(
        children: [
          // Index / Roll No Tag
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$indexNumber',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B)),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: isAbsent
                ? const Color(0xFFEF4444).withValues(alpha: 0.12)
                : const Color(0xFF10B981).withValues(alpha: 0.12),
            child: Text(
              sName.isNotEmpty ? sName[0].toUpperCase() : 'S',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isAbsent ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name and Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sName,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 2),
                Text(
                  'Roll No: ${student.rollNo} • Scholar ID: #${student.id.substring(0, 6)}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),

          // 1-Tap Segmented Attendance Status Toggle (P / A / L / E)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusPill('P', 'PRESENT', isPresent, const Color(0xFF10B981), student.id),
              const SizedBox(width: 4),
              _buildStatusPill('A', 'ABSENT', isAbsent, const Color(0xFFEF4444), student.id),
              const SizedBox(width: 4),
              _buildStatusPill('L', 'LATE', isLate, const Color(0xFFF59E0B), student.id),
              const SizedBox(width: 4),
              _buildStatusPill('E', 'EXCUSED', isExcused, const Color(0xFF0984E3), student.id),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(String code, String statusValue, bool isSelected, Color color, String studentId) {
    return InkWell(
      onTap: () {
        setState(() {
          _studentStatuses[studentId] = statusValue;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? color : Colors.transparent),
        ),
        child: Text(
          code,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectClassPrompt() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.school_outlined, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('Select a Class to Begin Roll Call', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('Choose your assigned class section above to view the student roll list.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Widget _buildNoStudentsInClass() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.person_off_outlined, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No Scholars Enrolled in this Section', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('Contact the admin office to enroll scholars or assign sections.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}
