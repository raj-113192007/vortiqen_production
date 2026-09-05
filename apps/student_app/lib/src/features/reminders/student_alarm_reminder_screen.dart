import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class StudentAlarmReminderScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;
  const StudentAlarmReminderScreen({super.key, this.initialTabIndex = 0});

  @override
  ConsumerState<StudentAlarmReminderScreen> createState() => _StudentAlarmReminderScreenState();
}

class _StudentAlarmReminderScreenState extends ConsumerState<StudentAlarmReminderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _alarms = [
    {
      'id': 'ALM-1',
      'time': const TimeOfDay(hour: 6, minute: 30),
      'label': 'Morning School Bus Wake-up',
      'category': 'Daily Routine',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      'sound': 'Bright Sunrise (Chime)',
      'vibrate': true,
      'snoozeMin': 5,
      'isEnabled': true,
      'color': 0xFF0984E3,
    },
    {
      'id': 'ALM-2',
      'time': const TimeOfDay(hour: 8, minute: 20),
      'label': 'Morning Assembly & Period 1 Prep',
      'category': 'Class Schedule',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'sound': 'School Bell (Gentle)',
      'vibrate': true,
      'snoozeMin': 5,
      'isEnabled': true,
      'color': 0xFF6C5CE7,
    },
    {
      'id': 'ALM-3',
      'time': const TimeOfDay(hour: 17, minute: 0),
      'label': 'Homework & Math Self-Study Block',
      'category': 'Study Focus',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'sound': 'Focus Binaural Chime',
      'vibrate': false,
      'snoozeMin': 10,
      'isEnabled': true,
      'color': 0xFF00B894,
    },
    {
      'id': 'ALM-4',
      'time': const TimeOfDay(hour: 20, minute: 30),
      'label': 'Daily AI Quiz Challenge Arena',
      'category': 'Exam Prep',
      'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      'sound': 'Arcade Synth Alert',
      'vibrate': true,
      'snoozeMin': 5,
      'isEnabled': false,
      'color': 0xFFE17055,
    },
  ];

  final List<Map<String, dynamic>> _reminders = [
    {
      'id': 'REM-1',
      'title': 'Physics Ray Optics Homework Submission',
      'subject': 'Physics',
      'dateTime': DateTime.now().add(const Duration(hours: 14)),
      'priority': 'HIGH',
      'category': 'Assignment',
      'leadTime': '1 hour before',
      'isCompleted': false,
      'color': 0xFFE74C3C,
    },
    {
      'id': 'REM-2',
      'title': 'Unit 2 Organic Chemistry Solved PYQs Practice',
      'subject': 'Chemistry',
      'dateTime': DateTime.now().add(const Duration(days: 1, hours: 4)),
      'priority': 'MEDIUM',
      'category': 'PYQs',
      'leadTime': '30 min before',
      'isCompleted': false,
      'color': 0xFFF39C12,
    },
    {
      'id': 'REM-3',
      'title': 'Quarter 2 School Tuition Fee Due Date',
      'subject': 'School Admin',
      'dateTime': DateTime.now().add(const Duration(days: 5)),
      'priority': 'HIGH',
      'category': 'Fee Due',
      'leadTime': '1 day before',
      'isCompleted': false,
      'color': 0xFF6C5CE7,
    },
    {
      'id': 'REM-4',
      'title': 'Parent-Teacher Meeting (Room 204)',
      'subject': 'Academics',
      'dateTime': DateTime.now().add(const Duration(days: 9, hours: 2)),
      'priority': 'LOW',
      'category': 'Event',
      'leadTime': '2 hours before',
      'isCompleted': false,
      'color': 0xFF00B894,
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
    final primaryColor = AppColors.studentPrimary;

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
              child: Icon(Icons.alarm_on_rounded, color: primaryColor, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'Alarms & Smart Reminders',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF1E293B)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: Color(0xFF64748B), size: 20),
            tooltip: 'Notification & Tone Settings',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alarm sounds and vibration preferences active 🔊')),
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
                  Text('Active Alarms (${_alarms.where((a) => a['isEnabled'] == true).length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_active_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text('Task Reminders (${_reminders.where((r) => r['isCompleted'] == false).length})'),
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
            _buildAlarmsTab(primaryColor),
            _buildRemindersTab(primaryColor),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: Text(
          _tabController.index == 0 ? 'New Alarm' : 'New Reminder',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddAlarmModal(context, primaryColor);
          } else {
            _showAddReminderModal(context, primaryColor);
          }
        },
      ),
    );
  }

  // ----------------------------------------------------
  // TAB 1: ALARMS
  // ----------------------------------------------------
  Widget _buildAlarmsTab(Color primaryColor) {
    final nextAlarm = _alarms.firstWhere((a) => a['isEnabled'] == true, orElse: () => _alarms.first);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        // Top Countdown Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0984E3), Color(0xFF6C5CE7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: const Color(0xFF0984E3).withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6)),
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
                child: const Icon(Icons.access_alarm_rounded, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NEXT SCHEDULED ALARM', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.1)),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(nextAlarm['time'] as TimeOfDay),
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      nextAlarm['label'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Simulating Alarm: ${nextAlarm['label']} ⏰ Ringing...'),
                      backgroundColor: const Color(0xFF0984E3),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                child: const Text('Test Ring', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Quick Preset Alarms
        const Text('QUICK PRESET ALARMS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPresetChip('+ 15m Power Nap', const TimeOfDay(hour: 16, minute: 30), primaryColor),
              _buildPresetChip('+ 45m Pomodoro Study', const TimeOfDay(hour: 17, minute: 45), primaryColor),
              _buildPresetChip('+ School Bus Alert (06:45 AM)', const TimeOfDay(hour: 6, minute: 45), primaryColor),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Alarm List
        const Text('ALL ACTIVE & SAVED ALARMS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
        const SizedBox(height: 10),

        if (context.isTablet || context.isDesktop)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 180,
            ),
            itemCount: _alarms.length,
            itemBuilder: (context, index) => _buildAlarmCard(_alarms[index], primaryColor),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _alarms.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _buildAlarmCard(_alarms[index], primaryColor),
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
            _alarms.add({
              'id': 'ALM-${_alarms.length + 1}',
              'time': time,
              'label': label.replaceAll('+', '').trim(),
              'category': 'Quick Preset',
              'days': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
              'sound': 'Standard Bell',
              'vibrate': true,
              'snoozeMin': 5,
              'isEnabled': true,
              'color': 0xFF0984E3,
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Alarm "$label" added & activated! ⏰'), backgroundColor: const Color(0xFF00B894)),
          );
        },
      ),
    );
  }

  Widget _buildAlarmCard(Map<String, dynamic> alarm, Color primaryColor) {
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
            blurRadius: 10,
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
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isEnabled ? cardColor : const Color(0xFF94A3B8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    alarm['category'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isEnabled ? cardColor : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              Switch(
                value: isEnabled,
                activeThumbColor: cardColor,
                onChanged: (val) {
                  setState(() => alarm['isEnabled'] = val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(val ? 'Alarm activated for ${_formatTime(time)}' : 'Alarm disabled'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
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
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: isEnabled ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• Snooze: ${alarm['snoozeMin']}m',
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),

          Text(
            alarm['label'] as String,
            style: TextStyle(
              fontSize: 13,
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
                children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].asMap().entries.map((entry) {
                  final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
                  setState(() => _alarms.remove(alarm));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Alarm removed'), duration: Duration(seconds: 1)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // TAB 2: SMART REMINDERS
  // ----------------------------------------------------
  Widget _buildRemindersTab(Color primaryColor) {
    final pendingCount = _reminders.where((r) => r['isCompleted'] == false).length;
    final highPriority = _reminders.where((r) => r['priority'] == 'HIGH' && r['isCompleted'] == false).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        // Summary Card
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
                    const Text('PENDING REMINDERS', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                    const SizedBox(height: 4),
                    Text('$pendingCount Active Tasks', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B))),
                    const SizedBox(height: 2),
                    Text('$highPriority High Priority alerts due soon', style: const TextStyle(color: Color(0xFFE74C3C), fontSize: 11, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.notifications_active_rounded, color: Color(0xFF6C5CE7), size: 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Text('UPCOMING REMINDERS & DEADLINES', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 1.0)),
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
            itemCount: _reminders.length,
            itemBuilder: (context, index) => _buildReminderCard(_reminders[index], primaryColor),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reminders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _buildReminderCard(_reminders[index], primaryColor),
          ),
      ],
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder, Color primaryColor) {
    final isCompleted = reminder['isCompleted'] as bool;
    final dateTime = reminder['dateTime'] as DateTime;
    final priority = reminder['priority'] as String;
    final priorityColor = priority == 'HIGH' ? const Color(0xFFE74C3C) : (priority == 'MEDIUM' ? const Color(0xFFF39C12) : const Color(0xFF00B894));

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
                      reminder['category'] as String,
                      style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: isCompleted,
                activeColor: const Color(0xFF00B894),
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
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF0984E3)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // MODAL: ADD NEW ALARM
  // ----------------------------------------------------
  void _showAddAlarmModal(BuildContext context, Color primaryColor) {
    TimeOfDay selectedTime = const TimeOfDay(hour: 7, minute: 0);
    String alarmLabel = 'Morning Study Session';
    String sound = 'Bright Sunrise (Chime)';
    int snooze = 5;
    bool vibrate = true;
    final List<String> activeDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    AdaptiveModal.show(
      context: context,
      title: const Text('Set New Alarm ⏰', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      maxWidth: 550,
      content: StatefulBuilder(
        builder: (modalCtx, setModalState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Big Time Picker Button
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
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _formatTime(selectedTime),
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: primaryColor),
                      ),
                      const SizedBox(height: 4),
                      const Text('Tap to change alarm time', style: TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Alarm Label
              TextFormField(
                initialValue: alarmLabel,
                decoration: InputDecoration(
                  labelText: 'Alarm Label / Subject',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                onChanged: (val) => alarmLabel = val,
              ),
              const SizedBox(height: 16),

              // Repeat Days
              const Text('REPEAT DAYS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B))),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d) {
                  final isSelected = activeDays.contains(d);
                  return FilterChip(
                    label: Text(d, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : const Color(0xFF64748B))),
                    selected: isSelected,
                    selectedColor: primaryColor,
                    backgroundColor: const Color(0xFFF1F5F9),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onSelected: (selected) {
                      setModalState(() {
                        if (selected) {
                          activeDays.add(d);
                        } else {
                          activeDays.remove(d);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Sound Tone Picker & Snooze
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: sound,
                      decoration: InputDecoration(
                        labelText: 'Ringtone Sound',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Bright Sunrise (Chime)', 'School Bell (Gentle)', 'Focus Binaural Chime', 'Arcade Synth Alert', 'Digital Beep'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => sound = val ?? sound),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: snooze,
                      decoration: InputDecoration(
                        labelText: 'Snooze',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: [3, 5, 10, 15].map((s) {
                        return DropdownMenuItem(value: s, child: Text('$s Minutes', style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => snooze = val ?? snooze),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Vibrate Switch
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Vibration on ring', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                value: vibrate,
                activeThumbColor: primaryColor,
                onChanged: (val) => setModalState(() => vibrate = val),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _alarms.add({
                        'id': 'ALM-${_alarms.length + 1}',
                        'time': selectedTime,
                        'label': alarmLabel,
                        'category': 'Custom Alarm',
                        'days': activeDays,
                        'sound': sound,
                        'vibrate': vibrate,
                        'snoozeMin': snooze,
                        'isEnabled': true,
                        'color': 0xFF0984E3,
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alarm set for ${_formatTime(selectedTime)}! ⏰'), backgroundColor: const Color(0xFF00B894)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('Save & Enable Alarm', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ----------------------------------------------------
  // MODAL: ADD NEW REMINDER
  // ----------------------------------------------------
  void _showAddReminderModal(BuildContext context, Color primaryColor) {
    String title = '';
    String subject = 'Mathematics';
    String category = 'Assignment';
    String priority = 'HIGH';
    String leadTime = '1 hour before';
    DateTime targetDate = DateTime.now().add(const Duration(days: 1));

    AdaptiveModal.show(
      context: context,
      title: const Text('Create Smart Reminder 🔔', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      maxWidth: 550,
      content: StatefulBuilder(
        builder: (modalCtx, setModalState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Reminder Title',
                  hintText: 'e.g., Submit Chemistry Lab Report',
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
                      initialValue: category,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Assignment', 'PYQs', 'Exam Study', 'Fee Due', 'Class Prep', 'General'].map((c) {
                        return DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => category = val ?? category),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: InputDecoration(
                        labelText: 'Priority Level',
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
                    child: DropdownButtonFormField<String>(
                      initialValue: subject,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Mathematics', 'Physics', 'Chemistry', 'Biology', 'Computer Science', 'English', 'Social Science', 'School Admin'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => subject = val ?? subject),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: leadTime,
                      decoration: InputDecoration(
                        labelText: 'Alert Time',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['15 min before', '30 min before', '1 hour before', '2 hours before', '1 day before'].map((l) {
                        return DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(fontSize: 12)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => leadTime = val ?? leadTime),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date Picker Tile
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: targetDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setModalState(() => targetDate = picked);
                  }
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event_rounded, color: Color(0xFF64748B), size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'Target Date: ${DateFormat('EEE, d MMM yyyy').format(targetDate)}',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B)),
                      ),
                      const Spacer(),
                      const Text('Change', style: TextStyle(color: Color(0xFF0984E3), fontWeight: FontWeight.w800, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (title.trim().isEmpty) title = '$subject $category Deadline';
                    setState(() {
                      _reminders.add({
                        'id': 'REM-${_reminders.length + 1}',
                        'title': title,
                        'subject': subject,
                        'dateTime': targetDate,
                        'priority': priority,
                        'category': category,
                        'leadTime': leadTime,
                        'isCompleted': false,
                        'color': priority == 'HIGH' ? 0xFFE74C3C : 0xFFF39C12,
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Smart Reminder Scheduled! 🔔'), backgroundColor: Color(0xFF00B894)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('Schedule Reminder', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
