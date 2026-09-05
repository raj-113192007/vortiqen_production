import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'utils/report_card_pdf.dart';

class ExamsAndResultsScreen extends ConsumerStatefulWidget {
  const ExamsAndResultsScreen({super.key});

  @override
  ConsumerState<ExamsAndResultsScreen> createState() => _ExamsAndResultsScreenState();
}

class _ExamsAndResultsScreenState extends ConsumerState<ExamsAndResultsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _mockExamsData = [
    {
      'name': 'Mid-Term Examinations 2026',
      'status': 'PUBLISHED',
      'gpa': '9.6 / 10.0',
      'percentage': '95.2%',
      'rank': '#3 in Class 10-A',
      'subjects': [
        {'subjectName': 'Mathematics', 'marksObtained': 98, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'Physics', 'marksObtained': 95, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'Chemistry', 'marksObtained': 92, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'Computer Science', 'marksObtained': 99, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'English Literature', 'marksObtained': 92, 'maxMarks': 100, 'grade': 'A1'},
      ],
    },
    {
      'name': 'Quarterly Assessment 1',
      'status': 'COMPLETED',
      'gpa': '9.2 / 10.0',
      'percentage': '92.4%',
      'rank': '#5 in Class 10-A',
      'subjects': [
        {'subjectName': 'Mathematics', 'marksObtained': 94, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'Physics', 'marksObtained': 90, 'maxMarks': 100, 'grade': 'A2'},
        {'subjectName': 'Chemistry', 'marksObtained': 88, 'maxMarks': 100, 'grade': 'A2'},
        {'subjectName': 'Computer Science', 'marksObtained': 98, 'maxMarks': 100, 'grade': 'A1'},
        {'subjectName': 'English Literature', 'marksObtained': 91, 'maxMarks': 100, 'grade': 'A1'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Exams & Report Cards'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.analytics, size: 20), text: 'Results & Marksheet'),
            Tab(icon: Icon(Icons.event_note, size: 20), text: 'Upcoming Schedule'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildResultsTab(context, primaryColor),
          _buildScheduleTab(context, primaryColor),
        ],
      ),
    );
  }

  Widget _buildResultsTab(BuildContext context, Color primaryColor) {
    final latestExam = _mockExamsData[0];
    final subjects = latestExam['subjects'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1300,
        child: ResponsiveTwoPane(
          breakpoint: 880,
          leftFlex: 5,
          rightFlex: 7,
          spacing: 24,
          leftPane: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Overall GPA & Performance Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF0984E3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
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
                              latestExam['name'],
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Outstanding Performance! 🏆',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            latestExam['rank'],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildResultScoreMetric('Overall Score', latestExam['percentage']),
                        _buildResultScoreMetric('Cumulative GPA', latestExam['gpa']),
                        _buildResultScoreMetric('Grade', 'A1 Distinction'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Download Official PDF Report Card Action
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ReportCardPdf.generateAndPrint('Aarav Sharma', _mockExamsData);
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Download Official Report Card (PDF)', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0984E3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
          rightPane: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. Subject-wise Marks Breakdown Table
              const Text(
                'Subject-wise Marks & Grades',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final sub = subjects[index];
                  final marks = sub['marksObtained'] as int;
                  final max = sub['maxMarks'] as int;
                  final ratio = marks / max;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0984E3).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.menu_book, color: Color(0xFF0984E3), size: 20),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  sub['subjectName'],
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '$marks / $max',
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00B894).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    sub['grade'],
                                    style: const TextStyle(
                                      color: Color(0xFF00B894),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CEC9)),
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
      ),
    );
  }

  Widget _buildResultScoreMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildScheduleTab(BuildContext context, Color primaryColor) {
    final upcomingExams = [
      {
        'subject': 'Science (Physics & Chem)',
        'date': '15 Sept 2026',
        'time': '09:00 AM - 12:00 PM',
        'room': 'Hall A (Seat #24)',
        'maxMarks': '80',
        'syllabus': 'Units 1-4: Light, Electricity, Chemical Reactions',
      },
      {
        'subject': 'Mathematics',
        'date': '18 Sept 2026',
        'time': '09:00 AM - 12:00 PM',
        'room': 'Hall A (Seat #24)',
        'maxMarks': '80',
        'syllabus': 'Quadratic Equations, Triangles, Trigonometry',
      },
      {
        'subject': 'English Language & Lit',
        'date': '21 Sept 2026',
        'time': '09:00 AM - 12:00 PM',
        'room': 'Hall A (Seat #24)',
        'maxMarks': '80',
        'syllabus': 'Reading Comprehension, Essay, Drama Section',
      },
      {
        'subject': 'Social Science',
        'date': '24 Sept 2026',
        'time': '09:00 AM - 12:00 PM',
        'room': 'Hall A (Seat #24)',
        'maxMarks': '80',
        'syllabus': 'History (Ch 1-2), Geography (Ch 1-3), Civics',
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
                  childAspectRatio: 1.55,
                ),
                itemCount: upcomingExams.length,
                itemBuilder: (context, index) => _buildExamScheduleCard(context, upcomingExams[index], primaryColor),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingExams.length,
                itemBuilder: (context, index) => _buildExamScheduleCard(context, upcomingExams[index], primaryColor),
              ),
      ),
    );
  }

  Widget _buildExamScheduleCard(BuildContext context, Map<String, String> exam, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
                      exam['date']!,
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 11),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Max: ${exam['maxMarks']} Marks',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10, color: Color(0xFF475569)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                exam['subject']!,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(exam['time']!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(width: 14),
                  Icon(Icons.meeting_room_outlined, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(exam['room']!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Syllabus: ${exam['syllabus']}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
