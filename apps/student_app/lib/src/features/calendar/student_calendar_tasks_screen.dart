import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class StudentCalendarTasksScreen extends StatefulWidget {
  const StudentCalendarTasksScreen({super.key});

  @override
  State<StudentCalendarTasksScreen> createState() => _StudentCalendarTasksScreenState();
}

class _StudentCalendarTasksScreenState extends State<StudentCalendarTasksScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  String _selectedFilter = 'All'; // 'All', 'Tasks', 'Reminders', 'Pending', 'Completed'

  // Mood / Daily Vibe Logs keyed by 'yyyy-MM-dd'
  final Map<String, Map<String, dynamic>> _moodLogs = {
    // Current month sample data matching user's visual reference
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 6))): {
      'type': 'productive',
      'emoji': '😊',
      'label': 'Super Productive',
      'color': 0xFF2ECC71,
      'bgColor': 0xFFE8F8F0,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 5))): {
      'type': 'good',
      'emoji': '🙂',
      'label': 'Good & Motivated',
      'color': 0xFFF1C40F,
      'bgColor': 0xFFFEF9E7,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 4))): {
      'type': 'neutral',
      'emoji': '😐',
      'label': 'Normal / Steady',
      'color': 0xFF95A5A6,
      'bgColor': 0xFFF2F4F4,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 3))): {
      'type': 'tired',
      'emoji': '🙁',
      'label': 'Tired / Exhausted',
      'color': 0xFFE67E22,
      'bgColor': 0xFFFBEEE6,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 2))): {
      'type': 'stressed',
      'emoji': '😵',
      'label': 'Stressed / Overwhelmed',
      'color': 0xFF9B59B6,
      'bgColor': 0xFFF4ECF7,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1))): {
      'type': 'good',
      'emoji': '🙂',
      'label': 'Good & Motivated',
      'color': 0xFFF1C40F,
      'bgColor': 0xFFFEF9E7,
    },
    DateFormat('yyyy-MM-dd').format(DateTime.now()): {
      'type': 'productive',
      'emoji': '😊',
      'label': 'Super Productive',
      'color': 0xFF2ECC71,
      'bgColor': 0xFFE8F8F0,
    },
  };

  // Task Model List
  final List<Map<String, dynamic>> _tasks = [
    {
      'id': '1',
      'title': 'Revise Chapter 4 Quadratic Equations (Ex 4.2 & 4.3)',
      'subject': 'Mathematics',
      'date': DateTime.now(),
      'time': '05:00 PM',
      'priority': 'HIGH',
      'category': 'Exam Study',
      'isCompleted': false,
    },
    {
      'id': '2',
      'title': 'Submit Heat Transfer Physics Lab File to Prof. Verma',
      'subject': 'Physics',
      'date': DateTime.now(),
      'time': '07:30 PM',
      'priority': 'HIGH',
      'category': 'Homework',
      'isCompleted': true,
    },
    {
      'id': '3',
      'title': 'Watch YouTube Lecture on Optics & Ray Diagrams',
      'subject': 'Physics',
      'date': DateTime.now(),
      'time': '08:30 PM',
      'priority': 'MEDIUM',
      'category': 'Video Lecture',
      'isCompleted': false,
    },
    {
      'id': '4',
      'title': 'Practice 5 Solved Board PYQs of Chemical Reactions',
      'subject': 'Chemistry',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '04:00 PM',
      'priority': 'MEDIUM',
      'category': 'PYQs',
      'isCompleted': false,
    },
    {
      'id': '5',
      'title': 'English Essay: Character Analysis of Portia final draft',
      'subject': 'English',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '06:00 PM',
      'priority': 'LOW',
      'category': 'Homework',
      'isCompleted': false,
    },
  ];

  // Smart Reminders on Calendar
  final List<Map<String, dynamic>> _reminders = [
    {
      'id': 'rem_1',
      'title': 'Physics Ray Optics Homework Deadline',
      'subject': 'Physics',
      'date': DateTime.now(),
      'time': '08:00 PM',
      'priority': 'HIGH',
      'leadTime': '30 min before',
      'isCompleted': false,
    },
    {
      'id': 'rem_2',
      'title': 'Chemistry Lab Record Verification',
      'subject': 'Chemistry',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '10:00 AM',
      'priority': 'MEDIUM',
      'leadTime': '1 hour before',
      'isCompleted': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    // Filter items for selected date
    final selectedDateKey = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final dayMood = _moodLogs[selectedDateKey];

    final dailyTasks = _tasks.where((task) {
      final taskDate = task['date'] as DateTime;
      return taskDate.year == _selectedDate.year &&
          taskDate.month == _selectedDate.month &&
          taskDate.day == _selectedDate.day;
    }).toList();

    final dailyReminders = _reminders.where((rem) {
      final remDate = rem['date'] as DateTime;
      return remDate.year == _selectedDate.year &&
          remDate.month == _selectedDate.month &&
          remDate.day == _selectedDate.day;
    }).toList();

    final totalForDay = dailyTasks.length;
    final completedForDay = dailyTasks.where((t) => t['isCompleted'] == true).length;
    final progressRatio = totalForDay == 0 ? 0.0 : (completedForDay / totalForDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Smart Planner & Mood Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.alarm_on_rounded),
            tooltip: 'Alarms & Reminders Hub',
            onPressed: () => context.push('/alarms-reminders'),
          ),
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Go to Today',
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
                _currentMonth = DateTime.now();
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskModal(context, lockedDate: _selectedDate),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task),
        label: const Text('Set New Task', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: ResponsiveTwoPane(
            breakpoint: 880,
            leftFlex: 5,
            rightFlex: 7,
            spacing: 24,
            leftPane: Column(
              children: [
                _buildCalendarCard(primaryColor),
                const SizedBox(height: 16),
                _buildSelectedDateCockpit(primaryColor, dayMood, dailyTasks.length, dailyReminders.length),
                const SizedBox(height: 16),
                _buildDailyProgressCard(completedForDay, totalForDay, progressRatio, primaryColor),
              ],
            ),
            rightPane: _buildTasksListSection(dailyTasks, dailyReminders, completedForDay, totalForDay, primaryColor),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // CALENDAR CARD WITH MOOD & STATUS INDICATORS (IMAGE REFERENCE)
  // -------------------------------------------------------------
  Widget _buildCalendarCard(Color primaryColor) {
    final daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7; // Sunday = 0, Monday = 1...

    return Container(
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
          // Month navigation bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(_currentMonth),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.4, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Moods & Tasks Logged This Month',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                  ),
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
          const SizedBox(height: 14),

          // Weekday header: Su Mo Tu We Th Fr Sa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'].map((day) {
              final isWeekend = day == 'Su' || day == 'Sa';
              return SizedBox(
                width: 38,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: isWeekend ? const Color(0xFFE17055) : const Color(0xFF64748B),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Day Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 6,
              childAspectRatio: 0.76, // Taller ratio for date on top and mood circle beneath
            ),
            itemCount: startingWeekday + daysInMonth,
            itemBuilder: (context, index) {
              if (index < startingWeekday) {
                return const SizedBox.shrink();
              }

              final day = index - startingWeekday + 1;
              final thisDate = DateTime(_currentMonth.year, _currentMonth.month, day);
              final dateKey = DateFormat('yyyy-MM-dd').format(thisDate);

              final isSelected = _selectedDate.year == thisDate.year &&
                  _selectedDate.month == thisDate.month &&
                  _selectedDate.day == thisDate.day;

              final isToday = DateTime.now().year == thisDate.year &&
                  DateTime.now().month == thisDate.month &&
                  DateTime.now().day == thisDate.day;

              final mood = _moodLogs[dateKey];

              final hasTasks = _tasks.any((t) {
                final td = t['date'] as DateTime;
                return td.year == thisDate.year && td.month == thisDate.month && td.day == thisDate.day;
              });

              final hasReminders = _reminders.any((r) {
                final rd = r['date'] as DateTime;
                return rd.year == thisDate.year && rd.month == thisDate.month && rd.day == thisDate.day;
              });

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedDate = thisDate;
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFFF7ED) // Light amber/cream active pill bg
                        : isToday
                            ? primaryColor.withValues(alpha: 0.06)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: isSelected
                        ? Border.all(color: const Color(0xFFD97706), width: 2) // Active capsule border like screenshot
                        : isToday
                            ? Border.all(color: primaryColor.withValues(alpha: 0.4), width: 1.2)
                            : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFD97706).withValues(alpha: 0.18),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Date number on top
                      Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: isSelected || isToday ? FontWeight.w900 : FontWeight.w700,
                          fontSize: 13,
                          color: isSelected
                              ? const Color(0xFF92400E)
                              : isToday
                                  ? primaryColor
                                  : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Mood circle or empty circle underneath
                      if (mood != null)
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Color(mood['color'] as int),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(mood['color'] as int).withValues(alpha: 0.35),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mood['emoji'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                        )
                      else if (hasTasks || hasReminders)
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: hasTasks ? const Color(0xFF0984E3) : const Color(0xFF8B5CF6),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            hasTasks ? Icons.check_rounded : Icons.notifications_active_rounded,
                            size: 15,
                            color: Colors.white,
                          ),
                        )
                      else
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.5,
                            ),
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

  // -------------------------------------------------------------------
  // DATE CLICK ACTION COCKPIT (DIRECTLY BELOW CALENDAR AS REQUESTED)
  // -------------------------------------------------------------------
  Widget _buildSelectedDateCockpit(
    Color primaryColor,
    Map<String, dynamic>? mood,
    int taskCount,
    int reminderCount,
  ) {
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Selected Date Title & Mood Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.event_available_rounded, color: primaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$taskCount Tasks • $reminderCount Reminders',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              if (mood != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(mood['bgColor'] as int),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(mood['color'] as int).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(mood['emoji'] as String, style: const TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        mood['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(mood['color'] as int),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 14),

          const Text(
            'Quick Actions for Selected Date:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 10),

          // 4 Action Buttons Grid
          Row(
            children: [
              // 1. SET TASK
              Expanded(
                child: _buildActionCockpitButton(
                  icon: Icons.add_task_rounded,
                  label: '+ Task',
                  color: const Color(0xFF0984E3),
                  bgColor: const Color(0xFFEBF5FB),
                  onTap: () => _showAddTaskModal(context, lockedDate: _selectedDate),
                ),
              ),
              const SizedBox(width: 8),

              // 2. SET REMINDER
              Expanded(
                child: _buildActionCockpitButton(
                  icon: Icons.notifications_active_rounded,
                  label: '🔔 Reminder',
                  color: const Color(0xFF8B5CF6),
                  bgColor: const Color(0xFFF5F3FF),
                  onTap: () => _showAddReminderModal(context, lockedDate: _selectedDate),
                ),
              ),
              const SizedBox(width: 8),

              // 3. SET ALARM
              Expanded(
                child: _buildActionCockpitButton(
                  icon: Icons.alarm_add_rounded,
                  label: '⏰ Alarm',
                  color: const Color(0xFFE17055),
                  bgColor: const Color(0xFFFDF2E9),
                  onTap: () => _showSetAlarmModal(context, lockedDate: _selectedDate),
                ),
              ),
              const SizedBox(width: 8),

              // 4. LOG MOOD
              Expanded(
                child: _buildActionCockpitButton(
                  icon: Icons.mood_rounded,
                  label: '😊 Mood',
                  color: const Color(0xFF00B894),
                  bgColor: const Color(0xFFE8F8F5),
                  onTap: () => _showMoodSelectorModal(context, _selectedDate),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCockpitButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // TASKS & REMINDERS LIST SECTION (RIGHT PANE)
  // -------------------------------------------------------------
  Widget _buildTasksListSection(
    List<Map<String, dynamic>> dailyTasks,
    List<Map<String, dynamic>> dailyReminders,
    int completedForDay,
    int totalForDay,
    Color primaryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterChips(primaryColor),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Schedule for ${DateFormat('dd MMMM (EEEE)').format(_selectedDate)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$completedForDay / $totalForDay Done',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (dailyTasks.isEmpty && dailyReminders.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                const Icon(Icons.event_available, size: 54, color: Color(0xFF00CEC9)),
                const SizedBox(height: 12),
                const Text('No Tasks or Reminders on this Day', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 6),
                Text(
                  'Use the quick action buttons above to set a task, reminder or study alarm for ${DateFormat('dd MMM').format(_selectedDate)}!',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showAddTaskModal(context, lockedDate: _selectedDate),
                      icon: const Icon(Icons.add_task, size: 16),
                      label: const Text('Add Task'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0984E3),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () => _showAddReminderModal(context, lockedDate: _selectedDate),
                      icon: const Icon(Icons.notifications_active_outlined, size: 16),
                      label: const Text('Add Reminder'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        else ...[
          // 1. Reminders on this Day (if any)
          if (dailyReminders.isNotEmpty && (_selectedFilter == 'All' || _selectedFilter == 'Reminders')) ...[
            const Row(
              children: [
                Icon(Icons.notifications_active_rounded, size: 16, color: Color(0xFF8B5CF6)),
                SizedBox(width: 6),
                Text('Scheduled Reminders', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
              ],
            ),
            const SizedBox(height: 8),
            ...dailyReminders.map((rem) => _buildReminderCard(rem, primaryColor)),
            const SizedBox(height: 16),
          ],

          // 2. Study Tasks on this Day
          if (dailyTasks.isNotEmpty && (_selectedFilter == 'All' || _selectedFilter == 'Tasks' || _selectedFilter == 'Pending' || _selectedFilter == 'Completed')) ...[
            const Row(
              children: [
                Icon(Icons.task_alt_rounded, size: 16, color: Color(0xFF0984E3)),
                SizedBox(width: 6),
                Text('Study Goals & Tasks', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
              ],
            ),
            const SizedBox(height: 8),
            ...dailyTasks.map((task) => _buildTaskCard(task, primaryColor)),
          ],
        ],
      ],
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> rem, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_active_rounded, color: Color(0xFF8B5CF6), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rem['title'],
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(rem['subject'], style: const TextStyle(color: Color(0xFF8B5CF6), fontSize: 10, fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time_rounded, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(rem['time'], style: TextStyle(fontSize: 11, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text('(${rem['leadTime']})', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
            onPressed: () {
              setState(() => _reminders.remove(rem));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task, Color primaryColor) {
    final isCompleted = task['isCompleted'] as bool;
    final priority = task['priority'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCompleted ? const Color(0xFFE2E8F0) : _getPriorityColor(priority).withValues(alpha: 0.3),
          width: isCompleted ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.15,
            child: Checkbox(
              value: isCompleted,
              activeColor: const Color(0xFF00B894),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onChanged: (val) {
                setState(() {
                  task['isCompleted'] = val ?? false;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(task['isCompleted'] ? 'Task Marked Completed! 🎉' : 'Task Marked Pending'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: task['isCompleted'] ? const Color(0xFF00B894) : Colors.grey[800],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task['subject'],
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(priority).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$priority PRIORITY',
                        style: TextStyle(color: _getPriorityColor(priority), fontSize: 9, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  task['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Colors.grey[500] : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.alarm, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text('${task['time']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    const SizedBox(width: 12),
                    Icon(Icons.category_outlined, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text('${task['category']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
            onPressed: () {
              setState(() => _tasks.remove(task));
            },
            tooltip: 'Delete Task',
          ),
        ],
      ),
    );
  }

  Widget _buildDailyProgressCard(int done, int total, double ratio, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0984E3), Color(0xFF00CEC9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Daily Study Goal Progress', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${(ratio * 100).toInt()}% Done', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            total == 0 ? 'No tasks for this day. Relax or set new goals!' : '$done of $total daily study tasks completed. Keep going!',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(Color primaryColor) {
    final filters = ['All', 'Tasks', 'Reminders', 'Pending', 'Completed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(f),
              onSelected: (val) => setState(() => _selectedFilter = f),
              selectedColor: primaryColor.withValues(alpha: 0.15),
              checkmarkColor: primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? primaryColor : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // -------------------------------------------------------------
  // MODAL: ADD TASK (PREFILLED WITH CLICKED DATE)
  // -------------------------------------------------------------
  void _showAddTaskModal(BuildContext context, {required DateTime lockedDate}) {
    final titleController = TextEditingController();
    String selectedSubj = 'Mathematics';
    String selectedCategory = 'Homework';
    String selectedPriority = 'MEDIUM';
    TimeOfDay selectedTime = const TimeOfDay(hour: 17, minute: 0);

    AdaptiveModal.show(
      context: context,
      maxWidth: 520,
      title: Text('Set Task for ${DateFormat('dd MMMM').format(lockedDate)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0984E3).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF0984E3).withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 16, color: Color(0xFF0984E3)),
                    const SizedBox(width: 8),
                    Text(
                      'Scheduled Date: ${DateFormat('EEEE, dd MMMM yyyy').format(lockedDate)}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0984E3)),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Task Description / Study Goal',
                  hintText: 'e.g., Solve 10 PYQ numericals of Optics',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedSubj,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Mathematics', 'Physics', 'Chemistry', 'Biology', 'Computer Science', 'English', 'Social Science'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => selectedSubj = val ?? selectedSubj),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['HIGH', 'MEDIUM', 'LOW'].map((p) {
                        return DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => selectedPriority = val ?? selectedPriority),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Task Type',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Homework', 'Exam Study', 'PYQs', 'Video Lecture', 'Revision'].map((c) {
                        return DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => selectedCategory = val ?? selectedCategory),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(context: context, initialTime: selectedTime);
                        if (picked != null) {
                          setModalState(() => selectedTime = picked);
                        }
                      },
                      icon: const Icon(Icons.schedule, size: 18),
                      label: Text(selectedTime.format(context), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
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
              _tasks.add({
                'id': DateTime.now().millisecondsSinceEpoch.toString(),
                'title': titleController.text.trim(),
                'subject': selectedSubj,
                'date': lockedDate,
                'time': selectedTime.format(context),
                'priority': selectedPriority,
                'category': selectedCategory,
                'isCompleted': false,
              });
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Task added for ${DateFormat('dd MMMM').format(lockedDate)}! 📅✨'),
                backgroundColor: const Color(0xFF00B894),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0984E3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Add Task to Date', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // MODAL: ADD REMINDER (PREFILLED WITH CLICKED DATE)
  // -------------------------------------------------------------
  void _showAddReminderModal(BuildContext context, {required DateTime lockedDate}) {
    final titleController = TextEditingController();
    String selectedSubj = 'Physics';
    String selectedPriority = 'HIGH';
    String leadTime = '30 min before';
    TimeOfDay selectedTime = const TimeOfDay(hour: 19, minute: 0);

    AdaptiveModal.show(
      context: context,
      maxWidth: 520,
      title: Text('Set Reminder for ${DateFormat('dd MMMM').format(lockedDate)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active_rounded, size: 16, color: Color(0xFF8B5CF6)),
                    const SizedBox(width: 8),
                    Text(
                      'Alert Date: ${DateFormat('EEEE, dd MMMM yyyy').format(lockedDate)}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF8B5CF6)),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Reminder Description',
                  hintText: 'e.g., Chemistry assignment submission due',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedSubj,
                      decoration: InputDecoration(
                        labelText: 'Subject / Category',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Mathematics', 'Physics', 'Chemistry', 'Biology', 'Computer Science', 'English', 'School Admin', 'Fee Payment'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => selectedSubj = val ?? selectedSubj),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Alert Urgency',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['HIGH', 'MEDIUM', 'NORMAL'].map((p) {
                        return DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => selectedPriority = val ?? selectedPriority),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: leadTime,
                      decoration: InputDecoration(
                        labelText: 'Notification Lead Time',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['At time of event', '15 min before', '30 min before', '1 hour before', '1 day before'].map((l) {
                        return DropdownMenuItem(value: l, child: Text(l, style: const TextStyle(fontSize: 13)));
                      }).toList(),
                      onChanged: (val) => setModalState(() => leadTime = val ?? leadTime),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(context: context, initialTime: selectedTime);
                        if (picked != null) {
                          setModalState(() => selectedTime = picked);
                        }
                      },
                      icon: const Icon(Icons.alarm, size: 18),
                      label: Text(selectedTime.format(context), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
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
              _reminders.add({
                'id': 'rem_${DateTime.now().millisecondsSinceEpoch}',
                'title': titleController.text.trim(),
                'subject': selectedSubj,
                'date': lockedDate,
                'time': selectedTime.format(context),
                'priority': selectedPriority,
                'leadTime': leadTime,
                'isCompleted': false,
              });
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Reminder set for ${DateFormat('dd MMMM').format(lockedDate)}! 🔔✨'),
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B5CF6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Save Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // MODAL: SET ALARM
  // -------------------------------------------------------------
  void _showSetAlarmModal(BuildContext context, {required DateTime lockedDate}) {
    final labelController = TextEditingController(text: 'Study Focus Block');
    TimeOfDay alarmTime = const TimeOfDay(hour: 6, minute: 30);
    String sound = 'Bright Sunrise (Chime)';

    AdaptiveModal.show(
      context: context,
      maxWidth: 480,
      title: const Text('Set Study / Wake-up Alarm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: labelController,
                decoration: InputDecoration(
                  labelText: 'Alarm Label',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(context: context, initialTime: alarmTime);
                        if (picked != null) {
                          setModalState(() => alarmTime = picked);
                        }
                      },
                      icon: const Icon(Icons.alarm_rounded, size: 20, color: Color(0xFFE17055)),
                      label: Text(alarmTime.format(context), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: sound,
                      decoration: InputDecoration(
                        labelText: 'Alarm Tone',
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: ['Bright Sunrise (Chime)', 'School Bell (Gentle)', 'Focus Binaural Chime', 'Arcade Synth Alert'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis));
                      }).toList(),
                      onChanged: (val) => setModalState(() => sound = val ?? sound),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Study Alarm set for ${alarmTime.format(context)}! ⏰'),
                backgroundColor: const Color(0xFFE17055),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE17055),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Confirm Alarm', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // MODAL: LOG DAILY MOOD / VIBE (INTERACTIVE IMAGE REFERENCE PICKER)
  // -------------------------------------------------------------------
  void _showMoodSelectorModal(BuildContext context, DateTime targetDate) {
    final dateKey = DateFormat('yyyy-MM-dd').format(targetDate);
    final moods = [
      {
        'type': 'productive',
        'emoji': '😊',
        'label': 'Super Productive',
        'subtitle': 'Finished targets & revision',
        'color': 0xFF2ECC71,
        'bgColor': 0xFFE8F8F0,
      },
      {
        'type': 'good',
        'emoji': '🙂',
        'label': 'Good & Motivated',
        'subtitle': 'Attended classes & stayed on track',
        'color': 0xFFF1C40F,
        'bgColor': 0xFFFEF9E7,
      },
      {
        'type': 'neutral',
        'emoji': '😐',
        'label': 'Normal / Steady',
        'subtitle': 'Average day, moderate progress',
        'color': 0xFF95A5A6,
        'bgColor': 0xFFF2F4F4,
      },
      {
        'type': 'tired',
        'emoji': '🙁',
        'label': 'Tired / Exhausted',
        'subtitle': 'Long schedule or low energy',
        'color': 0xFFE67E22,
        'bgColor': 0xFFFBEEE6,
      },
      {
        'type': 'stressed',
        'emoji': '😵',
        'label': 'Stressed / Overwhelmed',
        'subtitle': 'Heavy exam pressure or doubts',
        'color': 0xFF9B59B6,
        'bgColor': 0xFFF4ECF7,
      },
    ];

    AdaptiveModal.show(
      context: context,
      maxWidth: 480,
      title: Text('How was your Study Day on ${DateFormat('dd MMM').format(targetDate)}?', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: moods.map((m) {
          final isCurrent = _moodLogs[dateKey]?['type'] == m['type'];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isCurrent ? Color(m['bgColor'] as int) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCurrent ? Color(m['color'] as int) : const Color(0xFFE2E8F0),
                width: isCurrent ? 2 : 1,
              ),
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  _moodLogs[dateKey] = m;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged ${m['emoji']} ${m['label']} for ${DateFormat('dd MMMM').format(targetDate)}!'),
                    backgroundColor: Color(m['color'] as int),
                  ),
                );
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(m['color'] as int),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(m['emoji'] as String, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(
                m['label'] as String,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
              subtitle: Text(
                m['subtitle'] as String,
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              ),
              trailing: isCurrent
                  ? Icon(Icons.check_circle_rounded, color: Color(m['color'] as int))
                  : const Icon(Icons.chevron_right_rounded, color: Color(0xFFCBD5E1)),
            ),
          );
        }).toList(),
      ),
      actions: [
        if (_moodLogs.containsKey(dateKey))
          TextButton.icon(
            onPressed: () {
              setState(() => _moodLogs.remove(dateKey));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 16),
            label: const Text('Clear Mood', style: TextStyle(color: Color(0xFFEF4444))),
          ),
      ],
    );
  }

  Color _getPriorityColor(String p) {
    switch (p) {
      case 'HIGH':
        return const Color(0xFFEF4444);
      case 'MEDIUM':
        return const Color(0xFFF59E0B);
      case 'LOW':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

