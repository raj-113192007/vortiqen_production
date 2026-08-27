import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

import '../onboarding/presentation/data_onboarding_hub_screen.dart';

final adminStudentsProvider = FutureProvider<List<Student>>((ref) {
  return ref.watch(studentsRepositoryProvider).getStudents('1');
});

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students Directory',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Wrap(
                  spacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DataOnboardingHubScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.cloud_upload_rounded),
                      label: const Text('Bulk Import & Onboard'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Quick enroll
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Quick Add'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildStudentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsList() {
    final studentsAsync = ref.watch(adminStudentsProvider);

    return studentsAsync.when(
      data: (students) {
        if (students.isEmpty) {
          return const Center(child: Text('No students found.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(student.user?.name[0].toUpperCase() ?? '?'),
                ),
                title: Text('${student.firstName} ${student.lastName ?? ""}'),
                subtitle: Text('Roll No: ${student.rollNo}'),
                trailing: const Chip(label: Text('Enrolled')),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
