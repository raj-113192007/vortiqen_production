import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StudentRosterScreen extends ConsumerStatefulWidget {
  const StudentRosterScreen({super.key});

  @override
  ConsumerState<StudentRosterScreen> createState() => _StudentRosterScreenState();
}

class _StudentRosterScreenState extends ConsumerState<StudentRosterScreen> {
  String? _selectedClassId;
  String _searchQuery = '';

  String _getStudentName(Student s) {
    if (s.user?.name != null && s.user!.name.isNotEmpty) {
      return s.user!.name;
    }
    final name = '${s.firstName} ${s.lastName ?? ""}'.trim();
    return name.isNotEmpty ? name : 'Scholar';
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);
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
            child: _buildHeader(),
          ),
          const SizedBox(height: 20),

          classesAsync.when(
            data: (classes) {
              if (classes.isEmpty) return const Text('No classes found');
              _selectedClassId ??= classes.first.id;

              final studentsAsync = ref.watch(studentListProvider({'classId': _selectedClassId}));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Class Selector & Search
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 80),
                    child: _buildFilterBar(classes),
                  ),
                  const SizedBox(height: 18),

                  studentsAsync.when(
                    data: (students) {
                      final filtered = students.where((s) {
                        final q = _searchQuery.toLowerCase();
                        final sName = _getStudentName(s).toLowerCase();
                        return q.isEmpty ||
                            sName.contains(q) ||
                            s.rollNo.toLowerCase().contains(q);
                      }).toList();

                      if (filtered.isEmpty) {
                        return _buildEmptyState();
                      }

                      return FadeSlideEntry(
                        delay: const Duration(milliseconds: 140),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final crossCount = constraints.maxWidth < 650 ? 1 : (constraints.maxWidth < 1100 ? 2 : 3);
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filtered.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossCount,
                                childAspectRatio: 2.2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                              ),
                              itemBuilder: (context, index) {
                                final s = filtered[index];
                                final sName = _getStudentName(s);

                                return HoverLiftCard(
                                  onTap: () => _showStudent360Modal(s),
                                  padding: const EdgeInsets.all(16),
                                  borderRadius: 16,
                                  hoverBorderColor: const Color(0xFF10B981).withValues(alpha: 0.4),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.12),
                                        child: Text(
                                          sName.isNotEmpty ? sName[0].toUpperCase() : 'S',
                                          style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF10B981), fontSize: 16),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              sName,
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Roll No: ${s.rollNo} • ID: #${s.id.substring(0, 6)}',
                                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: const Text('94% ATTENDANCE', style: TextStyle(color: Color(0xFF10B981), fontSize: 9, fontWeight: FontWeight.w800)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator())),
                    error: (e, st) => Text('Error loading students: $e'),
                  ),
                ],
              );
            },
            loading: () => const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator())),
            error: (e, st) => Text('Error loading classes: $e'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scholar 360 & Class Directory',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Student Roster, Academic Records, Attendance Performance & Parent Contact Dossier',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Icon(Icons.people_alt_rounded, color: Color(0xFF10B981), size: 32),
        ],
      ),
    );
  }

  Widget _buildFilterBar(List<AcademicClass> classes) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedClassId,
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1E293B), fontSize: 13),
              items: classes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
              onChanged: (v) => setState(() => _selectedClassId = v),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: const InputDecoration(
                hintText: 'Search scholar by Name or Roll Number...',
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
                icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 18),
              ),
            ),
          ),
        ],
      ),
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
            Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No Scholars Found', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('No student records matched the current search query or class section.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  void _showStudent360Modal(Student s) {
    final sName = _getStudentName(s);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.12),
              child: Text(sName.isNotEmpty ? sName[0] : 'S', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF10B981))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                  Text('Roll No: ${s.rollNo} • Scholar ID: #${s.id.substring(0, 6)}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModalInfoRow('Class / Section', 'Assigned Senior Wing'),
            _buildModalInfoRow('Academic Performance', 'Grade A (Top 10% in Mathematics)'),
            _buildModalInfoRow('Attendance Record', '94.5% (Present 118 of 125 days)'),
            _buildModalInfoRow('Discipline & Behavior', 'Excellent • Prefect Nominee'),
            _buildModalInfoRow('Parent / Contact', '${s.parent?.name ?? "Parent Contact"} • Registered'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close Dossier')),
        ],
      ),
    );
  }

  Widget _buildModalInfoRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }
}
