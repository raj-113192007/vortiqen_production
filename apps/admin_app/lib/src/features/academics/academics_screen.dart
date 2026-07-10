import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

final adminSubjectsProvider = FutureProvider<List<Subject>>((ref) {
  return ref.watch(academicsRepositoryProvider).getSubjects('1');
});

class AcademicsScreen extends ConsumerWidget {
  const AcademicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsync = ref.watch(classesProvider);
    final subjectsAsync = ref.watch(adminSubjectsProvider);

    return Scaffold(
      body: classesAsync.when(
        data: (classes) {
          if (classes.isEmpty) {
            return const Center(
              child: Text(
                'No classes added yet.\nClick + to create a new class.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final academicClass = classes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: ExpansionTile(
                  title: Text(
                    academicClass.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    '${academicClass.sections.length} Sections • \u20B9${academicClass.monthlyFee}/month',
                    style: const TextStyle(color: Colors.white54),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white54,
                  children: [
                    const ListTile(
                      title: Text('Sections', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    ...academicClass.sections.map((section) {
                      return ListTile(
                        leading: const Icon(Icons.group, color: Colors.white54),
                        title: Text(
                          'Section ${section.name}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      );
                    }),
                    const Divider(color: Colors.white24),
                    const ListTile(
                      title: Text('Subjects', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    ...subjectsAsync.when(
                      data: (subjects) {
                        final classSubjects = subjects.where((s) => s.classId == academicClass.id).toList();
                        if (classSubjects.isEmpty) {
                          return [const ListTile(title: Text('No subjects added', style: TextStyle(color: Colors.white54)))];
                        }
                        return classSubjects.map((subject) {
                          return ListTile(
                            leading: const Icon(Icons.book, color: Colors.white54),
                            title: Text(
                              subject.name,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: subject.teacher != null 
                              ? Chip(label: Text(subject.teacher!.name, style: const TextStyle(fontSize: 10)))
                              : const SizedBox.shrink(),
                          );
                        }).toList();
                      },
                      loading: () => [const Center(child: CircularProgressIndicator())],
                      error: (err, stack) => [ListTile(title: Text('Error loading subjects', style: TextStyle(color: Colors.red)))],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load classes: $err',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(classesProvider),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Open add class modal
          showDialog(
            context: context,
            builder: (ctx) => const AddClassModal(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Class'),
      ),
    );
  }
}

class AddClassModal extends ConsumerStatefulWidget {
  const AddClassModal({super.key});

  @override
  ConsumerState<AddClassModal> createState() => _AddClassModalState();
}

class _AddClassModalState extends ConsumerState<AddClassModal> {
  final _nameController = TextEditingController();
  final _sectionsController = TextEditingController();
  final _monthlyFeeController = TextEditingController();
  bool _isLoading = false;

  void _handleSubmit() async {
    if (_nameController.text.isEmpty || _sectionsController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final sectionNames = _sectionsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final monthlyFee = double.tryParse(_monthlyFeeController.text) ?? 0.0;

      await ref.read(academicsRepositoryProvider).createClass(
            _nameController.text,
            sectionNames,
            monthlyFee: monthlyFee,
          );

      if (mounted) {
        Navigator.pop(context); // Close modal
        ref.invalidate(classesProvider); // Refresh list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Class added successfully!')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Class',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Class Name (e.g. Grade 10)',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _sectionsController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Sections (comma separated, e.g. A,B,C)',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _monthlyFeeController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Base Monthly Fee (\u20B9)',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

