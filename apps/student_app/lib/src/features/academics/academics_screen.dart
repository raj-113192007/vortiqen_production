import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import 'ai_quiz_screen.dart';
import 'youtube_lectures_screen.dart';
import 'unitwise_pyqs_screen.dart';

class AcademicsScreen extends ConsumerStatefulWidget {
  final int initialTabIndex;
  const AcademicsScreen({super.key, this.initialTabIndex = 0});

  @override
  ConsumerState<AcademicsScreen> createState() => _AcademicsScreenState();
}

class _AcademicsScreenState extends ConsumerState<AcademicsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedDayIndex = 0;

  // AI Doubt Chat State
  final TextEditingController _aiQueryController = TextEditingController();
  final List<Map<String, String>> _aiChatHistory = [
    {
      'sender': 'ai',
      'text': 'Hello Aarav! 👋 I am your VortiQen AI Study Assistant. Ask me any formula, concept doubt, or homework question!',
    },
    {
      'sender': 'user',
      'text': 'Can you explain Newton’s Third Law with a real-world example?',
    },
    {
      'sender': 'ai',
      'text': 'Newton’s Third Law states: "For every action, there is an equal and opposite reaction."\n\n📌 Real-World Example: When a rocket launches, its engines expel hot exhaust gas downward (Action). The gas exerts an equal and opposite force pushing the rocket upward into space (Reaction) 🚀.',
    },
  ];

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _aiQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Academics & LMS Hub'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(icon: Icon(Icons.calendar_month, size: 20), text: 'Timetable'),
            Tab(icon: Icon(Icons.assignment, size: 20), text: 'Assignments'),
            Tab(icon: Icon(Icons.history_edu, size: 20), text: 'Unit PYQs'),
            Tab(icon: Icon(Icons.video_library, size: 20), text: 'YT Lectures'),
            Tab(icon: Icon(Icons.quiz, size: 20), text: 'AI Quiz Arena'),
            Tab(icon: Icon(Icons.smart_toy_outlined, size: 20), text: 'Ask AI'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTimetableView(primaryColor),
          _buildHomeworkView(primaryColor),
          const UnitwisePyqsScreen(),
          const YoutubeLecturesScreen(),
          const AiQuizScreen(),
          _buildAiDoubtView(primaryColor),
        ],
      ),
    );
  }

  // 1. TIMETABLE VIEW
  Widget _buildTimetableView(Color primaryColor) {
    final Map<int, List<Map<String, String>>> weeklySchedule = {
      0: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Mathematics', 'teacher': 'Dr. Ramanujan', 'room': 'Room 102', 'topic': 'Quadratic Equations'},
        {'time': '09:15 - 10:00 AM', 'subject': 'English Literature', 'teacher': 'Mrs. Sen', 'room': 'Room 102', 'topic': 'Merchant of Venice'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Physics Lab', 'teacher': 'Prof. Verma', 'room': 'Science Lab 2', 'topic': 'Thermodynamics'},
        {'time': '11:15 - 12:00 PM', 'subject': 'Chemistry', 'teacher': 'Dr. Sharma', 'room': 'Room 102', 'topic': 'Periodic Trends'},
        {'time': '12:45 - 01:30 PM', 'subject': 'Computer Science', 'teacher': 'Mr. Gupta', 'room': 'IT Lab 1', 'topic': 'Python Loops'},
      ],
      1: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Physics', 'teacher': 'Prof. Verma', 'room': 'Room 102', 'topic': 'Optics & Ray Diagrams'},
        {'time': '09:15 - 10:00 AM', 'subject': 'Social Science', 'teacher': 'Mrs. Roy', 'room': 'Room 102', 'topic': 'Nationalism in Europe'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Biology', 'teacher': 'Dr. Bose', 'room': 'Bio Lab', 'topic': 'Cell Division'},
        {'time': '11:15 - 12:00 PM', 'subject': 'Mathematics', 'teacher': 'Dr. Ramanujan', 'room': 'Room 102', 'topic': 'Arithmetic Progression'},
        {'time': '12:45 - 01:30 PM', 'subject': 'Physical Education', 'teacher': 'Coach Singh', 'room': 'Sports Ground', 'topic': 'Athletics'},
      ],
      2: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Chemistry Lab', 'teacher': 'Dr. Sharma', 'room': 'Chem Lab 1', 'topic': 'Titration Experiment'},
        {'time': '09:15 - 10:00 AM', 'subject': 'English Grammar', 'teacher': 'Mrs. Sen', 'room': 'Room 102', 'topic': 'Active & Passive Voice'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Mathematics', 'teacher': 'Dr. Ramanujan', 'room': 'Room 102', 'topic': 'Probability'},
        {'time': '11:15 - 12:00 PM', 'subject': 'Hindi', 'teacher': 'Mrs. Tiwari', 'room': 'Room 102', 'topic': 'Kavya Khand'},
      ],
      3: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Computer Science Lab', 'teacher': 'Mr. Gupta', 'room': 'IT Lab 1', 'topic': 'Data Structures'},
        {'time': '09:15 - 10:00 AM', 'subject': 'Physics', 'teacher': 'Prof. Verma', 'room': 'Room 102', 'topic': 'Electric Current'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Social Science', 'teacher': 'Mrs. Roy', 'room': 'Room 102', 'topic': 'Resources & Agriculture'},
        {'time': '11:15 - 12:00 PM', 'subject': 'Biology Lab', 'teacher': 'Dr. Bose', 'room': 'Bio Lab', 'topic': 'Microscope Studies'},
      ],
      4: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Mathematics', 'teacher': 'Dr. Ramanujan', 'room': 'Room 102', 'topic': 'Coordinate Geometry'},
        {'time': '09:15 - 10:00 AM', 'subject': 'Chemistry', 'teacher': 'Dr. Sharma', 'room': 'Room 102', 'topic': 'Carbon Compounds'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Library & Research', 'teacher': 'Librarian', 'room': 'Central Library', 'topic': 'Self Study'},
        {'time': '11:15 - 12:00 PM', 'subject': 'Art & Design', 'teacher': 'Mr. Das', 'room': 'Art Studio', 'topic': 'Perspective Drawing'},
      ],
      5: [
        {'time': '08:30 - 09:15 AM', 'subject': 'Science Quiz & Tests', 'teacher': 'Science Dept', 'room': 'Room 102', 'topic': 'Weekly Assessment'},
        {'time': '09:15 - 10:00 AM', 'subject': 'Club Activities', 'teacher': 'Faculty', 'room': 'Auditorium', 'topic': 'Robotics & Debate'},
        {'time': '10:00 - 10:30 AM', 'subject': 'Morning Recess', 'teacher': '-', 'room': 'Cafeteria', 'topic': 'Break'},
        {'time': '10:30 - 11:15 AM', 'subject': 'Mathematics Practice', 'teacher': 'Dr. Ramanujan', 'room': 'Room 102', 'topic': 'Mock Test Review'},
      ],
    };

    final currentList = weeklySchedule[_selectedDayIndex] ?? weeklySchedule[0]!;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day Selector Pills
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_days.length, (index) {
                  final isSelected = _selectedDayIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDayIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _days[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Schedule for ${_days[_selectedDayIndex]}day',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
            ),
            const SizedBox(height: 12),

            // Period Cards
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: currentList.length,
              itemBuilder: (context, index) {
                final item = currentList[index];
                final isRecess = item['subject']!.contains('Recess');
                final isLive = _selectedDayIndex == 0 && index == 3;

                if (isRecess) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFFEEBA)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.coffee, color: Color(0xFF856404), size: 20),
                        const SizedBox(width: 12),
                        Text(
                          '${item['time']}  •  ${item['subject']}',
                          style: const TextStyle(color: Color(0xFF856404), fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isLive ? const Color(0xFF00CEC9) : const Color(0xFFE2E8F0),
                      width: isLive ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isLive ? const Color(0xFF00CEC9).withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.02),
                        blurRadius: isLive ? 14 : 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isLive ? const Color(0xFF00CEC9).withValues(alpha: 0.15) : primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _getSubjectIcon(item['subject']!),
                          color: isLive ? const Color(0xFF00CEC9) : primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item['time']!,
                                  style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                                if (isLive) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE84393),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text('HAPPENING NOW', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item['subject']!,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item['topic']}  •  ${item['teacher']}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['room']!,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xFF475569)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 2. HOMEWORK & ASSIGNMENTS VIEW
  Widget _buildHomeworkView(Color primaryColor) {
    final assignments = [
      {
        'id': '1',
        'subject': 'Mathematics',
        'unit': 'Unit 4: Quadratic Equations',
        'title': 'Chapter 4: Quadratic Equations Ex 4.2',
        'desc': 'Solve all word problems from questions 1 to 10. Show step-by-step discriminant calculations.',
        'teacher': 'Dr. Ramanujan',
        'dueDate': 'Tomorrow, 09:00 AM',
        'status': 'PENDING',
        'maxMarks': '20',
      },
      {
        'id': '2',
        'subject': 'Physics',
        'unit': 'Unit 10: Thermodynamics',
        'title': 'Heat Transfer Lab Report & Numericals',
        'desc': 'Complete the calorimetry observation table and solve textbook numericals 12-18.',
        'teacher': 'Prof. Verma',
        'dueDate': '12 Sept 2026, 11:59 PM',
        'status': 'PENDING',
        'maxMarks': '25',
      },
      {
        'id': '3',
        'subject': 'Computer Science',
        'unit': 'Unit 2: Python File Handling',
        'title': 'Python File I/O Mini Project',
        'desc': 'Write a Python program to read student grades from CSV and output high-scorers.',
        'teacher': 'Mr. Gupta',
        'dueDate': '02 Sept 2026',
        'status': 'SUBMITTED',
        'maxMarks': '30',
        'submittedFile': 'aarav_python_project.py',
      },
      {
        'id': '4',
        'subject': 'English Literature',
        'unit': 'Unit 1: Drama',
        'title': 'Character Analysis of Portia Essay',
        'desc': 'Write a 500-word analytical essay discussing Portia’s wisdom in the trial scene.',
        'teacher': 'Mrs. Sen',
        'dueDate': '28 Aug 2026',
        'status': 'GRADED',
        'grade': 'A+ (28/30)',
        'feedback': 'Exceptional analysis and rich quotes from Act 4! Well done.',
      },
    ];

    final isWide = context.screenWidth >= 900;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1200,
        child: isWide
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.35,
                ),
                itemCount: assignments.length,
                itemBuilder: (context, index) => _buildAssignmentCard(context, assignments[index], primaryColor),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: assignments.length,
                itemBuilder: (context, index) => _buildAssignmentCard(context, assignments[index], primaryColor),
              ),
      ),
    );
  }

  Widget _buildAssignmentCard(BuildContext context, Map<String, dynamic> item, Color primaryColor) {
    final isPending = item['status'] == 'PENDING';
    final isSubmitted = item['status'] == 'SUBMITTED';
    final isGraded = item['status'] == 'GRADED';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${item['subject']} • ${item['unit']}',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPending
                          ? const Color(0xFFFFF3CD)
                          : isSubmitted
                              ? const Color(0xFFE0F2FE)
                              : const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['status']!,
                      style: TextStyle(
                        color: isPending
                            ? const Color(0xFF856404)
                            : isSubmitted
                                ? const Color(0xFF0369A1)
                                : const Color(0xFF15803D),
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: -0.3),
              ),
              const SizedBox(height: 6),
              Text(
                item['desc']!,
                style: TextStyle(color: Colors.grey[700], fontSize: 12, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 15, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text('${item['teacher']}', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
                  const Spacer(),
                  Icon(Icons.alarm, size: 15, color: isPending ? Colors.red[400] : Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    'Due: ${item['dueDate']}',
                    style: TextStyle(
                      color: isPending ? Colors.red[600] : Colors.grey[600],
                      fontSize: 11,
                      fontWeight: isPending ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (isGraded) ...[
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFF16A34A), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Grade: ${item['grade']} — ${item['feedback']}', style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF15803D), fontSize: 11)),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          if (isPending)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showSubmitHomeworkDialog(context, item['title']!),
                icon: const Icon(Icons.upload_file, size: 16),
                label: const Text('Upload & Submit Assignment', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          else if (isSubmitted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF00B894), size: 18),
                  const SizedBox(width: 8),
                  Text('Submitted: ${item['submittedFile']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showSubmitHomeworkDialog(BuildContext context, String title) {
    AdaptiveModal.show(
      context: context,
      maxWidth: 500,
      title: const Text('Submit Assignment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Column(
              children: [
                const Icon(Icons.cloud_upload_outlined, size: 44, color: Color(0xFF0984E3)),
                const SizedBox(height: 8),
                const Text('Drag & drop or browse files', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text('PDF, DOCX, PNG, JPG (Max 25MB)', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('File "homework_submission.pdf" attached!'),
                        backgroundColor: Color(0xFF00B894),
                      ),
                    );
                  },
                  child: const Text('Browse Device'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Add notes for the teacher (optional)...',
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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
                content: Text('Assignment Submitted Successfully! 🚀'),
                backgroundColor: Color(0xFF00B894),
              ),
            );
          },
          child: const Text('Submit Assignment Now'),
        ),
      ],
    );
  }

  // 6. AI DOUBT ASSISTANT VIEW (Ask AI)
  Widget _buildAiDoubtView(Color primaryColor) {
    final suggestedPrompts = [
      'Explain Pythagoras Theorem',
      'What is Photosynthesis in plants?',
      'Formulas of Surface Area & Volume',
      'Difference between Speed and Velocity',
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          children: [
            // AI Header Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.08),
                border: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.smart_toy, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VortiQen AI Doubt Companion', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        Text('Instant step-by-step explanations powered by AI', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B894).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('24/7 ONLINE', style: TextStyle(color: Color(0xFF00B894), fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Chat Message List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _aiChatHistory.length,
                itemBuilder: (context, index) {
                  final msg = _aiChatHistory[index];
                  final isAi = msg['sender'] == 'ai';

                  return Align(
                    alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      constraints: BoxConstraints(maxWidth: context.screenWidth >= 600 ? 560 : context.screenWidth * 0.8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isAi ? Colors.white : primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft: isAi ? const Radius.circular(4) : const Radius.circular(18),
                          bottomRight: isAi ? const Radius.circular(18) : const Radius.circular(4),
                        ),
                        border: isAi ? Border.all(color: const Color(0xFFE2E8F0)) : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        msg['text']!,
                        style: TextStyle(
                          color: isAi ? const Color(0xFF2D3436) : Colors.white,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Suggested Prompt Chips
            Container(
              height: 38,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: suggestedPrompts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(suggestedPrompts[index], style: const TextStyle(fontSize: 11)),
                      onPressed: () {
                        _submitAiQuery(suggestedPrompts[index]);
                      },
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                    ),
                  );
                },
              ),
            ),

            // Chat Input Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _aiQueryController,
                      decoration: InputDecoration(
                        hintText: 'Ask any doubt or formula...',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                      onSubmitted: _submitAiQuery,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF0984E3), Color(0xFF00CEC9)]),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () {
                        if (_aiQueryController.text.trim().isNotEmpty) {
                          _submitAiQuery(_aiQueryController.text.trim());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAiQuery(String query) {
    if (query.isEmpty) return;

    setState(() {
      _aiChatHistory.add({'sender': 'user', 'text': query});
      _aiQueryController.clear();

      String aiResponse = 'Here is the step-by-step breakdown for "$query":\n\n1. Concept Core: This topic involves foundational principles from your Class 10 Syllabus.\n2. Key Formula / Rule: Refer to NCERT Chapter equations.\n3. Exam Tip: Remember to write units (e.g. m/s², Joules) in final answers to secure full marks!';
      if (query.toLowerCase().contains('pythagoras')) {
        aiResponse = '📐 Pythagoras Theorem:\n"In a right-angled triangle, the square of the hypotenuse is equal to the sum of the squares of the other two sides."\n\nFormula: a² + b² = c²\nExample: If Base = 3 cm and Perpendicular = 4 cm, Hypotenuse = √(3² + 4²) = √25 = 5 cm.';
      } else if (query.toLowerCase().contains('photosynthesis')) {
        aiResponse = '🌿 Photosynthesis:\nThe biological process where green plants convert light energy into chemical energy (glucose) using CO₂ and H₂O.\n\nEquation: 6CO₂ + 6H₂O + Sunlight ➔ C₆H₁₂O₆ + 6O₂\nLocation: Takes place in Chloroplasts containing Chlorophyll.';
      }

      _aiChatHistory.add({'sender': 'ai', 'text': aiResponse});
    });
  }

  IconData _getSubjectIcon(String subject) {
    if (subject.contains('Math')) return Icons.calculate;
    if (subject.contains('Physics')) return Icons.bolt;
    if (subject.contains('Chemistry')) return Icons.science;
    if (subject.contains('Biology')) return Icons.biotech;
    if (subject.contains('Computer')) return Icons.terminal;
    if (subject.contains('Social')) return Icons.public;
    if (subject.contains('Literature') || subject.contains('English')) return Icons.auto_stories;
    return Icons.menu_book;
  }
}
