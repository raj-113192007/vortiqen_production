import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ExamsScreen extends ConsumerWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams & Marks'),
      ),
      body: examsAsync.when(
        data: (exams) {
          if (exams.isEmpty) {
            return const Center(child: Text('No exams found.'));
          }
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  title: Text(exam.name),
                  subtitle: Text('Class: ${exam.className ?? 'Unknown'} | Status: ${exam.status}'),
                  children: [
                    if (exam.subjects.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No subjects added to this exam.'),
                      )
                    else
                      ...exam.subjects.map((sub) => ListTile(
                            title: Text(sub.subjectName ?? 'Unknown Subject'),
                            subtitle: Text('Date: ${sub.examDate?.toLocal().toString().split(' ')[0] ?? 'TBD'} | Max Marks: ${sub.maxMarks}'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                context.push('/exams/subjects/${sub.id}/marks', extra: {
                                  'subject': sub,
                                  'classId': exam.classId,
                                });
                              },
                              child: const Text('Enter Marks'),
                            ),
                          )),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/exams/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Exam'),
      ),
    );
  }
}
