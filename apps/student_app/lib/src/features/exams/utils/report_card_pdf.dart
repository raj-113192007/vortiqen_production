import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportCardPdf {
  static Future<void> generateAndPrint(String studentName, List<dynamic> exams) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          final children = <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text('VortiQen Public School', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Report Card', style: const pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 16),
            pw.Text('Student: $studentName', style: const pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 24),
          ];

          for (var exam in exams) {
            children.add(
              pw.Text(exam['name'] ?? 'Exam', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            );
            children.add(pw.SizedBox(height: 8));
            
            final subjects = (exam['subjects'] as List<dynamic>).cast<Map<String, dynamic>>();
            children.add(
              pw.TableHelper.fromTextArray(
                headers: ['Subject', 'Marks Obtained', 'Max Marks', 'Grade'],
                data: subjects.map((s) {
                  return [
                    s['subjectName']?.toString() ?? '-',
                    s['marksObtained']?.toString() ?? 'N/A',
                    s['maxMarks']?.toString() ?? '-',
                    s['grade']?.toString() ?? '-',
                  ];
                }).toList(),
              ),
            );
            children.add(pw.SizedBox(height: 24));
          }

          children.add(pw.SizedBox(height: 48));
          children.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Class Teacher Signature'),
                pw.Text('Principal Signature'),
              ],
            )
          );

          return children;
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
