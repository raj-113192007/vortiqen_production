import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AssignmentsScreen extends ConsumerStatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  ConsumerState<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends ConsumerState<AssignmentsScreen> {
  String _selectedFilter = 'ALL'; // 'ALL', 'ACTIVE', 'PAST'

  @override
  Widget build(BuildContext context) {
    final assignmentsAsync = ref.watch(teacherAssignmentsProvider);
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
          // 1. Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          assignmentsAsync.when(
            data: (assignments) {
              final activeCount = assignments.where((a) => a.dueDate.isAfter(DateTime.now())).length;
              final pastCount = assignments.length - activeCount;

              final filtered = assignments.where((a) {
                if (_selectedFilter == 'ACTIVE') return a.dueDate.isAfter(DateTime.now());
                if (_selectedFilter == 'PAST') return a.dueDate.isBefore(DateTime.now());
                return true;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Summary KPI Tiles
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 80),
                    child: _buildKpis(assignments.length, activeCount, pastCount),
                  ),
                  const SizedBox(height: 20),

                  // 3. Filter Chips
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 120),
                    child: _buildFilterChips(assignments.length, activeCount, pastCount),
                  ),
                  const SizedBox(height: 16),

                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 160),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final assignment = filtered[index];
                          final isOverdue = assignment.dueDate.isBefore(DateTime.now());

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: HoverLiftCard(
                              onTap: () => _showSubmissionsModal(context, assignment),
                              padding: const EdgeInsets.all(18),
                              borderRadius: 14,
                              hoverBorderColor: const Color(0xFF10B981).withValues(alpha: 0.4),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.assignment_rounded, color: Color(0xFF10B981), size: 22),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              assignment.title,
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF6C5CE7).withValues(alpha: 0.08),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                assignment.subjectName ?? 'General Subject',
                                                style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700, fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'Submission Deadline: ${DateFormat('dd MMM yyyy').format(assignment.dueDate)}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: isOverdue ? FontWeight.w700 : FontWeight.w500,
                                            color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                                          ),
                                        ),
                                        if (assignment.description != null && assignment.description!.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            assignment.description!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: isOverdue ? const Color(0xFF94A3B8).withValues(alpha: 0.12) : const Color(0xFF10B981).withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          isOverdue ? 'DEADLINE PASSED' : 'ACTIVE',
                                          style: TextStyle(
                                            color: isOverdue ? const Color(0xFF64748B) : const Color(0xFF10B981),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
                                    ],
                                  ),
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
            error: (e, st) => Center(child: Text('Error: $e')),
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
                'Homework & Assignment Management Hub',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Publish Daily Worksheets, Set Submission Deadlines & Evaluate Scholar Homework',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () => context.push('/assignments/create'),
            icon: const Icon(Icons.post_add_rounded, size: 16),
            label: const Text('Post New Homework'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
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

  Widget _buildKpis(int total, int active, int past) {
    return Row(
      children: [
        Expanded(child: _buildMetricTile(total.toDouble(), 'Total Assignments', Icons.assignment_outlined, const Color(0xFF6C5CE7), 'Coursework')),
        const SizedBox(width: 12),
        Expanded(child: _buildMetricTile(active.toDouble(), 'Active & Open', Icons.timer_outlined, const Color(0xFF10B981), 'Awaiting Submissions')),
        const SizedBox(width: 12),
        Expanded(child: _buildMetricTile(past.toDouble(), 'Past Deadlines', Icons.history_rounded, const Color(0xFFF59E0B), 'Ready for Evaluation')),
      ],
    );
  }

  Widget _buildMetricTile(double value, String label, IconData icon, Color color, String sub) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(int total, int active, int past) {
    return Row(
      children: [
        _buildChip('All ($total)', 'ALL'),
        const SizedBox(width: 8),
        _buildChip('Active ($active)', 'ACTIVE'),
        const SizedBox(width: 8),
        _buildChip('Past Due ($past)', 'PAST'),
      ],
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: const Color(0xFF10B981),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF475569),
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        fontSize: 11,
      ),
      side: BorderSide(color: isSelected ? const Color(0xFF10B981) : const Color(0xFFE2E8F0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (sel) {
        if (sel) setState(() => _selectedFilter = value);
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.assignment_outlined, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No Homework Assignments Found', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('Click "Post New Homework" above to assign worksheets to your students.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  void _showSubmissionsModal(BuildContext context, Assignment assignment) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.rate_review_rounded, color: Color(0xFF10B981)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Submissions: ${assignment.title}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Subject: ${assignment.subjectName ?? "General"} • Due: ${DateFormat('dd MMM yyyy').format(assignment.dueDate)}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              const SizedBox(height: 16),
              const Text('Submitted Worksheets (24 / 28 Scholars)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Aarav Patel (Roll 01) • PDF Attached', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                      child: const Text('GRADED: 10/10', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w800, fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }
}
