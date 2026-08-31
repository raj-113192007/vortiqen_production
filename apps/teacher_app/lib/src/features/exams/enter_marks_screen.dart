import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class EnterMarksScreen extends ConsumerStatefulWidget {
  final ExamSubject subject;
  final String classId;

  const EnterMarksScreen({
    super.key,
    required this.subject,
    required this.classId,
  });

  @override
  ConsumerState<EnterMarksScreen> createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends ConsumerState<EnterMarksScreen> {
  final Map<String, TextEditingController> _marksControllers = {};
  final Map<String, TextEditingController> _gradesControllers = {};
  bool _isLoading = false;

  @override
  void dispose() {
    for (var c in _marksControllers.values) {
      c.dispose();
    }
    for (var c in _gradesControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _initializeControllers(List<Student> students) {
    for (var student in students) {
      if (!_marksControllers.containsKey(student.id)) {
        final existing = widget.subject.results.where((r) => r.studentId == student.id).firstOrNull;
        _marksControllers[student.id] = TextEditingController(text: existing?.marksObtained?.toString() ?? '');
        _gradesControllers[student.id] = TextEditingController(text: existing?.grade ?? '');
      }
    }
  }

  String _calculateGrade(double marks, double maxMarks) {
    if (maxMarks <= 0) return 'A';
    final pct = (marks / maxMarks) * 100;
    if (pct >= 90) return 'A+';
    if (pct >= 80) return 'A';
    if (pct >= 70) return 'B+';
    if (pct >= 60) return 'B';
    if (pct >= 50) return 'C';
    if (pct >= 33) return 'D';
    return 'F';
  }

  String _getStudentName(Student s) {
    if (s.user?.name != null && s.user!.name.isNotEmpty) {
      return s.user!.name;
    }
    final name = '${s.firstName} ${s.lastName ?? ""}'.trim();
    return name.isNotEmpty ? name : 'Scholar';
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(examsRepositoryProvider);
      final results = <Map<String, dynamic>>[];

      for (var studentId in _marksControllers.keys) {
        final marksText = _marksControllers[studentId]!.text;
        final gradeText = _gradesControllers[studentId]!.text;

        if (marksText.isNotEmpty || gradeText.isNotEmpty) {
          results.add({
            'studentId': studentId,
            'marksObtained': marksText.isNotEmpty ? double.tryParse(marksText) : null,
            'grade': gradeText.isNotEmpty ? gradeText : null,
          });
        }
      }

      await repo.submitMarks(widget.subject.id, results);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Marks & Grades submitted successfully! 🏆'),
            backgroundColor: Color(0xFF10B981),
          ),
        );
        ref.invalidate(examsProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving marks: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(studentListProvider({'classId': widget.classId}));
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Enter Marks - ${widget.subject.subjectName ?? "Subject"}'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
        titleTextStyle: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w800, fontSize: 16),
        actions: [
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _submit,
            icon: _isLoading
                ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.check_rounded, size: 16),
            label: const Text('Save Marksheet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: studentsAsync.when(
        data: (students) {
          if (students.isEmpty) {
            return const Center(child: Text('No students found in this class.'));
          }

          _initializeControllers(students);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paper: ${widget.subject.subjectName ?? "Subject"}',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(height: 2),
                          Text('Max Marks: ${widget.subject.maxMarks} • Passing Marks: ${(widget.subject.maxMarks * 0.33).toInt()}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text('${students.length} Scholars Enrolled', style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Spreadsheet Rows
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    final sName = _getStudentName(student);
                    final marksCtrl = _marksControllers[student.id]!;
                    final gradesCtrl = _gradesControllers[student.id]!;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                            child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF64748B))),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.12),
                            child: Text(sName.isNotEmpty ? sName[0] : 'S', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF10B981), fontSize: 12)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                                Text('Roll No: ${student.rollNo}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                          // Marks Input
                          SizedBox(
                            width: 90,
                            height: 38,
                            child: TextField(
                              controller: marksCtrl,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: '0 - ${widget.subject.maxMarks}',
                                hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onChanged: (val) {
                                final marks = double.tryParse(val);
                                if (marks != null) {
                                  gradesCtrl.text = _calculateGrade(marks, widget.subject.maxMarks.toDouble());
                                } else {
                                  gradesCtrl.clear();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Auto Computed Grade Badge
                          SizedBox(
                            width: 60,
                            height: 38,
                            child: TextField(
                              controller: gradesCtrl,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF10B981)),
                              decoration: InputDecoration(
                                hintText: 'Grade',
                                hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              ),
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
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading students: $err')),
      ),
    );
  }
}
