import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ClassDiaryScreen extends StatefulWidget {
  const ClassDiaryScreen({super.key});

  @override
  State<ClassDiaryScreen> createState() => _ClassDiaryScreenState();
}

class _ClassDiaryScreenState extends State<ClassDiaryScreen> {
  final _topicController = TextEditingController();
  final _homeworkNoteController = TextEditingController();
  String _selectedClass = 'Class 10-A';
  String _selectedSubject = 'Mathematics';

  final List<Map<String, String>> _diaryLogs = [
    {
      'date': 'Today, 31 Aug 2026',
      'class': 'Class 10-A',
      'subject': 'Mathematics',
      'topic': 'Chapter 4: Quadratic Equations - Derivation of the Quadratic Formula & solving Ex 4.2',
      'homework': 'Solve Questions 1 to 5 from Exercise 4.3 in notebook',
      'teacher': 'Mr. Sharma',
    },
    {
      'date': '29 Aug 2026',
      'class': 'Class 9-B',
      'subject': 'Physics',
      'topic': 'Laws of Motion: Newton Second Law (F = m*a) with real-world collision examples',
      'homework': 'Read textbook pages 104-108 and answer NCERT In-text questions',
      'teacher': 'Mr. Sharma',
    },
    {
      'date': '28 Aug 2026',
      'class': 'Class 8-C',
      'subject': 'Geometry',
      'topic': 'Triangles and Properties: Angle Sum Property theorem proofs',
      'homework': 'Draw and measure 3 acute and obtuse triangles with protractor',
      'teacher': 'Mr. Sharma',
    },
  ];

  void _submitDiaryEntry() {
    if (_topicController.text.isEmpty) return;

    setState(() {
      _diaryLogs.insert(0, {
        'date': 'Today, ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
        'class': _selectedClass,
        'subject': _selectedSubject,
        'topic': _topicController.text,
        'homework': _homeworkNoteController.text.isNotEmpty ? _homeworkNoteController.text : 'None assigned',
        'teacher': 'Me',
      });
      _topicController.clear();
      _homeworkNoteController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Class Diary log saved & broadcast to Parent App! 📢'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(),
          ),
          const SizedBox(height: 20),

          // Log New Class Diary Entry Form
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: _buildNewEntryCard(),
          ),
          const SizedBox(height: 24),

          // Past Diary Feed
          FadeSlideEntry(
            delay: const Duration(milliseconds: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Class Diary Logs',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _diaryLogs.length,
                  itemBuilder: (context, index) {
                    final log = _diaryLogs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: HoverLiftCard(
                        padding: const EdgeInsets.all(18),
                        borderRadius: 14,
                        hoverBorderColor: const Color(0xFF10B981).withValues(alpha: 0.4),
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
                                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${log['class']} • ${log['subject']}',
                                        style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w800, fontSize: 11),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      log['date']!,
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.menu_book_rounded, color: Color(0xFF94A3B8), size: 18),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Topics Taught:',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              log['topic']!,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B), height: 1.4),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.assignment_outlined, size: 16, color: Color(0xFF6C5CE7)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Homework Note: ${log['homework']}',
                                      style: const TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Daily Diary & Lesson Logger',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Log Syllabus Progress, Topics Covered in Each Period & Daily Homework Notes for Parents',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Icon(Icons.edit_note_rounded, color: Color(0xFF10B981), size: 36),
        ],
      ),
    );
  }

  Widget _buildNewEntryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Write Today’s Class Diary Entry', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedClass,
                  decoration: InputDecoration(
                    labelText: 'Target Class',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  items: ['Class 10-A', 'Class 9-B', 'Class 8-C'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) => setState(() => _selectedClass = val!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedSubject,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  items: ['Mathematics', 'Physics', 'Geometry', 'Science Lab'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setState(() => _selectedSubject = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _topicController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Topics Covered in Period Today',
              hintText: 'e.g. Chapter 4: Formula derivation and solved Examples 1 to 4',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _homeworkNoteController,
            decoration: InputDecoration(
              labelText: 'Homework / Notebook Instruction (Optional)',
              hintText: 'e.g. Complete Exercise 4.2 in homework notebook for check tomorrow',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _submitDiaryEntry,
              icon: const Icon(Icons.send_rounded, size: 16),
              label: const Text('Post to Class Diary'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
