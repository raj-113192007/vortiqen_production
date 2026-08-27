import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;
    if (user == null) return const Scaffold();

    final childrenAsync = ref.watch(parentStudentsProvider({
      'schoolId': user.schoolId ?? 'sch_01',
      'parentId': user.id,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Overview'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Attendance', icon: Icon(Icons.calendar_month_rounded)),
            Tab(text: 'Fee Dues', icon: Icon(Icons.receipt_long_rounded)),
          ],
        ),
      ),
      body: childrenAsync.when(
        data: (children) {
          final student = children.isNotEmpty ? children.first : null;
          if (student == null) {
            return const Center(child: Text('Student not found'));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildAttendanceTab(student),
              _buildFeesTab(student, user.schoolId ?? 'sch_01'),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildAttendanceTab(Student student) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.check_circle_rounded, color: Color(0xFF00B894)),
            ),
            title: const Text('Today: Present (98% Term Attendance)'),
            subtitle: Text('Roll No: ${student.rollNo} • Class 10-A'),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.check_circle_rounded, color: Color(0xFF00B894)),
            ),
            title: const Text('Yesterday: Present'),
            subtitle: const Text('Marked by Class Teacher Dr. Priya Verma'),
          ),
        ),
      ],
    );
  }

  Widget _buildFeesTab(Student student, String schoolId) {
    final feeLedgersAsync = ref.watch(feeLedgersProvider({'schoolId': schoolId}));

    return feeLedgersAsync.when(
      data: (ledgers) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ledgers.length,
          itemBuilder: (context, index) {
            final ledger = ledgers[index];
            final isPaid = ledger.status == 'PAID';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(ledger.category?.name ?? 'School Fee', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Due Date: ${ledger.dueDate.day}/${ledger.dueDate.month}/${ledger.dueDate.year}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${ledger.amountDue}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isPaid ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ledger.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isPaid ? const Color(0xFF00B894) : const Color(0xFFFF7675),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
