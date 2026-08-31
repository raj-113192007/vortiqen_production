import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../onboarding/presentation/data_onboarding_hub_screen.dart';
import 'domain/staff_models.dart';
import 'presentation/widgets/staff_header.dart';
import 'presentation/widgets/teacher_card.dart';
import 'presentation/dialogs/teacher_360_modal.dart';
import 'presentation/dialogs/add_staff_modal.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _selectedDept = 'ALL';
  String _searchQuery = '';
  late List<TeacherProfile> _teachers;

  @override
  void initState() {
    super.initState();
    _teachers = StaffMockData.getTeachers();
  }

  void _openTeacherDossier(TeacherProfile teacher) {
    showDialog(
      context: context,
      builder: (_) => Teacher360Modal(teacher: teacher),
    );
  }

  void _openAddStaffModal() {
    showDialog(
      context: context,
      builder: (_) => AddStaffModal(
        onSave: (val) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Staff profile configured for ${val['name'] ?? 'Faculty'}.')),
          );
        },
      ),
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
    final filteredTeachers = _teachers.where((t) {
      final matchesDept = _selectedDept == 'ALL' || t.department == _selectedDept;
      final query = _searchQuery.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          t.name.toLowerCase().contains(query) ||
          t.empId.toLowerCase().contains(query) ||
          t.designation.toLowerCase().contains(query) ||
          t.classTeacherOf.toLowerCase().contains(query);
      return matchesDept && matchesQuery;
    }).toList();

    const deptTabs = [
      {'label': 'All Departments (48)', 'key': 'ALL'},
      {'label': 'Science & Math (18)', 'key': 'Science & Math'},
      {'label': 'Humanities & Languages (14)', 'key': 'Humanities & Languages'},
      {'label': 'IT & Computer Science (8)', 'key': 'IT & Computer Science'},
      {'label': 'Sports & Performing Arts (8)', 'key': 'Sports & Performing Arts'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Pulse KPIs
          StaffHeader(
            onAddStaff: _openAddStaffModal,
            onBulkUpload: _openBulkOnboarding,
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
                  // Top Search Input
                  Container(
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
                        hintText: 'Search faculty by Name, Employee ID, Designation, or Subject...',
                        hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Department Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: deptTabs.map((tab) {
                        final isSelected = _selectedDept == tab['key'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () => setState(() => _selectedDept = tab['key']!),
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

          // Teachers List View with Staggered Entrance Animations
          if (filteredTeachers.isEmpty)
            _buildEmptyState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTeachers.length,
              itemBuilder: (context, index) {
                final teacher = filteredTeachers[index];
                return FadeSlideEntry(
                  delay: Duration(milliseconds: 60 * index),
                  child: TeacherCard(
                    teacher: teacher,
                    onOpenDossier: () => _openTeacherDossier(teacher),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return FadeSlideEntry(
      child: Container(
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
              'No faculty members found matching your search criteria.',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}
