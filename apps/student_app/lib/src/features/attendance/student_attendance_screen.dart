import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class StudentAttendanceScreen extends ConsumerStatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  ConsumerState<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends ConsumerState<StudentAttendanceScreen> {
  DateTime _selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Attendance & Biometrics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_calendar),
            tooltip: 'Apply for Leave',
            onPressed: () => _showApplyLeaveDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: ResponsiveTwoPane(
            breakpoint: 880,
            leftFlex: 1,
            rightFlex: 1,
            spacing: 24,
            leftPane: Column(
              children: [
                _buildAttendanceRingCard(context, primaryColor),
                const SizedBox(height: 20),
                _buildMonthlyCalendarView(context, primaryColor),
              ],
            ),
            rightPane: Column(
              children: [
                _buildRfidTimeline(context, primaryColor),
                const SizedBox(height: 20),
                _buildApplyLeaveBanner(context, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceRingCard(BuildContext context, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Circular Percentage Indicator
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 0.948,
                      strokeWidth: 9,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00B894)),
                    ),
                    const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '94.8%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2D3436),
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Score',
                            style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B894).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'EXCELLENT ATTENDANCE',
                        style: TextStyle(color: Color(0xFF00B894), fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Eligible for Board Exams',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Minimum 75% required by CBSE.',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Stat counters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAttendanceMetricItem('Present', '114', const Color(0xFF00B894)),
              _buildAttendanceMetricItem('Absent', '4', const Color(0xFFD63031)),
              _buildAttendanceMetricItem('Late', '2', const Color(0xFFF39C12)),
              _buildAttendanceMetricItem('Holidays', '18', const Color(0xFF0984E3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceMetricItem(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildMonthlyCalendarView(BuildContext context, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(_selectedMonth),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Day headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return SizedBox(
                width: 34,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1.1,
            ),
            itemCount: 31,
            itemBuilder: (context, index) {
              final day = index + 1;
              final isSunday = (day % 7 == 1);
              final isAbsent = day == 14 || day == 22;
              final isLate = day == 5;
              final isToday = day == 29;

              Color bg = const Color(0xFFDCFCE7);
              Color text = const Color(0xFF15803D);

              if (isSunday) {
                bg = const Color(0xFFF1F5F9);
                text = const Color(0xFF94A3B8);
              } else if (isAbsent) {
                bg = const Color(0xFFFEE2E2);
                text = const Color(0xFFB91C1C);
              } else if (isLate) {
                bg = const Color(0xFFFEF3C7);
                text = const Color(0xFFB45309);
              }

              return Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(10),
                  border: isToday ? Border.all(color: primaryColor, width: 2) : null,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: text,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegend(const Color(0xFF00B894), 'Present'),
              _buildLegend(const Color(0xFFD63031), 'Absent'),
              _buildLegend(const Color(0xFFF39C12), 'Late'),
              _buildLegend(const Color(0xFF94A3B8), 'Sunday / Off'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildRfidTimeline(BuildContext context, Color primaryColor) {
    final punchLogs = [
      {
        'date': 'Today, 29 Aug 2026',
        'entry': '08:14 AM (Main Gate RFID Terminal)',
        'exit': 'Ongoing (In Campus)',
        'status': 'ON_CAMPUS',
      },
      {
        'date': 'Yesterday, 28 Aug 2026',
        'entry': '08:18 AM (Main Gate RFID Terminal)',
        'exit': '02:35 PM (Bus Bay Gate 2)',
        'status': 'COMPLETED',
      },
      {
        'date': 'Wednesday, 27 Aug 2026',
        'entry': '08:11 AM (Main Gate RFID Terminal)',
        'exit': '02:30 PM (Bus Bay Gate 2)',
        'status': 'COMPLETED',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.nfc, color: Color(0xFF0984E3), size: 22),
              SizedBox(width: 8),
              Text(
                'RFID Smart Card Punch History',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
            ],
          ),
          const SizedBox(height: 14),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: punchLogs.length,
            separatorBuilder: (_, _) => const Divider(height: 20, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, index) {
              final log = punchLogs[index];
              final isOnCampus = log['status'] == 'ON_CAMPUS';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(log['date']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isOnCampus ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          isOnCampus ? 'INSIDE SCHOOL' : 'DAY LOGGED',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: isOnCampus ? const Color(0xFF16A34A) : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.login, size: 14, color: Color(0xFF00B894)),
                      const SizedBox(width: 6),
                      Text('Check-In: ${log['entry']}', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.logout, size: 14, color: Color(0xFFD63031)),
                      const SizedBox(width: 6),
                      Text('Check-Out: ${log['exit']}', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApplyLeaveBanner(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withValues(alpha: 0.1), const Color(0xFF00CEC9).withValues(alpha: 0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
            child: const Icon(Icons.edit_calendar, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Need Time Off from School?', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                SizedBox(height: 2),
                Text('Submit leave application to class teacher with 1 tap.', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _showApplyLeaveDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Apply', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showApplyLeaveDialog(BuildContext context) {
    AdaptiveModal.show(
      context: context,
      maxWidth: 500,
      title: const Text('Apply for Leave', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Leave Type',
              hintText: 'Medical / Family Emergency / Casual',
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: 'From Date - To Date',
              hintText: 'e.g. 05 Sept 2026 - 07 Sept 2026',
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Reason for Leave',
              hintText: 'Detailed explanation for the Principal/Teacher...',
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Leave Application submitted to Class Teacher! 📩'),
                backgroundColor: Color(0xFF00B894),
              ),
            );
          },
          child: const Text('Submit Application'),
        ),
      ],
    );
  }
}
