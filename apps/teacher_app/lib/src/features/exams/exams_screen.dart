import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ExamsScreen extends ConsumerWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          examsAsync.when(
            data: (exams) {
              if (exams.isEmpty) {
                return _buildEmptyState(context);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 80),
                    child: Row(
                      children: [
                        Expanded(child: _buildKpiTile(exams.length.toDouble(), 'Published Exam Series', Icons.workspace_premium_rounded, const Color(0xFF6C5CE7))),
                        const SizedBox(width: 12),
                        Expanded(child: _buildKpiTile(exams.expand((e) => e.subjects).length.toDouble(), 'Total Subject Papers', Icons.subject_rounded, const Color(0xFF10B981))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 140),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        final exam = exams[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: HoverLiftCard(
                            padding: const EdgeInsets.all(18),
                            borderRadius: 16,
                            hoverBorderColor: const Color(0xFF10B981).withValues(alpha: 0.4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(Icons.grade_rounded, color: Color(0xFF6C5CE7), size: 22),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              exam.name,
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Class: ${exam.className ?? "Assigned Wing"} • Status: ${exam.status}',
                                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        exam.status,
                                        style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w800, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                const Divider(color: Color(0xFFF1F5F9), height: 1),
                                const SizedBox(height: 12),

                                if (exam.subjects.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('No subject papers scheduled under this exam series.', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                                  )
                                else
                                  ...exam.subjects.map((sub) => Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: const Color(0xFFE2E8F0)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sub.subjectName ?? 'Subject Paper',
                                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Date: ${sub.examDate != null ? DateFormat('dd MMM yyyy').format(sub.examDate!) : 'Scheduled Soon'} • Max Marks: ${sub.maxMarks}',
                                                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                context.push('/exams/subjects/${sub.id}/marks', extra: {
                                                  'subject': sub,
                                                  'classId': exam.classId,
                                                });
                                              },
                                              icon: const Icon(Icons.edit_note_rounded, size: 16),
                                              label: const Text('Enter Marks'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF10B981),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                elevation: 0,
                                                textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
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
            loading: () => const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 14,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Examination Schedules & Marksheet Hub',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'View Published Unit Tests, Mid-Terms, Enter Subject Marks & Auto-Calculate Grades',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () => context.push('/exams/create'),
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text('Schedule New Exam'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiTile(double value, String title, IconData icon, Color color) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      borderRadius: 14,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  fractionDigits: 0,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.grade_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            const Text('No Exams Scheduled Yet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            const Text('Click "Schedule New Exam" or wait for the examination department to publish datesheets.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}
