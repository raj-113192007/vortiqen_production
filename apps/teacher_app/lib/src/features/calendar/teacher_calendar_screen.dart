import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

enum AgendaItemType { classPeriod, meeting, ptm, task }

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
  bool isDone;

  TeacherTask({
    required this.id,
    required this.title,
    required this.category,
    required this.dueTime,
    required this.priority,
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
  String _selectedFilter = 'All'; // 'All', 'Classes', 'Meetings & PTM', 'To-Do'
  final _newTaskController = TextEditingController();

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
        isCompleted: false,
      ),
    ];

    _taskList = [
      TeacherTask(
        id: 't_1',
        title: 'Grade 38 Homework Notebooks for Class 10-A (Quadratic Equations)',
        category: 'Correction',
        dueTime: 'Today, 02:30 PM',
        priority: 'HIGH',
        isDone: true,
      ),
      TeacherTask(
        id: 't_2',
        title: 'Upload Midterm Physics Practical marksheet in Gradebook',
        category: 'Admin',
        dueTime: 'Today, 04:30 PM',
        priority: 'HIGH',
        isDone: false,
      ),
      TeacherTask(
        id: 't_3',
        title: 'Prepare 10 MCQ questions for Unit 2 Quiz generator',
        category: 'Lesson Prep',
        dueTime: 'Tomorrow, 10:00 AM',
        priority: 'MEDIUM',
        isDone: false,
      ),
      TeacherTask(
        id: 't_4',
        title: 'Call parent of Rohan Kumar regarding consecutive 3 days absence',
        category: 'PTM Followup',
        dueTime: 'Today, 05:00 PM',
        priority: 'NORMAL',
        isDone: false,
      ),
    ];
  }

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  void _addNewTask() {
    if (_newTaskController.text.trim().isEmpty) return;

    setState(() {
      _taskList.insert(
        0,
        TeacherTask(
          id: 't_${DateTime.now().millisecondsSinceEpoch}',
          title: _newTaskController.text.trim(),
          category: 'Lesson Prep',
          dueTime: 'Today, 05:00 PM',
          priority: 'HIGH',
          isDone: false,
        ),
      );
      _newTaskController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task added to your Daily To-Do list! ✍️'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showScheduleMeetingModal() {
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
              const Expanded(
                child: Text('Schedule Meeting / PTM Slot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
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
                      subtitle: 'Scheduled via Teacher Calendar Cockpit',
                      roomOrLink: roomController.text.trim(),
                      type: meetingType == 'PTM' ? AgendaItemType.ptm : AgendaItemType.meeting,
                      color: meetingType == 'PTM' ? const Color(0xFFE17055) : const Color(0xFFFD79A8),
                      icon: meetingType == 'PTM' ? Icons.groups_rounded : Icons.meeting_room_rounded,
                    ),
                  );
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Scheduled "${titleController.text}" on Calendar! 📅'),
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

  List<AgendaItem> get _filteredAgenda {
    if (_selectedFilter == 'Classes') {
      return _agendaList.where((a) => a.type == AgendaItemType.classPeriod).toList();
    }
    if (_selectedFilter == 'Meetings & PTM') {
      return _agendaList.where((a) => a.type == AgendaItemType.meeting || a.type == AgendaItemType.ptm).toList();
    }
    if (_selectedFilter == 'To-Do') {
      return _agendaList.where((a) => a.type == AgendaItemType.task).toList();
    }
    return _agendaList;
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = _taskList.where((t) => t.isDone).length;
    final double taskCompletionProgress = _taskList.isEmpty ? 0 : (completedTasks / _taskList.length);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Daily Agenda, Calendar & To-Do',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          ElevatedButton.icon(
            onPressed: _showScheduleMeetingModal,
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
            // 1. DATE SELECTOR RIBBON
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: _buildDateRibbon(),
            ),
            const SizedBox(height: 18),

            // 2. SUMMARY HUD BANNER
            FadeSlideEntry(
              delay: const Duration(milliseconds: 80),
              child: Container(
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
                                'TODAY\'S WORKSPACE SUMMARY • ${DateFormat('dd MMMM yyyy').format(_selectedDate).toUpperCase()}',
                                style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '3 Teaching Periods • 2 PTM Slots • 1 Faculty Sync',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Next upcoming: Period 2 (Maths - Class 9B) at 09:15 AM in Room 108',
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
                            '$completedTasks/${_taskList.length}',
                            style: const TextStyle(color: Color(0xFF10B981), fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          const Text('Tasks Done', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 3. MAIN TWO COLUMN LAYOUT: SCHEDULE & TO-DO
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
                        child: _buildTodoListSection(taskCompletionProgress, completedTasks),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    _buildAgendaTimelineSection(),
                    const SizedBox(height: 24),
                    _buildTodoListSection(taskCompletionProgress, completedTasks),
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

  Widget _buildDateRibbon() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
            icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF64748B)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_available_rounded, color: Color(0xFF6C5CE7), size: 20),
                const SizedBox(width: 8),
                Text(
                  DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Today', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
            },
            icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B)),
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
              const Text(
                'Today\'s Teaching Schedule & Agenda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
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
            children: ['All', 'Classes', 'Meetings & PTM', 'To-Do'].map((f) {
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

          // TIMELINE ITEMS
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

  Widget _buildTodoListSection(double progress, int completed) {
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
                  onSubmitted: (_) => _addNewTask(),
                  decoration: InputDecoration(
                    hintText: 'Add task (e.g. Check Physics copies)...',
                    hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addNewTask,
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

          // TASK LIST
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _taskList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = _taskList[index];

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
