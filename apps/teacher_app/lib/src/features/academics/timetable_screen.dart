import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  String _selectedDay = 'Monday';

  final Map<String, List<Map<String, String>>> _weeklySchedule = {
    'Monday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Assembly & Homeroom', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Mathematics', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Physics Lab', 'class': 'Class 9-B', 'room': 'Lab 2'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Staff Planning', 'class': 'Faculty Room', 'room': 'Floor 2'},
      {'period': 'Period 5', 'time': '12:15 - 01:00 PM', 'subject': 'Geometry & Math', 'class': 'Class 8-C', 'room': 'Room 201'},
    ],
    'Tuesday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Mathematics', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Algebra Basics', 'class': 'Class 9-A', 'room': 'Room 202'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Math Doubt Session', 'class': 'Class 10-B', 'room': 'Room 305'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Physics Theory', 'class': 'Class 9-B', 'room': 'Room 203'},
    ],
    'Wednesday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Mathematics', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Calculus Intro', 'class': 'Class 11-Science', 'room': 'Room 401'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Free Period', 'class': 'Faculty Room', 'room': 'Floor 2'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Science Lab', 'class': 'Class 8-A', 'room': 'Lab 1'},
    ],
    'Thursday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Physics Theory', 'class': 'Class 9-B', 'room': 'Room 203'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Mathematics', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Geometry & Math', 'class': 'Class 8-C', 'room': 'Room 201'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Remedial Class', 'class': 'Class 10-A', 'room': 'Room 304'},
    ],
    'Friday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Mathematics Test', 'class': 'Class 10-A', 'room': 'Room 304'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'Physics Lab', 'class': 'Class 9-B', 'room': 'Lab 2'},
      {'period': 'Period 3', 'time': '10:15 - 11:00 AM', 'subject': 'Club Activity / Sports', 'class': 'Playground', 'room': 'Campus'},
      {'period': 'Period 4', 'time': '11:30 - 12:15 PM', 'subject': 'Staff Meeting', 'class': 'Principal Office', 'room': 'Admin Wing'},
    ],
    'Saturday': [
      {'period': 'Period 1', 'time': '08:30 - 09:15 AM', 'subject': 'Co-curricular & Seminars', 'class': 'Auditorium', 'room': 'Main Block'},
      {'period': 'Period 2', 'time': '09:30 - 10:15 AM', 'subject': 'PTM / Parent Consults', 'class': 'Class 10-A', 'room': 'Room 304'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final periods = _weeklySchedule[_selectedDay] ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(),
          ),
          const SizedBox(height: 20),

          // Day Selector Tabs
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].map((day) {
                  final isSelected = _selectedDay == day;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(day),
                      selected: isSelected,
                      selectedColor: const Color(0xFF10B981),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        fontSize: 12,
                      ),
                      side: BorderSide(color: isSelected ? const Color(0xFF10B981) : const Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onSelected: (sel) {
                        if (sel) setState(() => _selectedDay = day);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Periods List for Selected Day
          FadeSlideEntry(
            delay: const Duration(milliseconds: 150),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: periods.length,
              itemBuilder: (context, index) {
                final p = periods[index];
                final isFree = p['subject']!.toLowerCase().contains('free') || p['subject']!.toLowerCase().contains('planning');

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: HoverLiftCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 14,
                    hoverBorderColor: isFree ? const Color(0xFF64748B).withValues(alpha: 0.3) : const Color(0xFF10B981).withValues(alpha: 0.4),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isFree ? const Color(0xFFF1F5F9) : const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '#${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: isFree ? const Color(0xFF64748B) : const Color(0xFF10B981),
                            ),
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
                                    p['subject']!,
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      p['class']!,
                                      style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Time: ${p['time']} • Location: ${p['room']}',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isFree ? Icons.coffee_rounded : Icons.menu_book_rounded,
                          color: isFree ? const Color(0xFF94A3B8) : const Color(0xFF10B981),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Teaching Timetable',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Assigned Class Periods, Laboratory Slots, Free Intervals & Duty Roster',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Icon(Icons.calendar_month_rounded, color: Color(0xFF10B981), size: 32),
        ],
      ),
    );
  }
}
