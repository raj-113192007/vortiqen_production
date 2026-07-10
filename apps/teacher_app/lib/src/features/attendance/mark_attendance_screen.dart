import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_models/vortiqen_models.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:intl/intl.dart';

class MarkAttendanceScreen extends ConsumerStatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  ConsumerState<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends ConsumerState<MarkAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedClassId;
  String? _selectedSectionId;
  
  final Map<String, String> _studentStatuses = {}; // studentId -> status (PRESENT/ABSENT/LATE)
  bool _isSaving = false;

  void _loadExistingAttendance(List<Attendance> existing) {
    if (existing.isNotEmpty && _studentStatuses.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          for (var record in existing) {
            _studentStatuses[record.studentId] = record.status;
          }
        });
      });
    }
  }

  Future<void> _submitAttendance() async {
    if (_selectedClassId == null) return;
    final user = ref.read(authProvider).value?.user;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      final statuses = _studentStatuses.entries.map((e) => {
        'studentId': e.key,
        'status': e.value,
        'remarks': '',
      }).toList();

      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
      await ref.read(attendanceRepositoryProvider).markAttendance(
        dateStr,
        statuses,
        user.id,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance Marked Successfully! ✅'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final classesAsync = ref.watch(classesProvider);
    final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate);
    
    AsyncValue<List<Student>>? studentsAsync;
    AsyncValue<List<Attendance>>? existingAttendanceAsync;
    
    if (_selectedClassId != null) {
      studentsAsync = ref.watch(studentListProvider({'classId': _selectedClassId, 'sectionId': _selectedSectionId}));
      existingAttendanceAsync = ref.watch(classAttendanceProvider({
        'classId': _selectedClassId,
        'sectionId': _selectedSectionId ?? '',
        'date': dateStr,
      }));
    }

    // Load existing statuses if loaded
    existingAttendanceAsync?.whenData((existing) {
      _loadExistingAttendance(existing);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mark Attendance', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: classesAsync.when(
                        data: (classes) => DropdownButtonFormField<String>(
                          decoration: const InputDecoration(labelText: 'Select Class'),
                          initialValue: _selectedClassId,
                          items: classes.map<DropdownMenuItem<String>>((c) => DropdownMenuItem<String>(value: c.id, child: Text(c.name ?? ''))).toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedClassId = val;
                              _selectedSectionId = null;
                              _studentStatuses.clear();
                            });
                          },
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, st) => Text('Error loading classes: $e'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _selectedClassId == null
                        ? const SizedBox()
                        : DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Select Section (Optional)'),
                            initialValue: _selectedSectionId,
                            items: (classesAsync.value?.where((c) => (c as AcademicClass?)?.id == _selectedClassId).firstOrNull?.sections ?? [])
                                .map((s) => DropdownMenuItem<String>(value: s.id, child: Text(s.name)))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedSectionId = val;
                                _studentStatuses.clear();
                              });
                            },
                          ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                              _studentStatuses.clear();
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Date'),
                          child: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: studentsAsync == null
                ? const Center(child: Text('Please select a class to mark attendance.'))
                : studentsAsync.when(
                    data: (students) {
                      if (students.isEmpty) return const Center(child: Text('No students in this class.'));
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                final student = students[index];
                                final status = _studentStatuses[student.id] ?? 'PRESENT'; // Default
                                // Initialize if not set
                                if (!_studentStatuses.containsKey(student.id)) {
                                  _studentStatuses[student.id] = 'PRESENT';
                                }

                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    title: Text('${student.firstName} ${student.lastName}'),
                                    subtitle: Text('Roll No: ${student.rollNo}'),
                                    trailing: SegmentedButton<String>(
                                      segments: const [
                                        ButtonSegment(value: 'PRESENT', label: Text('Present')),
                                        ButtonSegment(value: 'ABSENT', label: Text('Absent')),
                                        ButtonSegment(value: 'LATE', label: Text('Late')),
                                      ],
                                      selected: {status},
                                      onSelectionChanged: (Set<String> newSelection) {
                                        setState(() {
                                          _studentStatuses[student.id] = newSelection.first;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                                          if (states.contains(WidgetState.selected)) {
                                            if (status == 'PRESENT') return Colors.green.withValues(alpha: 0.2);
                                            if (status == 'ABSENT') return Colors.red.withValues(alpha: 0.2);
                                            if (status == 'LATE') return Colors.orange.withValues(alpha: 0.2);
                                          }
                                          return null;
                                        }),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _isSaving
                                  ? const CircularProgressIndicator()
                                  : AnimatedButton(
                                      text: 'Submit Attendance',
                                      onPressed: _submitAttendance,
                                    ),
                            ],
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('Error: $e')),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

