import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import '../../academics/academics_screen.dart';

class ExamDetailsScreen extends ConsumerWidget {
  final Exam exam;

  const ExamDetailsScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examDetailsAsync = ref.watch(examDetailsProvider(exam.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('${exam.name} Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Subject',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AddExamSubjectModal(exam: exam),
              );
            },
          ),
        ],
      ),
      body: examDetailsAsync.when(
        data: (detailedExam) {
          final subjects = detailedExam.subjects;
          if (subjects.isEmpty) {
            return const Center(child: Text('No subjects added to this exam yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final exSub = subjects[index];
              return Card(
                color: Colors.white.withValues(alpha: 0.05),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(exSub.subjectName ?? 'Unknown Subject', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text('Max Marks: ${exSub.maxMarks}', style: const TextStyle(color: Colors.white54)),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class AddExamSubjectModal extends ConsumerStatefulWidget {
  final Exam exam;
  const AddExamSubjectModal({super.key, required this.exam});

  @override
  ConsumerState<AddExamSubjectModal> createState() => _AddExamSubjectModalState();
}

class _AddExamSubjectModalState extends ConsumerState<AddExamSubjectModal> {
  String? _selectedSubjectId;
  final _maxMarksController = TextEditingController(text: '100');
  bool _isLoading = false;

  void _handleSubmit() async {
    if (_selectedSubjectId == null) return;
    setState(() => _isLoading = true);

    try {
      await ref.read(examsRepositoryProvider).addExamSubject(
        examId: widget.exam.id,
        subjectId: _selectedSubjectId!,
        maxMarks: double.tryParse(_maxMarksController.text) ?? 100.0,
      );
      if (mounted) {
        Navigator.pop(context);
        ref.invalidate(examDetailsProvider(widget.exam.id));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject added')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(adminSubjectsProvider);

    return Dialog(
      backgroundColor: const Color(0xFF1E1E2C),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Subject to Exam', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            subjectsAsync.when(
              data: (subjects) {
                final classSubjects = subjects.where((s) => s.classId == widget.exam.classId).toList();
                return DropdownButtonFormField<String>(
                  initialValue: _selectedSubjectId,
                  dropdownColor: const Color(0xFF2A2A3C),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    hintText: 'Select Subject',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  items: classSubjects.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
                  onChanged: (val) => setState(() => _selectedSubjectId = val),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error loading subjects'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _maxMarksController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                labelText: 'Max Marks',
                labelStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  child: _isLoading ? const CircularProgressIndicator() : const Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

