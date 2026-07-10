import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admissions_provider.dart';
import 'package:go_router/go_router.dart';

class AdmissionsListScreen extends ConsumerWidget {
  const AdmissionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enquiriesAsync = ref.watch(admissionsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/admissions/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Enquiry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admission Enquiries',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: enquiriesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (enquiries) {
                  if (enquiries.isEmpty) {
                    return const Center(child: Text('No enquiries found.'));
                  }
                  return ListView.builder(
                    itemCount: enquiries.length,
                    itemBuilder: (context, index) {
                      final enquiry = enquiries[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text('${enquiry.studentName} (Parent: ${enquiry.parentName})'),
                          subtitle: Text('Class: ${enquiry.classApplied ?? 'N/A'} | Phone: ${enquiry.phone}'),
                          trailing: Chip(
                            label: Text(enquiry.status),
                            backgroundColor: _getStatusColor(enquiry.status),
                          ),
                          onTap: () {
                            // Can show dialog to update status
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.orangeAccent.withValues(alpha: 0.3);
      case 'INTERVIEW_SCHEDULED':
        return Colors.blueAccent.withValues(alpha: 0.3);
      case 'APPROVED':
        return Colors.green.withValues(alpha: 0.3);
      case 'REJECTED':
        return Colors.red.withValues(alpha: 0.3);
      default:
        return Colors.grey.withValues(alpha: 0.3);
    }
  }
}

