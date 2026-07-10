import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class ExamsListScreen extends ConsumerWidget {
  const ExamsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Exam',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => const CreateExamModal(),
              );
            },
          ),
        ],
      ),
      body: examsAsync.when(
        data: (exams) {
          if (exams.isEmpty) {
            return const Center(child: Text('No exams found. Create one.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return Card(
                color: Colors.white.withValues(alpha: 0.05),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(exam.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text('Status: ${exam.status}', style: const TextStyle(color: Colors.white54)),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                  onTap: () {
                    context.push('/exams/${exam.id}', extra: exam);
                  },
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

class CreateExamModal extends ConsumerStatefulWidget {
  const CreateExamModal({super.key});

  @override
  ConsumerState<CreateExamModal> createState() => _CreateExamModalState();
}

class _CreateExamModalState extends ConsumerState<CreateExamModal> {
  final _nameController = TextEditingController();
  String? _selectedClassId;
  bool _isLoading = false;

  void _handleSubmit() async {
    if (_nameController.text.isEmpty || _selectedClassId == null) return;
    setState(() => _isLoading = true);

    try {
      await ref.read(examsRepositoryProvider).createExam(
        classId: _selectedClassId!,
        name: _nameController.text,
      );
      if (mounted) {
        Navigator.pop(context);
        ref.invalidate(examsProvider);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam created')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);

    return Dialog(
      backgroundColor: const Color(0xFF1E1E2C),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create New Exam', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            classesAsync.when(
              data: (classes) => DropdownButtonFormField<String>(
                initialValue: _selectedClassId,
                dropdownColor: const Color(0xFF2A2A3C),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  hintText: 'Select Class',
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                items: classes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                onChanged: (val) => setState(() => _selectedClassId = val),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text('Error loading classes', style: const TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Exam Name (e.g. Mid-Term)',
                hintStyle: const TextStyle(color: Colors.white54),
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
                  child: _isLoading ? const CircularProgressIndicator() : const Text('Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

