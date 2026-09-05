import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentReportCardScreen extends StatelessWidget {
  final String childName;
  const ParentReportCardScreen({super.key, this.childName = 'Aarav Sharma'});

  final List<Map<String, dynamic>> _subjectMarks = const [
    {
      'subject': 'Mathematics',
      'marks': 96,
      'maxMarks': 100,
      'grade': 'A1',
      'classAvg': 74.2,
      'color': Color(0xFF0984E3),
      'teacher': 'Mr. Anil Kapoor',
    },
    {
      'subject': 'Computer Science (Python & SQL)',
      'marks': 98,
      'maxMarks': 100,
      'grade': 'A1',
      'classAvg': 81.0,
      'color': Color(0xFF6C5CE7),
      'teacher': 'Mr. Rajesh Mehra',
    },
    {
      'subject': 'Physics',
      'marks': 94,
      'maxMarks': 100,
      'grade': 'A1',
      'classAvg': 71.5,
      'color': Color(0xFF00B894),
      'teacher': 'Dr. Priya Verma',
    },
    {
      'subject': 'English Core',
      'marks': 90,
      'maxMarks': 100,
      'grade': 'A1',
      'classAvg': 76.8,
      'color': Color(0xFFE17055),
      'teacher': 'Ms. Sarah Jenkins',
    },
    {
      'subject': 'Chemistry',
      'marks': 88,
      'maxMarks': 100,
      'grade': 'A2',
      'classAvg': 68.4,
      'color': Color(0xFFF39C12),
      'teacher': 'Mrs. Kavita Roy',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Academic Report Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Student: $childName • Term 1 (Session 2026-27)', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Color(0xFF6366F1)),
            tooltip: 'Download PDF Report Card',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading Signed Official CBSE Report Card PDF...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // High GPA Hero Banner
              AnimatedCard(
                padding: const EdgeInsets.all(24),
                color: const Color(0xFF0F172A),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF818CF8)),
                      ),
                      child: const Icon(Icons.emoji_events_rounded, size: 36, color: Color(0xFFFBBF24)),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CUMULATIVE TERM 1 SCORE', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          const Text('93.2% (Grade A1 Distinction)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                          const SizedBox(height: 4),
                          Text('Class Rank: #3 of 42 Students • Percentile: 96.8th', style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Report Card PDF Download Initiated!')),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf, color: Colors.white, size: 16),
                      label: const Text('Download PDF', style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white54)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Subject Marks Table & Progress
              AnimatedCard(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE2E8F0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Subject-wise Performance Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                    const SizedBox(height: 16),
                    ..._subjectMarks.map((sub) {
                      final pct = (sub['marks'] as int) / (sub['maxMarks'] as int);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(color: sub['color'] as Color, shape: BoxShape.circle),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(sub['subject'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('${sub['marks']} / ${sub['maxMarks']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                                      child: Text(sub['grade'] as String, style: const TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 11)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: pct,
                                minHeight: 8,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: AlwaysStoppedAnimation<Color>(sub['color'] as Color),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Class Avg: ${sub['classAvg']}%', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                Text('Taught by: ${sub['teacher']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Teacher Remarks Card
              AnimatedCard(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFFF8FAFC),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.rate_review_outlined, color: Color(0xFF6366F1), size: 20),
                        SizedBox(width: 8),
                        Text('Class Teacher & Principal Remarks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '"Aarav is an exceptionally diligent, disciplined, and intellectually curious student. He shows stellar problem-solving capability in Mathematics and Python coding. Recommended to actively represent the school in the upcoming State Level STEM Olympiad."',
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dr. Priya Verma\nClass Teacher', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        Text('Dr. Rajeshwar Shastri\nPrincipal & Director', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                      ],
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
