import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class ReportCardScreen extends ConsumerWidget {
  const ReportCardScreen({super.key});

  Future<void> _generateAndPrintPdf(BuildContext context, String studentName, List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('VortiQen Public School', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Report Card', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 16),
              pw.Text('Student: $studentName', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 24),
              pw.TableHelper.fromTextArray(
                headers: ['Subject', 'Exam', 'Marks Obtained', 'Max Marks', 'Grade'],
                data: data.map((r) {
                  return [
                    r['subjectName'].toString(),
                    r['examName'].toString(),
                    r['marksObtained']?.toString() ?? 'N/A',
                    r['maxMarks'].toString(),
                    r['grade']?.toString() ?? '-',
                  ];
                }).toList(),
              ),
              pw.SizedBox(height: 48),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Class Teacher Signature'),
                  pw.Text('Principal Signature'),
                ],
              )
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value?.user;
    // For MVP, we assume the logged in user is a STUDENT and use their id
    final studentId = user?.id ?? '';
    final studentName = user?.name ?? 'Student';
    
    final reportCardAsync = ref.watch(studentReportCardProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Report Card'),
      ),
      body: reportCardAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No exam results published yet.'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () => _generateAndPrintPdf(context, studentName, data),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Download PDF'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final row = data[index];
                    return Card(
                      color: Colors.white.withValues(alpha: 0.05),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(row['subjectName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${row['examName']} - Max: ${row['maxMarks']}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${row['marksObtained'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                            ),
                            if (row['grade'] != null) Text('Grade: ${row['grade']}', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

