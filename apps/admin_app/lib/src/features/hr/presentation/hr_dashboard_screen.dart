import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class HrDashboardScreen extends ConsumerStatefulWidget {
  const HrDashboardScreen({super.key});

  @override
  ConsumerState<HrDashboardScreen> createState() => _HrDashboardScreenState();
}

class _HrDashboardScreenState extends ConsumerState<HrDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Human Resources'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Employees'),
            Tab(text: 'Payroll'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          EmployeesTab(),
          PayrollTab(),
        ],
      ),
    );
  }
}

class EmployeesTab extends ConsumerWidget {
  const EmployeesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesProvider);

    return Scaffold(
      body: employeesAsync.when(
        data: (employees) {
          if (employees.isEmpty) {
            return const Center(child: Text('No employees found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final emp = employees[index];
              return Card(
                color: Colors.white.withValues(alpha: 0.05),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(emp.user?.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text('${emp.designation} - ${emp.department ?? 'No Dept'}', style: const TextStyle(color: Colors.white54)),
                  trailing: Text('₹${emp.baseSalary.toStringAsFixed(0)} / mo', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (_) => const AddEmployeeModal());
        },
      ),
    );
  }
}

class AddEmployeeModal extends ConsumerStatefulWidget {
  const AddEmployeeModal({super.key});

  @override
  ConsumerState<AddEmployeeModal> createState() => _AddEmployeeModalState();
}

class _AddEmployeeModalState extends ConsumerState<AddEmployeeModal> {
  final _designationController = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  String? _selectedUserId;
  bool _isLoading = false;

  void _submit() async {
    if (_selectedUserId == null || _designationController.text.isEmpty) return;
    setState(() => _isLoading = true);

    try {
      await ref.read(hrRepositoryProvider).createEmployee(
        userId: _selectedUserId!,
        designation: _designationController.text,
        department: _departmentController.text,
        baseSalary: double.tryParse(_salaryController.text) ?? 0,
        joinDate: DateTime.now(),
      );
      if (mounted) {
        Navigator.pop(context);
        ref.invalidate(employeesProvider);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employee added')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;
    final staffAsync = ref.watch(staffProvider(user?.schoolId ?? ''));

    return Dialog(
      backgroundColor: const Color(0xFF1E1E2C),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Employee Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            staffAsync.when(
              data: (staffList) {
                return DropdownButtonFormField<String>(
                  initialValue: _selectedUserId,
                  dropdownColor: const Color(0xFF2A2A3C),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    hintText: 'Select Staff/Teacher',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  items: staffList.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.name} (${s.role})'))).toList(),
                  onChanged: (val) => setState(() => _selectedUserId = val),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => const Text('Error loading staff', style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _designationController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Designation (e.g. Senior Math Teacher)',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _departmentController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Department (e.g. Science)',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                hintText: 'Base Salary',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading ? const CircularProgressIndicator() : const Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PayrollTab extends ConsumerStatefulWidget {
  const PayrollTab({super.key});

  @override
  ConsumerState<PayrollTab> createState() => _PayrollTabState();
}

class _PayrollTabState extends ConsumerState<PayrollTab> {
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final payrollsAsync = ref.watch(payrollsProvider({'month': _selectedMonth, 'year': _selectedYear}));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DropdownButton<int>(
                dropdownColor: const Color(0xFF2A2A3C),
                style: const TextStyle(color: Colors.white),
                value: _selectedMonth,
                items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(DateFormat('MMM').format(DateTime(2000, i + 1))))),
                onChanged: (v) => setState(() => _selectedMonth = v!),
              ),
              const SizedBox(width: 16),
              DropdownButton<int>(
                dropdownColor: const Color(0xFF2A2A3C),
                style: const TextStyle(color: Colors.white),
                value: _selectedYear,
                items: [2025, 2026, 2027].map((y) => DropdownMenuItem(value: y, child: Text(y.toString()))).toList(),
                onChanged: (v) => setState(() => _selectedYear = v!),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Generate Payroll'),
                onPressed: () async {
                  await ref.read(hrRepositoryProvider).generatePayroll(_selectedMonth, _selectedYear);
                  ref.invalidate(payrollsProvider);
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payroll generated for month')));
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: payrollsAsync.when(
            data: (payrolls) {
              if (payrolls.isEmpty) {
                return const Center(child: Text('No payrolls generated for this month.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: payrolls.length,
                itemBuilder: (context, index) {
                  final p = payrolls[index];
                  return Card(
                    color: Colors.white.withValues(alpha: 0.05),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(p.employee?.user?.name ?? 'Employee', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text('Status: ${p.status}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('₹${p.netPay.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                          if (p.status == 'PENDING') ...[
                            const SizedBox(width: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () async {
                                await ref.read(hrRepositoryProvider).markPayrollAsPaid(p.id);
                                ref.invalidate(payrollsProvider);
                              },
                              child: const Text('Mark Paid'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }
}

