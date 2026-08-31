import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedClassId;
  String? _selectedSectionId;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);
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
          // 1. Header with Live Pulse
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          // 2. Class & Date Selector Card
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            child: _buildFilterCard(context, classesAsync),
          ),
          const SizedBox(height: 24),

          // 3. Attendance Content Area
          if (_selectedClassId != null)
            Consumer(
              builder: (context, ref, child) {
                final attendanceAsync = ref.watch(classAttendanceProvider({
                  'classId': _selectedClassId!,
                  'sectionId': _selectedSectionId ?? '',
                  'date': _selectedDate.toIso8601String(),
                }));

                return attendanceAsync.when(
                  data: (attendanceList) {
                    if (attendanceList.isEmpty) {
                      return _buildEmptyState();
                    }

                    final present = attendanceList.where((a) => a.status == 'PRESENT').length;
                    final total = attendanceList.length;
                    final absent = total - present;
                    final pct = total > 0 ? (present / total) * 100 : 0.0;

                    final filtered = attendanceList.where((r) {
                      final name = '${r.student?.firstName ?? ''} ${r.student?.lastName ?? ''}'.toLowerCase();
                      final roll = (r.student?.rollNo ?? '').toLowerCase();
                      final q = _searchQuery.toLowerCase();
                      return name.contains(q) || roll.contains(q);
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 4 KPI Summary Cards
                        FadeSlideEntry(
                          delay: const Duration(milliseconds: 150),
                          child: _buildKpis(total, present, absent, pct),
                        ),
                        const SizedBox(height: 20),

                        // Search Bar
                        FadeSlideEntry(
                          delay: const Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: TextField(
                              onChanged: (v) => setState(() => _searchQuery = v),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
                                hintText: 'Search student by Name or Roll Number...',
                                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Students Attendance Cards Grid
                        FadeSlideEntry(
                          delay: const Duration(milliseconds: 250),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final record = filtered[index];
                              final student = record.student;
                              final isPresent = record.status == 'PRESENT';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: HoverLiftCard(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  borderRadius: 14,
                                  hoverBorderColor: isPresent
                                      ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                      : const Color(0xFFEF4444).withValues(alpha: 0.4),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: isPresent
                                            ? const Color(0xFF10B981).withValues(alpha: 0.12)
                                            : const Color(0xFFEF4444).withValues(alpha: 0.12),
                                        child: Text(
                                          (student?.firstName ?? 'S')[0].toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: isPresent ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${student?.firstName ?? 'Unknown'} ${student?.lastName ?? ''}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Roll No: ${student?.rollNo ?? 'N/A'} • ID: #${student != null && student.id.length >= 6 ? student.id.substring(0, 6) : 'N/A'}',
                                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: isPresent
                                              ? const Color(0xFF10B981).withValues(alpha: 0.12)
                                              : const Color(0xFFEF4444).withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              isPresent ? Icons.check_circle_rounded : Icons.cancel_rounded,
                                              size: 14,
                                              color: isPresent ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              record.status,
                                              style: TextStyle(
                                                color: isPresent ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                                fontWeight: FontWeight.w800,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(48.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                );
              },
            )
          else
            FadeSlideEntry(
              delay: const Duration(milliseconds: 150),
              child: _buildPromptSelectClass(),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                'Student Attendance Monitoring',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Daily Roll-Call Verification, Real-Time Absence Tracking & SMS Broadcast',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PulsingLiveDot(size: 6, pulseScale: 2.2, color: Color(0xFF10B981)),
                SizedBox(width: 8),
                Text('DAILY REGISTER ACTIVE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard(BuildContext context, AsyncValue<dynamic> classesAsync) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: classesAsync.when(
              data: (classes) => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Academic Class',
                  labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                initialValue: _selectedClassId,
                items: classes.map<DropdownMenuItem<String>>((dynamic c) {
                  return DropdownMenuItem<String>(value: c.id, child: Text(c.name));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedClassId = val;
                    _selectedSectionId = null;
                  });
                },
              ),
              loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF6C5CE7)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpis(int total, int present, int absent, double pct) {
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
            _buildMetricTile(total.toDouble(), 'Total Enrolled', Icons.people_alt_outlined, const Color(0xFF6C5CE7), 0, '', ''),
            _buildMetricTile(present.toDouble(), 'Present Today', Icons.check_circle_outline_rounded, const Color(0xFF10B981), 0, '', ''),
            _buildMetricTile(absent.toDouble(), 'Absent Scholars', Icons.cancel_outlined, const Color(0xFFEF4444), 0, '', ''),
            _buildMetricTile(pct, 'Attendance Rate', Icons.pie_chart_outline_rounded, const Color(0xFF0984E3), 1, '', '%'),
          ],
        );
      },
    );
  }

  Widget _buildMetricTile(
    double value,
    String label,
    IconData icon,
    Color color,
    int fractionDigits,
    String prefix,
    String suffix,
  ) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 14,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  prefix: prefix,
                  suffix: suffix,
                  fractionDigits: fractionDigits,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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
            Icon(Icons.event_busy_rounded, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text(
              'No Attendance Recorded for This Date',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
            ),
            SizedBox(height: 4),
            Text(
              'Teachers have not marked attendance yet or school is closed on this day.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptSelectClass() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.school_outlined, size: 48, color: Color(0xFF6C5CE7)),
            SizedBox(height: 12),
            Text(
              'Select an Academic Class Above',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
            ),
            SizedBox(height: 4),
            Text(
              'Choose a class and date to view complete roll-call status and statistics.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}
