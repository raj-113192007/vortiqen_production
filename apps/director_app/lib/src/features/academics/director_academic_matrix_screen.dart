import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorAcademicMatrixScreen extends StatelessWidget {
  const DirectorAcademicMatrixScreen({super.key});

  final List<Map<String, dynamic>> _classBenchmarks = const [
    {'class': 'Class 12 (Senior Secondary)', 'avgGpa': '8.9 / 10', 'passPct': '99.2%', 'syllabusCovered': 0.96, 'distinctions': '42 Students', 'color': Color(0xFF6366F1)},
    {'class': 'Class 10 (Secondary Board)', 'avgGpa': '8.8 / 10', 'passPct': '98.8%', 'syllabusCovered': 0.94, 'distinctions': '56 Students', 'color': Color(0xFF10B981)},
    {'class': 'Class 11 (Science & Commerce)', 'avgGpa': '8.4 / 10', 'passPct': '96.5%', 'syllabusCovered': 0.88, 'distinctions': '38 Students', 'color': Color(0xFF0984E3)},
    {'class': 'Class 9 (Foundation)', 'avgGpa': '8.2 / 10', 'passPct': '95.0%', 'syllabusCovered': 0.90, 'distinctions': '34 Students', 'color': Color(0xFFF59E0B)},
  ];

  final List<Map<String, dynamic>> _facultyMatrix = const [
    {'teacher': 'Dr. Priya Verma', 'dept': 'Physics & STEM', 'rating': '4.9 ★', 'syllabus': '98%', 'studentFeedback': '96% Positive'},
    {'teacher': 'Mr. Anil Kapoor', 'dept': 'Mathematics', 'rating': '4.8 ★', 'syllabus': '95%', 'studentFeedback': '94% Positive'},
    {'teacher': 'Mrs. Kavita Roy', 'dept': 'Chemistry', 'rating': '4.7 ★', 'syllabus': '92%', 'studentFeedback': '91% Positive'},
    {'teacher': 'Mr. Rajesh Mehra', 'dept': 'Computer Science', 'rating': '4.9 ★', 'syllabus': '100%', 'studentFeedback': '98% Positive'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Academic Excellence Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Board Readiness & Curriculum Benchmarks', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class-wise Board Benchmarks
              const Text('Class-by-Class Performance & Syllabus Track', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF0F172A))),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.responsiveGridCount(mobile: 1, tablet: 2, desktop: 2),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.8,
                ),
                itemCount: _classBenchmarks.length,
                itemBuilder: (context, index) {
                  final item = _classBenchmarks[index];
                  final col = item['color'] as Color;

                  return AnimatedCard(
                    padding: const EdgeInsets.all(18),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item['class'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: col.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
                              child: Text('GPA ${item['avgGpa']}', style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 11)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pass Rate: ${item['passPct']}', style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                            Text('Distinctions: ${item['distinctions']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Term 1 Syllabus Completed', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                Text('${((item['syllabusCovered'] as double) * 100).toInt()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: col)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: item['syllabusCovered'] as double,
                                minHeight: 6,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: AlwaysStoppedAnimation<Color>(col),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Faculty Performance Table
              AnimatedCard(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE2E8F0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Faculty Performance & Student Feedback Index', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _facultyMatrix.length,
                      separatorBuilder: (_, __) => const Divider(height: 20),
                      itemBuilder: (context, index) {
                        final f = _facultyMatrix[index];

                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                              child: const Icon(Icons.school, size: 18, color: Color(0xFFB8860B)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f['teacher'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text(f['dept'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(f['rating'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFD97706))),
                                Text('Syllabus: ${f['syllabus']} • ${f['studentFeedback']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
