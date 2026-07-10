import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class ReportsListScreen extends ConsumerWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(savedReportsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Reports'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Generate Now'),
            onPressed: () async {
              try {
                await ref.read(analyticsRepositoryProvider).generateReportNow();
                ref.invalidate(savedReportsProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report generated successfully!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error generating report: $e')),
                  );
                }
              }
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: reportsAsync.when(
        data: (reports) {
          if (reports.isEmpty) {
            return const Center(child: Text('No reports generated yet.'));
          }
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  leading: const Icon(Icons.assessment, color: Colors.blue),
                  title: Text('${report.type} - ${DateFormat('MMMM yyyy').format(report.month)}'),
                  subtitle: Text('Generated on ${DateFormat('MMM dd, yyyy').format(report.createdAt)}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          report.summary,
                          style: const TextStyle(fontSize: 14, height: 1.5),
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
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
