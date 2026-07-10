import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedClassId;
  String? _selectedSectionId;

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Monitoring',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Filters
          Card(
            child: Row(
              children: [
                Expanded(
                  child: classesAsync.when(
                    data: (classes) => DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Select Class'),
                      value: _selectedClassId,
                      items: classes.map<DropdownMenuItem<String>>((dynamic c) {
                        return DropdownMenuItem<String>(value: c.id, child: Text(c.name));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedClassId = val;
                          _selectedSectionId = null; // reset section
                        });
                      },
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Error loading classes: $e'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(DateFormat.yMMMd().format(_selectedDate)),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Data
          if (_selectedClassId != null)
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final attendanceAsync = ref.watch(classAttendanceProvider({
                    'classId': _selectedClassId!,
                    'sectionId': _selectedSectionId ?? '',
                    'date': _selectedDate.toIso8601String(),
                  }));

                  return attendanceAsync.when(
                    data: (attendanceList) {
                      if (attendanceList.isEmpty) {
                        return const Center(child: Text('No attendance recorded for this date.'));
                      }
                      
                      // Calculate stats
                      final present = attendanceList.where((a) => a.status == 'PRESENT').length;
                      final total = attendanceList.length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overview: $present/$total Present', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: attendanceList.length,
                              itemBuilder: (context, index) {
                                final record = attendanceList[index];
                                final student = record.student;
                                
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: record.status == 'PRESENT' ? Colors.green : Colors.red,
                                      child: const Icon(Icons.person, color: Colors.white),
                                    ),
                                    title: Text('${student?.firstName} ${student?.lastName ?? ''}'),
                                    subtitle: Text('Roll No: ${student?.rollNo ?? 'N/A'}'),
                                    trailing: Chip(
                                      label: Text(record.status),
                                      backgroundColor: record.status == 'PRESENT' ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
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
                    error: (err, stack) => Center(child: Text('Error: $err')),
                  );
                },
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('Select a class to view attendance'),
              ),
            ),
        ],
      ),
    );
  }
}

