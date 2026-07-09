import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../transport/student_transport_screen.dart' as vortiqen_transport_tab;
import '../chat/chat_screen.dart' as vortiqen_chat_tab;

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(authProvider).valueOrNull?.user;
    
    if (user == null || user.schoolId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final studentAsync = ref.watch(studentProfileProvider({
      'schoolId': user.schoolId,
      'userId': user.id,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('VortiQen Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Attendance'),
            Tab(text: 'Fees'),
            Tab(text: 'Assignments'),
            Tab(text: 'Exams'),
            Tab(text: 'Transport'),
            Tab(text: 'Chat'),
          ],
        ),
      ),
      body: studentAsync.when(
        data: (student) {
          if (student == null) {
            return const Center(child: Text('Student profile not found.'));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildAttendanceTab(student, user.schoolId!),
              _buildFeesTab(student, user.schoolId!),
              _buildAssignmentsTab(student, user.schoolId!),
              _buildExamsTab(student, user.schoolId!),
              const vortiqen_transport_tab.StudentTransportScreen(),
              const vortiqen_chat_tab.ChatScreen(),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildAttendanceTab(Student student, String schoolId) {
    final attendanceAsync = ref.watch(studentAttendanceProvider(student.id));

    return attendanceAsync.when(
      data: (attendanceRecords) {
        if (attendanceRecords.isEmpty) return const Center(child: Text('No attendance records found.'));
        
        // Sort descending by date
        final sorted = List<Attendance>.from(attendanceRecords)
          ..sort((a, b) => b.date.compareTo(a.date));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            final record = sorted[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: record.status == 'PRESENT' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                  child: Icon(
                    record.status == 'PRESENT' ? Icons.check : Icons.close,
                    color: record.status == 'PRESENT' ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(DateFormat('EEEE, dd MMM yyyy').format(record.date)),
                subtitle: record.remarks != null ? Text(record.remarks!) : null,
                trailing: Text(record.status, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildFeesTab(Student student, String schoolId) {
    final feeLedgersAsync = ref.watch(feeLedgersProvider(schoolId));
    
    return feeLedgersAsync.when(
      data: (ledgers) {
        final studentLedgers = ledgers.where((l) => l.studentId == student.id).toList();
        if (studentLedgers.isEmpty) return const Center(child: Text('No fee records found.'));
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: studentLedgers.length,
          itemBuilder: (context, index) {
            final ledger = studentLedgers[index];
            final theme = Theme.of(context);
            
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(ledger.category?.name ?? 'Fee', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Due: ${DateFormat('dd MMM yyyy').format(ledger.dueDate)}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${ledger.amountDue - ledger.amountPaid}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: ledger.status == 'PAID' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(ledger.status, style: TextStyle(
                        fontSize: 10,
                        color: ledger.status == 'PAID' ? Colors.green : Colors.red,
                      )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildAssignmentsTab(Student student, String schoolId) {
    if (student.sectionId == null) {
      return const Center(child: Text('No section assigned to student.'));
    }

    final assignmentsAsync = ref.watch(sectionAssignmentsProvider(student.sectionId!));
    
    return assignmentsAsync.when(
      data: (assignments) {
        if (assignments.isEmpty) return const Center(child: Text('No assignments found.'));
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child: Icon(Icons.assignment, color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(assignment.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Subject: ${assignment.subjectName ?? '-'}'),
                    Text('Due: ${DateFormat('dd MMM, yyyy').format(assignment.dueDate)}', 
                      style: TextStyle(color: assignment.dueDate.isBefore(DateTime.now()) ? Colors.red : null),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.upload_file),
                isThreeLine: true,
                onTap: () {
                  context.push('/assignments/${assignment.id}/submit');
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildExamsTab(Student student, String schoolId) {
    final reportCardAsync = ref.watch(studentReportCardProvider(student.id));

    return reportCardAsync.when(
      data: (exams) {
        if (exams.isEmpty) return const Center(child: Text('No exam results found.'));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exams.length,
          itemBuilder: (context, index) {
            final exam = exams[index];
            final subjects = (exam['subjects'] as List<dynamic>).cast<Map<String, dynamic>>();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                initiallyExpanded: index == 0,
                title: Text(exam['name'] ?? 'Exam', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Status: ${exam['status']}'),
                children: subjects.map((sub) {
                  return ListTile(
                    title: Text(sub['subjectName'] ?? 'Subject'),
                    subtitle: Text('Max: ${sub['maxMarks']}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (sub['marksObtained'] != null)
                          Text('${sub['marksObtained']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        if (sub['grade'] != null && (sub['grade'] as String).isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(sub['grade'], style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
