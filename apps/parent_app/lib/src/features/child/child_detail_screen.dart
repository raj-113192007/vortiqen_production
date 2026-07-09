import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class ChildDetailScreen extends ConsumerStatefulWidget {
  final String studentId;

  const ChildDetailScreen({super.key, required this.studentId});

  @override
  ConsumerState<ChildDetailScreen> createState() => _ChildDetailScreenState();
}

class _ChildDetailScreenState extends ConsumerState<ChildDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(authProvider).valueOrNull?.user;
    
    if (user == null) return const Scaffold();

    final studentAsync = ref.watch(studentProfileProvider({
      'schoolId': user.schoolId,
      'userId': widget.studentId, // We use studentId (which is actually student.id) to fetch... wait. 
      // The parameter is userId, not studentId. We might need a generic getStudentById if we pass studentId.
      // But parentStudentsProvider gives us the `Student` models which have `student.id`.
    }));

    // Actually, I should use studentProvider or just use the ID we have. 
    // Wait, the API `GET /api/v1/students/:id` gets the student by ID.
    // Let's create a direct fetch or just fetch all children and find this one.
    final childrenAsync = ref.watch(parentStudentsProvider({
      'schoolId': user.schoolId,
      'parentId': user.id,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Attendance'),
            Tab(text: 'Fees'),
          ],
        ),
      ),
      body: childrenAsync.when(
        data: (children) {
          final student = children.firstWhere((s) => s.id == widget.studentId);
          
          return TabBarView(
            controller: _tabController,
            children: [
              _buildAttendanceTab(student, user.schoolId!),
              _buildFeesTab(student, user.schoolId!),
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
}
