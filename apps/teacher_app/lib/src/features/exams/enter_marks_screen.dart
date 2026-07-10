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
        // Pre-fill if exists
        final existing = widget.subject.results.where((r) => r.studentId == student.id).firstOrNull;
        _marksControllers[student.id] = TextEditingController(text: existing?.marksObtained?.toString() ?? '');
        _gradesControllers[student.id] = TextEditingController(text: existing?.grade ?? '');
      }
    }
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
          results.push({
            'studentId': studentId,
            'marksObtained': marksText.isNotEmpty ? double.tryParse(marksText) : null,
            'grade': gradeText.isNotEmpty ? gradeText : null,
          });
        }
      }

      await repo.submitMarks(widget.subject.id, results);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marks submitted successfully!')),
        );
        ref.invalidate(examsProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Marks - ${widget.subject.subjectName}'),
        actions: [
          if (!studentsAsync.isLoading && !studentsAsync.hasError)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isLoading ? null : _submit,
            )
        ],
      ),
      body: studentsAsync.when(
        data: (students) {
          _initializeControllers(students);

          if (students.isEmpty) {
            return const Center(child: Text('No students found in this class.'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text('${student.firstName} ${student.lastName ?? ''}'),
                subtitle: Text('Roll No: ${student.rollNo}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _marksControllers[student.id],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Marks',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _gradesControllers[student.id],
                        decoration: const InputDecoration(
                          labelText: 'Grade',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

extension on List {
  void push(dynamic item) => add(item);
}
