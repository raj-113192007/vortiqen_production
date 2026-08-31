import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../onboarding/presentation/data_onboarding_hub_screen.dart';
import 'domain/student_models.dart';
import 'presentation/widgets/students_header.dart';
import 'presentation/widgets/student_table_row.dart';
import 'presentation/widgets/student_card.dart';
import 'presentation/dialogs/student_360_modal.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  String _selectedClass = 'ALL';
  String _searchQuery = '';
  bool _isGridView = false;
  late List<StudentFullProfile> _students;

  @override
  void initState() {
    super.initState();
    _students = StudentsMockData.getStudents();
  }

  void _openStudentDossier(StudentFullProfile student) {
    showDialog(
      context: context,
      builder: (_) => Student360Modal(student: student),
    );
  }

  void _openBulkOnboarding() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DataOnboardingHubScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = _students.where((s) {
      final matchesClass = _selectedClass == 'ALL' || '${s.className}-${s.section}' == _selectedClass;
      final query = _searchQuery.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          s.name.toLowerCase().contains(query) ||
          s.grNo.toLowerCase().contains(query) ||
          s.rollNo.toLowerCase().contains(query) ||
          s.fatherName.toLowerCase().contains(query) ||
          s.parentPhone.toLowerCase().contains(query);
      return matchesClass && matchesQuery;
    }).toList();

    const classTabs = [
      {'label': 'All Grades (1,420)', 'key': 'ALL'},
      {'label': 'Class 10-A (42)', 'key': 'Class 10-A'},
      {'label': 'Class 10-B (40)', 'key': 'Class 10-B'},
      {'label': 'Class 9-A (45)', 'key': 'Class 9-A'},
      {'label': 'Class 11-Science (38)', 'key': 'Class 11-Science'},
      {'label': 'Class 12-Commerce (36)', 'key': 'Class 12-Commerce'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Animated KPIs
          StudentsHeader(
            onEnrollStudent: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Scholar Enrollment Form...')),
              );
            },
            onBulkImport: _openBulkOnboarding,
          ),
          const SizedBox(height: 18),

          // Search and Filter Bar with Entrance Animation
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Search Row + View Switcher
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            onChanged: (val) => setState(() => _searchQuery = val),
                            style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B)),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 18),
                              hintText: 'Search student by Name, Roll No, GR-Number, Father\'s Name, or Phone...',
                              hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.table_rows_rounded, color: !_isGridView ? const Color(0xFF4F46E5) : const Color(0xFF94A3B8), size: 18),
                              onPressed: () => setState(() => _isGridView = false),
                              tooltip: 'Table View',
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              icon: Icon(Icons.grid_view_rounded, color: _isGridView ? const Color(0xFF4F46E5) : const Color(0xFF94A3B8), size: 18),
                              onPressed: () => setState(() => _isGridView = true),
                              tooltip: 'Grid Cards View',
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Class Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: classTabs.map((tab) {
                        final isSelected = _selectedClass == tab['key'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () => setState(() => _selectedClass = tab['key']!),
                            borderRadius: BorderRadius.circular(6),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF4F46E5).withValues(alpha: 0.25),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Text(
                                tab['label']!,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : const Color(0xFF475569),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main View: Smooth AnimatedSwitcher between Table and Grid
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: filteredStudents.isEmpty
                ? _buildEmptyState()
                : (!_isGridView
                    ? _buildTableView(filteredStudents)
                    : _buildGridView(filteredStudents)),
          ),
        ],
      ),
    );
  }

  Widget _buildTableView(List<StudentFullProfile> students) {
    return FadeSlideEntry(
      key: const ValueKey('table_view'),
      delay: const Duration(milliseconds: 150),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Table Column Headers
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 4, child: Text('STUDENT & GR-NO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                  Expanded(flex: 3, child: Text('CLASS & ROLL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                  Expanded(flex: 4, child: Text('PARENT & CONTACT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                  Expanded(flex: 3, child: Text('ATTENDANCE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                  Expanded(flex: 3, child: Text('FEE STATUS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                  Expanded(flex: 2, child: Text('DOSSIER', textAlign: TextAlign.end, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                ],
              ),
            ),

            // List of Rows with subtle staggered appearance
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: students.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final student = students[index];
                return FadeSlideEntry(
                  delay: Duration(milliseconds: 50 * index),
                  child: StudentTableRow(
                    student: student,
                    onOpenDossier: () => _openStudentDossier(student),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(List<StudentFullProfile> students) {
    return FadeSlideEntry(
      key: const ValueKey('grid_view'),
      delay: const Duration(milliseconds: 150),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final student = students[index];
              return FadeSlideEntry(
                delay: Duration(milliseconds: 60 * index),
                child: StudentCard(
                  student: student,
                  onOpenDossier: () => _openStudentDossier(student),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Column(
        children: [
          Icon(Icons.person_search_outlined, size: 36, color: Color(0xFF94A3B8)),
          SizedBox(height: 10),
          Text(
            'No scholars found matching the selected filters.',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
