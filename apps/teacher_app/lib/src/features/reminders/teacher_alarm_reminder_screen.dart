import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class TeacherAlarmReminderScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;
  const TeacherAlarmReminderScreen({super.key, this.initialTabIndex = 0});

  @override
  ConsumerState<TeacherAlarmReminderScreen> createState() => _TeacherAlarmReminderScreenState();
}

class _TeacherAlarmReminderScreenState extends ConsumerState<TeacherAlarmReminderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _autoPeriodAlerts = true;

  final List<Map<String, dynamic>> _periodAlarms = [
    {
      'id': 'TALM-1',
      'period': 'Period 1 (08:30 AM)',
      'time': const TimeOfDay(hour: 8, minute: 25),
      'leadMin': 5,
      'classSection': 'Class 10-A',
      'subject': 'Physics: Ray Optics',
      'room': 'Room 204',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'sound': 'School Bell (Chime)',
      'vibrate': true,
      'isEnabled': true,
      'color': 0xFF10B981,
    },
    {
      'id': 'TALM-2',
      'period': 'Period 3 (10:15 AM)',
      'time': const TimeOfDay(hour: 10, minute: 10),
      'leadMin': 5,
      'classSection': 'Class 11-B',
      'subject': 'Physics Lab: Optics Experiment',
      'room': 'Physics Lab 1',
      'days': ['Mon', 'Wed', 'Fri'],
      'sound': 'Double Beep Alert',
      'vibrate': true,
      'isEnabled': true,
      'color': 0xFF0984E3,
    },
    {
      'id': 'TALM-3',
      'period': 'Period 5 (01:15 PM)',
      'time': const TimeOfDay(hour: 13, minute: 10),
      'leadMin': 5,
      'classSection': 'Class 9-C',
      'subject': 'Science: Motion & Forces',
      'room': 'Room 108',
      'days': ['Mon', 'Tue', 'Thu'],
      'sound': 'Gentle Marimba',
      'vibrate': false,
      'isEnabled': true,
      'color': 0xFF6C5CE7,
    },
    {
      'id': 'TALM-4',
      'period': 'Dispersal & Bus Duty (03:45 PM)',
      'time': const TimeOfDay(hour: 15, minute: 40),
      'leadMin': 5,
      'classSection': 'Gate 2 Departure',
      'subject': 'Student Dispersal & Safety Supervision',
      'room': 'Main Campus Gate',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'sound': 'Loud Siren Alert',
      'vibrate': true,
      'isEnabled': false,
      'color': 0xFFE17055,
    },
  ];

  final List<Map<String, dynamic>> _teacherReminders = [
    {
      'id': 'TREM-1',
      'title': 'Submit Class 10-A Morning Attendance',
      'tag': 'Attendance',
      'dateTime': DateTime.now().add(const Duration(hours: 1)),
      'priority': 'HIGH',
      'target': 'Daily by 09:15 AM',
      'leadTime': '15 min before',
      'isCompleted': false,
      'color': 0xFFE74C3C,
    },
    {
      'id': 'TREM-2',
      'title': 'Grade Class 10-A Physics Ray Optics Worksheets',
      'tag': 'Grading',
      'dateTime': DateTime.now().add(const Duration(days: 1, hours: 6)),
      'priority': 'HIGH',
      'target': '34 Submissions Pending',
      'leadTime': '1 hour before',
      'isCompleted': false,
      'color': 0xFFF39C12,
    },
    {
      'id': 'TREM-3',
      'title': 'Upload Monthly Teaching Diary & Lesson Plan for October',
      'tag': 'Syllabus',
      'dateTime': DateTime.now().add(const Duration(days: 4)),
      'priority': 'MEDIUM',
      'target': 'Principal Academic Review',
      'leadTime': '1 day before',
      'isCompleted': false,
      'color': 0xFF10B981,
    },
    {
      'id': 'TREM-4',
      'title': 'Parent Discussion: Aarav Sharma (Roll #24) Academic Progress',
      'tag': 'PTM',
      'dateTime': DateTime.now().add(const Duration(days: 6, hours: 2)),
      'priority': 'LOW',
      'target': 'In-person / Room 204',
      'leadTime': '30 min before',
      'isCompleted': false,
      'color': 0xFF6C5CE7,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.alarm_on_rounded, color: primaryColor, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'Faculty Alarms & Reminders',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF1E293B)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up_rounded, color: Color(0xFF64748B), size: 20),
            tooltip: 'Alarm Volume & Test',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Period bell audio and vibration active 🔔')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: const Color(0xFF64748B),
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.alarm_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text('Period Alarms (${_periodAlarms.where((a) => a['isEnabled'] == true).length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_active_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text('Faculty Tasks (${_teacherReminders.where((r) => r['isCompleted'] == false).length})'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ResponsiveContainer(
        maxWidth: 1200,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPeriodAlarmsTab(primaryColor),
            _buildFacultyRemindersTab(primaryColor),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: Text(
          _tabController.index == 0 ? 'Add Period Alarm' : 'Add Task Reminder',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddPeriodAlarmModal(context, primaryColor);
          } else {
            _showAddTeacherReminderModal(context, primaryColor);
          }
        },
      ),
    );
  }

  // ----------------------------------------------------
  // TAB 1: PERIOD ALARMS
  // ----------------------------------------------------
  Widget _buildPeriodAlarmsTab(Color primaryColor) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        // Top Auto-Period Bell Banner
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.25), blurRadius: 14, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AUTOMATIC PERIOD WARNING BELLS', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                    const SizedBox(height: 4),
                    const Text('5-Minute Class Warning', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text(
                      _autoPeriodAlerts ? 'Active: Chimes 5 min before every scheduled lecture' : 'Disabled: Manual alarms only',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _autoPeriodAlerts,
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.white38,
                onChanged: (val) {
                  setState(() => _autoPeriodAlerts = val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(val ? 'Automatic 5-min prep alarms enabled for all classes 🔔' : 'Automatic period alerts turned off'),
                      backgroundColor: const Color(0xFF10B981),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Quick Presets
        const Text('QUICK FACULTY PRESETS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPresetChip('+ Attendance Submission (09:15 AM)', const TimeOfDay(hour: 9, minute: 15), primaryColor),
              _buildPresetChip('+ Staff Meeting (03:30 PM)', const TimeOfDay(hour: 15, minute: 30), primaryColor),
              _buildPresetChip('+ Exam Duty Reminder (10:00 AM)', const TimeOfDay(hour: 10, minute: 0), primaryColor),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Period Alarms List
        const Text('SCHEDULED PERIOD ALARMS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
        const SizedBox(height: 10),

        if (context.isTablet || context.isDesktop)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 185,
            ),
            itemCount: _periodAlarms.length,
            itemBuilder: (context, index) => _buildPeriodAlarmCard(_periodAlarms[index], primaryColor),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _periodAlarms.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _buildPeriodAlarmCard(_periodAlarms[index], primaryColor),
          ),
      ],
    );
  }

  Widget _buildPresetChip(String label, TimeOfDay time, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Icon(Icons.add_alarm_rounded, color: primaryColor, size: 16),
        label: Text(label, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: 11)),
        backgroundColor: primaryColor.withValues(alpha: 0.08),
        side: BorderSide(color: primaryColor.withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          setState(() {
            _periodAlarms.add({
              'id': 'TALM-${_periodAlarms.length + 1}',
              'period': label.replaceAll('+', '').trim(),
              'time': time,
              'leadMin': 5,
              'classSection': 'Faculty Activity',
              'subject': label.replaceAll('+', '').trim(),
              'room': 'Faculty Room',
              'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
              'sound': 'School Bell (Chime)',
              'vibrate': true,
              'isEnabled': true,
              'color': 0xFF10B981,
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Faculty Alarm "$label" added & activated! ⏰'), backgroundColor: const Color(0xFF10B981)),
          );
        },
      ),
    );
  }

  Widget _buildPeriodAlarmCard(Map<String, dynamic> alarm, Color primaryColor) {
    final isEnabled = alarm['isEnabled'] as bool;
    final time = alarm['time'] as TimeOfDay;
    final days = alarm['days'] as List<String>;
    final cardColor = Color(alarm['color'] as int);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isEnabled ? cardColor.withValues(alpha: 0.4) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      alarm['period'] as String,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: cardColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      alarm['classSection'] as String,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)),
                    ),
                  ),
                ],
              ),
              Switch(
                value: isEnabled,
                activeThumbColor: cardColor,
                onChanged: (val) {
                  setState(() => alarm['isEnabled'] = val);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _formatTime(time),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: isEnabled ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• Rings ${alarm['leadMin']}m before bell',
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 2),

          Text(
            '${alarm['subject']} (${alarm['room']})',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isEnabled ? const Color(0xFF334155) : const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: ['M', 'T', 'W', 'T', 'F'].asMap().entries.map((entry) {
                  final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                  final isActive = days.contains(dayNames[entry.key]);
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: isActive ? cardColor.withValues(alpha: isEnabled ? 0.15 : 0.05) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: isActive ? (isEnabled ? cardColor : const Color(0xFF94A3B8)) : const Color(0xFFCBD5E1),
                      ),
                    ),
                  );
                }).toList(),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFF94A3B8)),
                onPressed: () {
                  setState(() => _periodAlarms.remove(alarm));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // TAB 2: FACULTY REMINDERS
  // ----------------------------------------------------
  Widget _buildFacultyRemindersTab(Color primaryColor) {
    final pendingCount = _teacherReminders.where((r) => r['isCompleted'] == false).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        // Summary Header Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PENDING TEACHER ACTION ITEMS', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                    const SizedBox(height: 4),
                    Text('$pendingCount Tasks & Submissions', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B))),
                    const SizedBox(height: 2),
                    const Text('Attendance & grading alerts prioritized', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.fact_check_rounded, color: primaryColor, size: 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Text('UPCOMING FACULTY DEADLINES', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
        const SizedBox(height: 10),

        if (context.isTablet || context.isDesktop)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 160,
            ),
            itemCount: _teacherReminders.length,
            itemBuilder: (context, index) => _buildTeacherReminderCard(_teacherReminders[index], primaryColor),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _teacherReminders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _buildTeacherReminderCard(_teacherReminders[index], primaryColor),
          ),
      ],
    );
  }

  Widget _buildTeacherReminderCard(Map<String, dynamic> reminder, Color primaryColor) {
    final isCompleted = reminder['isCompleted'] as bool;
    final dateTime = reminder['dateTime'] as DateTime;
    final priority = reminder['priority'] as String;
    final priorityColor = priority == 'HIGH' ? const Color(0xFFE74C3C) : (priority == 'MEDIUM' ? const Color(0xFFF39C12) : const Color(0xFF10B981));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isCompleted ? const Color(0xFFE2E8F0) : priorityColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      priority,
                      style: TextStyle(color: priorityColor, fontWeight: FontWeight.w900, fontSize: 10),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      reminder['tag'] as String,
                      style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: isCompleted,
                activeColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                onChanged: (val) {
                  setState(() => reminder['isCompleted'] = val);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),

          Text(
            reminder['title'] as String,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule_rounded, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('EEE, d MMM • hh:mm a').format(dateTime),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              Text(
                '🔔 ${reminder['leadTime']}',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF10B981)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // MODAL: ADD PERIOD ALARM
  // ----------------------------------------------------
  void _showAddPeriodAlarmModal(BuildContext context, Color primaryColor) {
    TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 25);
    String period = 'Period 2 (09:20 AM)';
    String classSection = 'Class 10-A';
    String subject = 'Physics';
    String room = 'Room 204';
    int leadMin = 5;
    final List<String> activeDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    AdaptiveModal.show(
      context: context,
      title: const Text('Set Period Bell Alarm ⏰', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      maxWidth: 550,
      content: StatefulBuilder(
        builder: (modalCtx, setModalState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  final picked = await showTimePicker(context: context, initialTime: selectedTime);
                  if (picked != null) {
                    setModalState(() => selectedTime = picked);
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatTime(selectedTime),
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: primaryColor),
                      ),
                      const SizedBox(height: 4),
                      const Text('Tap to set alarm warning time', style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: period,
                      decoration: InputDecoration(
                        labelText: 'Period',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Period 1 (08:30 AM)', 'Period 2 (09:20 AM)', 'Period 3 (10:15 AM)', 'Period 4 (11:10 AM)', 'Period 5 (01:15 PM)', 'Period 6 (02:05 PM)', 'Dispersal (03:45 PM)'].map((p) {
                        return DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => period = val ?? period),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: classSection,
                      decoration: InputDecoration(
                        labelText: 'Class & Sec',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Class 10-A', 'Class 10-B', 'Class 11-A', 'Class 11-B', 'Class 9-C'].map((c) {
                        return DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => classSection = val ?? classSection),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: subject,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      onChanged: (val) => subject = val,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: room,
                      decoration: InputDecoration(
                        labelText: 'Room / Lab',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      onChanged: (val) => room = val,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: leadMin,
                      decoration: InputDecoration(
                        labelText: 'Warning Lead Time',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: [0, 3, 5, 10].map((m) {
                        return DropdownMenuItem(value: m, child: Text(m == 0 ? 'On Bell Time' : '$m min before bell', style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => leadMin = val ?? leadMin),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _periodAlarms.add({
                        'id': 'TALM-${_periodAlarms.length + 1}',
                        'period': period,
                        'time': selectedTime,
                        'leadMin': leadMin,
                        'classSection': classSection,
                        'subject': subject,
                        'room': room,
                        'days': activeDays,
                        'sound': 'School Bell (Chime)',
                        'vibrate': true,
                        'isEnabled': true,
                        'color': 0xFF10B981,
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Period Alarm set for $period! ⏰'), backgroundColor: const Color(0xFF10B981)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('Save Period Alarm', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ----------------------------------------------------
  // MODAL: ADD FACULTY REMINDER
  // ----------------------------------------------------
  void _showAddTeacherReminderModal(BuildContext context, Color primaryColor) {
    String title = '';
    String tag = 'Attendance';
    String priority = 'HIGH';
    String target = 'Class 10-A';
    String leadTime = '15 min before';
    DateTime targetDate = DateTime.now().add(const Duration(hours: 2));

    AdaptiveModal.show(
      context: context,
      title: const Text('Create Faculty Reminder 🔔', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      maxWidth: 550,
      content: StatefulBuilder(
        builder: (modalCtx, setModalState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Reminder Title / Task',
                  hintText: 'e.g., Submit Term 1 Marks to Academic Office',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                onChanged: (val) => title = val,
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: tag,
                      decoration: InputDecoration(
                        labelText: 'Category Tag',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Attendance', 'Grading', 'Syllabus', 'PTM', 'Exam Duty', 'Admin'].map((t) {
                        return DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => tag = val ?? tag),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['HIGH', 'MEDIUM', 'LOW'].map((p) {
                        return DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => priority = val ?? priority),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: target,
                      decoration: InputDecoration(
                        labelText: 'Target Class / Subject',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      onChanged: (val) => target = val,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: leadTime,
                      decoration: InputDecoration(
                        labelText: 'Alert Notice',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['15 min before', '30 min before', '1 hour before', '1 day before'].map((l) {
                        return DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => leadTime = val ?? leadTime),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (title.trim().isEmpty) title = '$tag Action for $target';
                    setState(() {
                      _teacherReminders.add({
                        'id': 'TREM-${_teacherReminders.length + 1}',
                        'title': title,
                        'tag': tag,
                        'dateTime': targetDate,
                        'priority': priority,
                        'target': target,
                        'leadTime': leadTime,
                        'isCompleted': false,
                        'color': priority == 'HIGH' ? 0xFFE74C3C : 0xFF10B981,
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Faculty Reminder Saved! 🔔'), backgroundColor: Color(0xFF10B981)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('Schedule Faculty Reminder', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
