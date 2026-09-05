import 'package:flutter/material.dart';
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
  String _selectedFilter = 'All Tasks';

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

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    // Filter tasks for selected date and filter category
    final dailyTasks = _tasks.where((task) {
      final taskDate = task['date'] as DateTime;
      final isSameDate = taskDate.year == _selectedDate.year &&
          taskDate.month == _selectedDate.month &&
          taskDate.day == _selectedDate.day;

      if (!isSameDate) return false;
      if (_selectedFilter == 'All Tasks') return true;
      if (_selectedFilter == 'Pending') return task['isCompleted'] == false;
      if (_selectedFilter == 'Completed') return task['isCompleted'] == true;
      return task['category'] == _selectedFilter;
    }).toList();

    final totalForDay = _tasks.where((t) {
      final taskDate = t['date'] as DateTime;
      return taskDate.year == _selectedDate.year &&
          taskDate.month == _selectedDate.month &&
          taskDate.day == _selectedDate.day;
    }).length;

    final completedForDay = _tasks.where((t) {
      final taskDate = t['date'] as DateTime;
      return taskDate.year == _selectedDate.year &&
          taskDate.month == _selectedDate.month &&
          taskDate.day == _selectedDate.day &&
          t['isCompleted'] == true;
    }).length;

    final progressRatio = totalForDay == 0 ? 0.0 : (completedForDay / totalForDay);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Smart Planner & To-Do Calendar'),
        actions: [
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
        onPressed: () => _showAddTaskModal(context),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_task),
        label: const Text('Set New Task', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: ResponsiveTwoPane(
            breakpoint: 860,
            leftFlex: 5,
            rightFlex: 7,
            spacing: 24,
            leftPane: Column(
              children: [
                _buildCalendarCard(primaryColor),
                const SizedBox(height: 16),
                _buildDailyProgressCard(completedForDay, totalForDay, progressRatio, primaryColor),
              ],
            ),
            rightPane: _buildTasksListSection(dailyTasks, completedForDay, totalForDay, primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksListSection(List<Map<String, dynamic>> dailyTasks, int completedForDay, int totalForDay, Color primaryColor) {
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
                'Tasks for ${DateFormat('dd MMMM (EEEE)').format(_selectedDate)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
        if (dailyTasks.isEmpty)
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
                const Text('No Tasks Scheduled For This Day!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text('Tap "+ Set New Task" below to plan your study goals or assignments.', style: TextStyle(color: Colors.grey[500], fontSize: 12), textAlign: TextAlign.center),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dailyTasks.length,
            itemBuilder: (context, index) {
              final task = dailyTasks[index];
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
                    // Checkbox
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
            },
          ),
      ],
    );
  }

  Widget _buildCalendarCard(Color primaryColor) {
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
              Text(
                DateFormat('MMMM yyyy').format(_currentMonth),
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, letterSpacing: -0.3),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
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
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return SizedBox(
                width: 36,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1.1,
            ),
            itemCount: startingWeekday + daysInMonth,
            itemBuilder: (context, index) {
              if (index < startingWeekday) {
                return const SizedBox.shrink();
              }

              final day = index - startingWeekday + 1;
              final thisDate = DateTime(_currentMonth.year, _currentMonth.month, day);
              final isSelected = _selectedDate.year == thisDate.year &&
                  _selectedDate.month == thisDate.month &&
                  _selectedDate.day == thisDate.day;

              final isToday = DateTime.now().year == thisDate.year &&
                  DateTime.now().month == thisDate.month &&
                  DateTime.now().day == thisDate.day;

              final hasTasks = _tasks.any((t) {
                final td = t['date'] as DateTime;
                return td.year == thisDate.year && td.month == thisDate.month && td.day == thisDate.day;
              });

              return InkWell(
                onTap: () => setState(() => _selectedDate = thisDate),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primaryColor
                        : isToday
                            ? primaryColor.withValues(alpha: 0.12)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: isToday && !isSelected ? Border.all(color: primaryColor, width: 1.5) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: isSelected || isToday ? FontWeight.w900 : FontWeight.w600,
                          fontSize: 12,
                          color: isSelected
                              ? Colors.white
                              : isToday
                                  ? primaryColor
                                  : const Color(0xFF1E293B),
                        ),
                      ),
                      if (hasTasks)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF00CEC9),
                            shape: BoxShape.circle,
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
            total == 0 ? 'No tasks for today. Relax or plan ahead!' : '$done of $total daily study tasks completed. Keep going!',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(Color primaryColor) {
    final filters = ['All Tasks', 'Pending', 'Completed', 'Homework', 'Exam Study', 'PYQs'];
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

  void _showAddTaskModal(BuildContext context) {
    final titleController = TextEditingController();
    String selectedSubj = 'Mathematics';
    String selectedCategory = 'Homework';
    String selectedPriority = 'MEDIUM';
    TimeOfDay selectedTime = const TimeOfDay(hour: 17, minute: 0);

    AdaptiveModal.show(
      context: context,
      maxWidth: 520,
      title: const Text('Set New Study Task / To-Do', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      content: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Task Description / Goal',
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
                'date': _selectedDate,
                'time': selectedTime.format(context),
                'priority': selectedPriority,
                'category': selectedCategory,
                'isCompleted': false,
              });
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New Task Scheduled on Calendar! 📅✨'),
                backgroundColor: Color(0xFF00B894),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0984E3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Add Task to Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
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
