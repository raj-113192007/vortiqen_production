import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

enum AgendaItemType { classPeriod, meeting, ptm, task, reminder }

class AgendaItem {
  final String id;
  final String time;
  final String title;
  final String subtitle;
  final String roomOrLink;
  final AgendaItemType type;
  final Color color;
  final IconData icon;
  final String? route;
  final DateTime date;
  bool isCompleted;

  AgendaItem({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.roomOrLink,
    required this.type,
    required this.color,
    required this.icon,
    required this.date,
    this.route,
    this.isCompleted = false,
  });
}

class TeacherTask {
  final String id;
  final String title;
  final String category; // 'Correction', 'Lesson Prep', 'Admin', 'PTM Followup'
  final String dueTime;
  final String priority; // 'HIGH', 'MEDIUM', 'NORMAL'
  final DateTime date;
  bool isDone;

  TeacherTask({
    required this.id,
    required this.title,
    required this.category,
    required this.dueTime,
    required this.priority,
    required this.date,
    this.isDone = false,
  });
}

class TeacherCalendarScreen extends StatefulWidget {
  const TeacherCalendarScreen({super.key});

  @override
  State<TeacherCalendarScreen> createState() => _TeacherCalendarScreenState();
}

class _TeacherCalendarScreenState extends State<TeacherCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  String _selectedFilter = 'All'; // 'All', 'Classes', 'Meetings & PTM', 'To-Do', 'Reminders'
  final _newTaskController = TextEditingController();

  // Teacher Daily Energy & Mood Logs keyed by 'yyyy-MM-dd'
  final Map<String, Map<String, dynamic>> _teacherVibes = {
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 3))): {
      'emoji': '⚡',
      'label': 'High Energy & Productive',
      'color': 0xFF2ECC71,
      'bgColor': 0xFFE8F8F0,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 2))): {
      'emoji': '☕',
      'label': 'Steady & Focused',
      'color': 0xFFF1C40F,
      'bgColor': 0xFFFEF9E7,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1))): {
      'emoji': '📚',
      'label': 'Heavy Evaluation Day',
      'color': 0xFFE67E22,
      'bgColor': 0xFFFBEEE6,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now()): {
      'emoji': '⚡',
      'label': 'High Energy & Productive',
      'color': 0xFF2ECC71,
      'bgColor': 0xFFE8F8F0,
    },
  };

  late List<AgendaItem> _agendaList;
  late List<TeacherTask> _taskList;

  @override
  void initState() {
    super.initState();
    _agendaList = [
      AgendaItem(
        id: 'ag_1',
        time: '08:30 - 09:15 AM',
        title: 'Period 1: Class 10-A • Physics',
        subtitle: 'Chapter 2: Atmospheric Refraction & Tyndall Effect (Derivations & Diagrams)',
        roomOrLink: 'Room 204',
        type: AgendaItemType.classPeriod,
        color: const Color(0xFF6C5CE7),
        icon: Icons.auto_stories_rounded,
        route: '/daily-lesson-planner',
        date: DateTime.now(),
        isCompleted: true,
      ),
      AgendaItem(
        id: 'ag_2',
        time: '09:15 - 10:00 AM',
        title: 'Period 2: Class 9-B • Mathematics',
        subtitle: 'Quadratic Polynomials: Splitting Middle Term Method (Exercise 2.4)',
        roomOrLink: 'Room 108',
        type: AgendaItemType.classPeriod,
        color: const Color(0xFF0984E3),
        icon: Icons.calculate_rounded,
        route: '/daily-lesson-planner',
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_3',
        time: '10:15 - 10:45 AM',
        title: '☕ Faculty Tea Break & Lesson Prep',
        subtitle: 'Review Lab Handouts & unit test question bank for Class 10',
        roomOrLink: 'Senior Staff Room (Desk 4)',
        type: AgendaItemType.task,
        color: const Color(0xFF64748B),
        icon: Icons.coffee_rounded,
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_4',
        time: '11:00 - 11:45 AM',
        title: 'Period 4: Class 10-A • Physics Practical',
        subtitle: 'Lab Experiment: Refraction through Glass Slab & Snell\'s Law Verification',
        roomOrLink: 'Physics Lab Block B',
        type: AgendaItemType.classPeriod,
        color: const Color(0xFF00B894),
        icon: Icons.biotech_rounded,
        route: '/daily-lesson-planner',
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_5',
        time: '01:30 - 01:50 PM',
        title: '🤝 PTM Slot: Parent of Aarav Sharma (Class 10-A)',
        subtitle: 'Discussion on Midterm Exam Strategy & Physics Numerical Improvement',
        roomOrLink: 'Conference Room 2 (In-Person)',
        type: AgendaItemType.ptm,
        color: const Color(0xFFE17055),
        icon: Icons.groups_rounded,
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_6',
        time: '02:00 - 02:20 PM',
        title: '🤝 PTM Slot: Parent of Tanya Gupta (Class 9-B)',
        subtitle: 'Quarterly Attendance review & Math Olympiad participation consent',
        roomOrLink: 'Google Meet (Online Video Call)',
        type: AgendaItemType.ptm,
        color: const Color(0xFFE17055),
        icon: Icons.videocam_rounded,
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_7',
        time: '03:15 - 04:00 PM',
        title: '🏢 Science Department Faculty Sync',
        subtitle: 'Exam datesheet finalization, laboratory consumables audit & Term 2 blueprint',
        roomOrLink: 'Main Auditorium / Meeting Hall A',
        type: AgendaItemType.meeting,
        color: const Color(0xFFFD79A8),
        icon: Icons.meeting_room_rounded,
        date: DateTime.now(),
        isCompleted: false,
      ),
      AgendaItem(
        id: 'ag_8',
        time: '05:00 PM',
        title: '🔔 Reminder: Submit Term-1 Practical Question Bank',
        subtitle: 'Send finalized softcopy to Academic Coordinator',
        roomOrLink: 'Faculty Portal',
        type: AgendaItemType.reminder,
        color: const Color(0xFF8B5CF6),
        icon: Icons.notifications_active_rounded,
        date: DateTime.now().add(const Duration(days: 1)),
        isCompleted: false,
      ),
    ];

    _taskList = [
      TeacherTask(
        id: 't_1',
        title: 'Grade 38 Homework Notebooks for Class 10-A (Quadratic Equations)',
        category: 'Correction',
        dueTime: '02:30 PM',
        priority: 'HIGH',
        date: DateTime.now(),
        isDone: true,
      ),
      TeacherTask(
        id: 't_2',
        title: 'Upload Midterm Physics Practical marksheet in Gradebook',
        category: 'Admin',
        dueTime: '04:30 PM',
        priority: 'HIGH',
        date: DateTime.now(),
        isDone: false,
      ),
      TeacherTask(
        id: 't_3',
        title: 'Prepare 10 MCQ questions for Unit 2 Quiz generator',
        category: 'Lesson Prep',
        dueTime: '10:00 AM',
        priority: 'MEDIUM',
        date: DateTime.now().add(const Duration(days: 1)),
        isDone: false,
      ),
      TeacherTask(
        id: 't_4',
        title: 'Call parent of Rohan Kumar regarding consecutive 3 days absence',
        category: 'PTM Followup',
        dueTime: '05:00 PM',
        priority: 'NORMAL',
        date: DateTime.now(),
        isDone: false,
      ),
    ];
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  void _addNewTask({DateTime? targetDate}) {
    if (_newTaskController.text.trim().isEmpty) return;
    final date = targetDate ?? _selectedDate;

    setState(() {
      _taskList.insert(
        0,
        TeacherTask(
          id: 't_${DateTime.now().millisecondsSinceEpoch}',
          title: _newTaskController.text.trim(),
          category: 'Lesson Prep',
          dueTime: '05:00 PM',
          priority: 'HIGH',
          date: date,
          isDone: false,
        ),
      );
      _newTaskController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task added for ${DateFormat('dd MMMM').format(date)}! ✍️'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showScheduleMeetingModal({DateTime? lockedDate}) {
    final date = lockedDate ?? _selectedDate;
    final titleController = TextEditingController(text: 'Parent Meeting: Discussion on Academic Progress');
    final roomController = TextEditingController(text: 'Meeting Room 2 / Online Meet');
    final timeController = TextEditingController(text: '02:30 - 02:50 PM');
    String meetingType = 'PTM';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_available_rounded, color: Color(0xFF6C5CE7), size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Schedule Meeting / PTM Slot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    Text('For ${DateFormat('EEEE, dd MMMM yyyy').format(date)}', style: const TextStyle(fontSize: 11, color: Color(0xFF6C5CE7), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Meeting Category:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('🤝 Parent PTM Slot'),
                          selected: meetingType == 'PTM',
                          onSelected: (val) {
                            if (val) setModalState(() => meetingType = 'PTM');
                          },
                          selectedColor: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text('🏢 Faculty Sync'),
                          selected: meetingType == 'Faculty',
                          onSelected: (val) {
                            if (val) setModalState(() => meetingType = 'Faculty');
                          },
                          selectedColor: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: meetingType == 'PTM' ? 'Student / Parent Meeting Subject' : 'Meeting Agenda & Department',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: timeController,
                          decoration: InputDecoration(
                            labelText: 'Time Slot',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: roomController,
                          decoration: InputDecoration(
                            labelText: 'Room / Video Link',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton.icon(
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;

                setState(() {
                  _agendaList.add(
                    AgendaItem(
                      id: 'ag_custom_${DateTime.now().millisecondsSinceEpoch}',
                      time: timeController.text.trim(),
                      title: meetingType == 'PTM' ? '🤝 ${titleController.text.trim()}' : '🏢 ${titleController.text.trim()}',
                      subtitle: 'Scheduled on ${DateFormat('dd MMM').format(date)}',
                      roomOrLink: roomController.text.trim(),
                      type: meetingType == 'PTM' ? AgendaItemType.ptm : AgendaItemType.meeting,
                      color: meetingType == 'PTM' ? const Color(0xFFE17055) : const Color(0xFFFD79A8),
                      icon: meetingType == 'PTM' ? Icons.groups_rounded : Icons.meeting_room_rounded,
                      date: date,
                    ),
                  );
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Scheduled "${titleController.text}" on ${DateFormat('dd MMM').format(date)}! 📅'),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text('Confirm & Block Slot'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReminderModal({required DateTime lockedDate}) {
    final titleController = TextEditingController();
    final noteController = TextEditingController();
    TimeOfDay selectedTime = const TimeOfDay(hour: 16, minute: 0);

    AdaptiveModal.show(
      context: context,
      maxWidth: 480,
      title: Text('Set Teacher Reminder for ${DateFormat('dd MMMM').format(lockedDate)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Reminder Title',
                  hintText: 'e.g. Submit Midterm Physics Practical Grades',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Additional Notes / Instructions',
                  hintText: 'e.g. Include student signatures sheet',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showTimePicker(context: context, initialTime: selectedTime);
                  if (picked != null) {
                    setModalState(() => selectedTime = picked);
                  }
                },
                icon: const Icon(Icons.alarm_rounded, size: 18, color: Color(0xFF8B5CF6)),
                label: Text('Alert Time: ${selectedTime.format(context)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (titleController.text.trim().isEmpty) return;

            setState(() {
              _agendaList.add(
                AgendaItem(
                  id: 'rem_${DateTime.now().millisecondsSinceEpoch}',
                  time: selectedTime.format(context),
                  title: '🔔 ${titleController.text.trim()}',
                  subtitle: noteController.text.trim().isEmpty ? 'Teacher Reminder' : noteController.text.trim(),
                  roomOrLink: 'Faculty Desk',
                  type: AgendaItemType.reminder,
                  color: const Color(0xFF8B5CF6),
                  icon: Icons.notifications_active_rounded,
                  date: lockedDate,
                ),
              );
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Reminder added for ${DateFormat('dd MMMM').format(lockedDate)}! 🔔'),
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B5CF6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Save Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  void _showLogVibeModal({required DateTime lockedDate}) {
    final dateKey = DateFormat('yyyy-MM-dd').format(lockedDate);
    final vibes = [
      {'emoji': '⚡', 'label': 'High Energy & Productive', 'color': 0xFF2ECC71, 'bgColor': 0xFFE8F8F0},
      {'emoji': '☕', 'label': 'Steady & Focused', 'color': 0xFFF1C40F, 'bgColor': 0xFFFEF9E7},
      {'emoji': '📚', 'label': 'Heavy Evaluation & Marking', 'color': 0xFFE67E22, 'bgColor': 0xFFFBEEE6},
      {'emoji': '😴', 'label': 'Exhausted & Need Rest', 'color': 0xFF9B59B6, 'bgColor': 0xFFF4ECF7},
    ];

    AdaptiveModal.show(
      context: context,
      maxWidth: 460,
      title: Text('Faculty Day Vibe for ${DateFormat('dd MMM').format(lockedDate)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: vibes.map((v) {
          final isCurrent = _teacherVibes[dateKey]?['label'] == v['label'];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isCurrent ? Color(v['bgColor'] as int) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isCurrent ? Color(v['color'] as int) : const Color(0xFFE2E8F0),
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: ListTile(
              onTap: () {
                setState(() => _teacherVibes[dateKey] = v);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged ${v['emoji']} ${v['label']}!'),
                    backgroundColor: Color(v['color'] as int),
                  ),
                );
              },
              leading: Text(v['emoji'] as String, style: const TextStyle(fontSize: 22)),
              title: Text(v['label'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              trailing: isCurrent ? Icon(Icons.check_circle_rounded, color: Color(v['color'] as int)) : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<AgendaItem> get _filteredAgenda {
    final listForDate = _agendaList.where((a) {
      return a.date.year == _selectedDate.year &&
          a.date.month == _selectedDate.month &&
          a.date.day == _selectedDate.day;
    }).toList();

    if (_selectedFilter == 'Classes') {
      return listForDate.where((a) => a.type == AgendaItemType.classPeriod).toList();
    }
    if (_selectedFilter == 'Meetings & PTM') {
      return listForDate.where((a) => a.type == AgendaItemType.meeting || a.type == AgendaItemType.ptm).toList();
    }
    if (_selectedFilter == 'Reminders') {
      return listForDate.where((a) => a.type == AgendaItemType.reminder).toList();
    }
    if (_selectedFilter == 'To-Do') {
      return listForDate.where((a) => a.type == AgendaItemType.task).toList();
    }
    return listForDate;
  }

  @override
  Widget build(BuildContext context) {
    final dateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final dayVibe = _teacherVibes[dateKey];

    final dailyTasks = _taskList.where((t) {
      return t.date.year == _selectedDate.year &&
          t.date.month == _selectedDate.month &&
          t.date.day == _selectedDate.day;
    }).toList();

    final completedTasks = dailyTasks.where((t) => t.isDone).length;
    final double taskCompletionProgress = dailyTasks.isEmpty ? 0 : (completedTasks / dailyTasks.length);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Faculty Agenda, Planner & Mood Calendar',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm_on_rounded, color: Color(0xFF6C5CE7)),
            tooltip: 'Teacher Alarms & Bell Schedules',
            onPressed: () => context.push('/teacher-alarms-reminders'),
          ),
          ElevatedButton.icon(
            onPressed: () => _showScheduleMeetingModal(lockedDate: _selectedDate),
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text('Schedule Meeting'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. INTERACTIVE MONTHLY CALENDAR WITH MOOD / STATUS ICONS & CAPSULE SELECTION
            _buildMonthCalendarCard(),
            const SizedBox(height: 16),

            // 2. SELECTED DATE ACTION COCKPIT
            _buildDateActionCockpit(dayVibe, dailyTasks.length),
            const SizedBox(height: 20),

            // 3. SUMMARY HUD BANNER
            _buildSummaryHudBanner(completedTasks, dailyTasks.length),
            const SizedBox(height: 24),

            // 4. MAIN TWO COLUMN LAYOUT: SCHEDULE & TO-DO
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 900;

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Daily Agenda Timeline
                      Expanded(
                        flex: 6,
                        child: _buildAgendaTimelineSection(),
                      ),
                      const SizedBox(width: 20),
                      // Right Column: Teacher To-Do List
                      Expanded(
                        flex: 4,
                        child: _buildTodoListSection(taskCompletionProgress, completedTasks, dailyTasks),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    _buildAgendaTimelineSection(),
                    const SizedBox(height: 24),
                    _buildTodoListSection(taskCompletionProgress, completedTasks, dailyTasks),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // MONTHLY CALENDAR CARD (INSPIRED BY SCREENSHOT)
  // -------------------------------------------------------------
  Widget _buildMonthCalendarCard() {
    final daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(_currentMonth),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, letterSpacing: -0.3, color: Color(0xFF1E293B)),
                  ),
                  const Text('Click any date to set tasks, reminders or meetings', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: () {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Weekday header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'].map((day) {
              final isWeekend = day == 'Su' || day == 'Sa';
              return SizedBox(
                width: 36,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isWeekend ? const Color(0xFFE17055) : const Color(0xFF94A3B8)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // Day Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 6,
              childAspectRatio: 0.78,
            ),
            itemCount: startingWeekday + daysInMonth,
            itemBuilder: (context, index) {
              if (index < startingWeekday) return const SizedBox.shrink();

              final day = index - startingWeekday + 1;
              final thisDate = DateTime(_currentMonth.year, _currentMonth.month, day);
              final dateKey = DateFormat('yyyy-MM-dd').format(thisDate);

              final isSelected = _selectedDate.year == thisDate.year &&
                  _selectedDate.month == thisDate.month &&
                  _selectedDate.day == thisDate.day;

              final isToday = DateTime.now().year == thisDate.year &&
                  DateTime.now().month == thisDate.month &&
                  DateTime.now().day == thisDate.day;

              final vibe = _teacherVibes[dateKey];
              final eventsCount = _agendaList.where((a) => a.date.year == thisDate.year && a.date.month == thisDate.month && a.date.day == thisDate.day).length;

              return InkWell(
                onTap: () => setState(() => _selectedDate = thisDate),
                borderRadius: BorderRadius.circular(22),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFFF7ED)
                        : isToday
                            ? const Color(0xFF6C5CE7).withValues(alpha: 0.08)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    border: isSelected
                        ? Border.all(color: const Color(0xFFD97706), width: 2)
                        : isToday
                            ? Border.all(color: const Color(0xFF6C5CE7), width: 1.2)
                            : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFD97706).withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: isSelected || isToday ? FontWeight.w900 : FontWeight.w700,
                          fontSize: 13,
                          color: isSelected
                              ? const Color(0xFF92400E)
                              : isToday
                                  ? const Color(0xFF6C5CE7)
                                  : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),

                      if (vibe != null)
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(vibe['color'] as int),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(vibe['emoji'] as String, style: const TextStyle(fontSize: 13)),
                        )
                      else if (eventsCount > 0)
                        Container(
                          width: 26,
                          height: 26,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C5CE7),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$eventsCount',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // SELECTED DATE ACTION COCKPIT
  // -------------------------------------------------------------
  Widget _buildDateActionCockpit(Map<String, dynamic>? vibe, int tasksCount) {
    final formatted = DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_available_rounded, color: Color(0xFF6C5CE7), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatted,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Selected Date Planning & Immediate Actions',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              if (vibe != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(vibe['bgColor'] as int),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(vibe['color'] as int).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Text(vibe['emoji'] as String, style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        vibe['label'] as String,
                        style: TextStyle(color: Color(vibe['color'] as int), fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 14),

          // 5 Action Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCockpitBtn(
                icon: Icons.add_task_rounded,
                label: '+ Teacher Task',
                color: const Color(0xFF0984E3),
                bgColor: const Color(0xFFEBF5FB),
                onTap: () {
                  _newTaskController.text = 'Grade Class 10 Physics Papers';
                  _addNewTask(targetDate: _selectedDate);
                },
              ),
              _buildCockpitBtn(
                icon: Icons.notifications_active_rounded,
                label: '🔔 Reminder',
                color: const Color(0xFF8B5CF6),
                bgColor: const Color(0xFFF5F3FF),
                onTap: () => _showAddReminderModal(lockedDate: _selectedDate),
              ),
              _buildCockpitBtn(
                icon: Icons.groups_rounded,
                label: '🤝 PTM Slot',
                color: const Color(0xFFE17055),
                bgColor: const Color(0xFFFDF2E9),
                onTap: () => _showScheduleMeetingModal(lockedDate: _selectedDate),
              ),
              _buildCockpitBtn(
                icon: Icons.meeting_room_rounded,
                label: '🏢 Faculty Sync',
                color: const Color(0xFFFD79A8),
                bgColor: const Color(0xFFFDF2E9),
                onTap: () => _showScheduleMeetingModal(lockedDate: _selectedDate),
              ),
              _buildCockpitBtn(
                icon: Icons.mood_rounded,
                label: '☕ Faculty Vibe',
                color: const Color(0xFF00B894),
                bgColor: const Color(0xFFE8F8F5),
                onTap: () => _showLogVibeModal(lockedDate: _selectedDate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCockpitBtn({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: color),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // SUMMARY HUD BANNER
  // -------------------------------------------------------------
  Widget _buildSummaryHudBanner(int completedTasks, int totalTasks) {
    final list = _filteredAgenda;
    final periods = list.where((a) => a.type == AgendaItemType.classPeriod).length;
    final ptms = list.where((a) => a.type == AgendaItemType.ptm).length;
    final meetings = list.where((a) => a.type == AgendaItemType.meeting).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PulsingLiveDot(size: 4, pulseScale: 2.2, color: Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    Text(
                      'WORKSPACE SUMMARY • ${DateFormat('dd MMMM yyyy').format(_selectedDate).toUpperCase()}',
                      style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$periods Teaching Periods • $ptms PTM Slots • $meetings Faculty Sync',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  list.isEmpty
                      ? 'No scheduled classes or meetings for this date.'
                      : 'Next upcoming: ${list.first.title} at ${list.first.time}',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Column(
              children: [
                Text(
                  '$completedTasks/$totalTasks',
                  style: const TextStyle(color: Color(0xFF10B981), fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Text('Tasks Done', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendaTimelineSection() {
    final list = _filteredAgenda;

    return Container(
      padding: const EdgeInsets.all(20),
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
                'Schedule for ${DateFormat('dd MMM').format(_selectedDate)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
              ),
              Text(
                '${list.length} Events',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Filter chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Classes', 'Meetings & PTM', 'Reminders', 'To-Do'].map((f) {
              final isSel = _selectedFilter == f;
              return ChoiceChip(
                label: Text(f),
                selected: isSel,
                onSelected: (val) {
                  if (val) setState(() => _selectedFilter = f);
                },
                selectedColor: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                labelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: isSel ? FontWeight.w800 : FontWeight.w600,
                  color: isSel ? const Color(0xFF6C5CE7) : const Color(0xFF64748B),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),

          if (list.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Icon(Icons.event_available, size: 40, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 8),
                  Text('No events matching "$_selectedFilter" on this date', style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = list[index];
                return _buildAgendaItemCard(item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAgendaItemCard(AgendaItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.isCompleted ? const Color(0xFFF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.color.withValues(alpha: item.isCompleted ? 0.2 : 0.4),
          width: item.isCompleted ? 1 : 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.time,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: item.color),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 13, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(item.roomOrLink, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E293B),
                    decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.3),
                ),
                if (item.route != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => context.push(item.route!),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_calendar_rounded, size: 14, color: Color(0xFF6C5CE7)),
                              SizedBox(width: 4),
                              Text('Lesson Plan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => context.push('/mark-attendance'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.checklist_rounded, size: 14, color: Color(0xFF10B981)),
                              SizedBox(width: 4),
                              Text('Roll Call', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF10B981))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoListSection(double progress, int completed, List<TeacherTask> dailyTasks) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              const Text(
                'Teacher To-Do & Tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${(progress * 100).toInt()}% Done',
                  style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 16),

          // QUICK ADD TASK INPUT
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newTaskController,
                  onSubmitted: (_) => _addNewTask(targetDate: _selectedDate),
                  decoration: InputDecoration(
                    hintText: 'Add task for ${DateFormat('dd MMM').format(_selectedDate)}...',
                    hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _addNewTask(targetDate: _selectedDate),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Icon(Icons.add_rounded, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (dailyTasks.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              alignment: Alignment.center,
              child: const Text('No tasks pending for this date.', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dailyTasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final task = dailyTasks[index];

                final Color priorityColor = task.priority == 'HIGH'
                    ? const Color(0xFFEF4444)
                    : task.priority == 'MEDIUM'
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFF10B981);

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: task.isDone ? const Color(0xFFF8FAFC) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: task.isDone ? const Color(0xFFE2E8F0) : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => task.isDone = !task.isDone);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: task.isDone ? const Color(0xFF10B981) : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: task.isDone ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
                              width: 1.5,
                            ),
                          ),
                          child: task.isDone ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: task.isDone ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    task.priority,
                                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: priorityColor),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(task.dueTime, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                              ],
                            ),
                          ],
                        ),
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
}

