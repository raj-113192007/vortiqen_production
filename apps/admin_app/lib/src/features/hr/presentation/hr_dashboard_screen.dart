import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          // Tabs Switcher
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF6C5CE7),
                indicatorWeight: 3,
                labelColor: const Color(0xFF6C5CE7),
                unselectedLabelColor: const Color(0xFF64748B),
                labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: const [
                  Tab(icon: Icon(Icons.people_alt_rounded, size: 18), text: '1. Staff & Faculty Directory'),
                  Tab(icon: Icon(Icons.payments_rounded, size: 18), text: '2. Monthly Payroll & Payslips'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Tab Content
          FadeSlideEntry(
            delay: const Duration(milliseconds: 150),
            child: SizedBox(
              height: 650,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  EmployeesTab(),
                  PayrollTab(),
                ],
              ),
            ),
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
        runSpacing: 16,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Human Resources & Payroll Hub',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Faculty Profiles, Designation Slabs, Monthly Salary Disbursals & TDS Compliance',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFF10B981)),
                    SizedBox(width: 6),
                    Text('HR DESK ACTIVE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(context: context, builder: (_) => const AddEmployeeModal());
                },
                icon: const Icon(Icons.person_add_rounded, size: 16),
                label: const Text('Add Staff Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ],
          ),
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

    return employeesAsync.when(
      data: (employees) {
        if (employees.isEmpty) {
          return _buildEmptyState('No Employee Profiles Configured', 'Click "Add Staff Profile" above to configure designations and base salaries.');
        }

        final totalSalary = employees.fold<double>(0, (sum, e) => sum + e.baseSalary);

        return Column(
          children: [
            // Top Quick KPIs
            Row(
              children: [
                Expanded(
                  child: _buildKpiTile(employees.length.toDouble(), 'Active Staff', '', 'Full-time & Contract', Icons.people_outline_rounded, const Color(0xFF6C5CE7), 0),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKpiTile(totalSalary, 'Monthly Payroll Load', '₹ ', 'Disbursed 1st of Month', Icons.account_balance_wallet_outlined, const Color(0xFF10B981), 0),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final emp = employees[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HoverLiftCard(
                      padding: const EdgeInsets.all(16),
                      borderRadius: 14,
                      hoverBorderColor: const Color(0xFF6C5CE7).withValues(alpha: 0.35),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                            child: Text(
                              (emp.user?.name ?? 'E')[0].toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7), fontSize: 15),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emp.user?.name ?? 'Unknown Staff',
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${emp.designation} • Department: ${emp.department ?? "General"}',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AnimatedMetricCounter(
                                targetValue: emp.baseSalary,
                                prefix: '₹ ',
                                suffix: ' / mo',
                                fractionDigits: 0,
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF10B981)),
                              ),
                              const SizedBox(height: 2),
                              const Text('Base Salary', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildKpiTile(double value, String label, String prefix, String sub, IconData icon, Color color, int fractionDigits) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  prefix: prefix,
                  fractionDigits: fractionDigits,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.badge_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            Text(sub, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
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
        // Action and Month Filter Bar
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              DropdownButton<int>(
                value: _selectedMonth,
                underline: const SizedBox.shrink(),
                items: List.generate(
                  12,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text(DateFormat('MMMM').format(DateTime(2000, i + 1)), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
                onChanged: (v) => setState(() => _selectedMonth = v!),
              ),
              const SizedBox(width: 14),
              DropdownButton<int>(
                value: _selectedYear,
                underline: const SizedBox.shrink(),
                items: [2025, 2026, 2027].map((y) => DropdownMenuItem(value: y, child: Text(y.toString(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)))).toList(),
                onChanged: (v) => setState(() => _selectedYear = v!),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.calculate_rounded, size: 16),
                label: const Text('Generate Month Payroll'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () async {
                  await ref.read(hrRepositoryProvider).generatePayroll(_selectedMonth, _selectedYear);
                  ref.invalidate(payrollsProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Monthly Payroll calculated & payslips ready!')));
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: payrollsAsync.when(
            data: (payrolls) {
              if (payrolls.isEmpty) {
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
                        Icon(Icons.receipt_long_outlined, size: 48, color: Color(0xFF94A3B8)),
                        SizedBox(height: 12),
                        Text('No Payroll Run for this Period', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
                        SizedBox(height: 4),
                        Text('Click "Generate Month Payroll" to compute wages and payslips.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: payrolls.length,
                itemBuilder: (context, index) {
                  final p = payrolls[index];
                  final isPaid = p.status == 'PAID';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HoverLiftCard(
                      padding: const EdgeInsets.all(16),
                      borderRadius: 14,
                      hoverBorderColor: isPaid
                          ? const Color(0xFF10B981).withValues(alpha: 0.35)
                          : const Color(0xFFF59E0B).withValues(alpha: 0.35),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: isPaid
                                ? const Color(0xFF10B981).withValues(alpha: 0.12)
                                : const Color(0xFFF59E0B).withValues(alpha: 0.12),
                            child: Icon(
                              isPaid ? Icons.check_circle_rounded : Icons.pending_rounded,
                              color: isPaid ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.employee?.user?.name ?? 'Staff Employee',
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Salary Slip #${p.id.substring(0, 8)} • Month: ${DateFormat('MMMM yyyy').format(DateTime(_selectedYear, _selectedMonth))}',
                                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedMetricCounter(
                                targetValue: p.netPay,
                                prefix: '₹ ',
                                suffix: '',
                                fractionDigits: 0,
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(width: 14),
                              if (p.status == 'PENDING')
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF10B981),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    await ref.read(hrRepositoryProvider).markPayrollAsPaid(p.id);
                                    ref.invalidate(payrollsProvider);
                                  },
                                  child: const Text('Mark Paid', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('DISBURSED', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w800, fontSize: 11)),
                                ),
                            ],
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
          ),
        ),
      ],
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Staff employee added successfully!')));
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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 440,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Staff Employee Profile', style: TextStyle(color: Color(0xFF1E293B), fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Configure salary and designation for payroll tracking', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            const SizedBox(height: 20),
            staffAsync.when(
              data: (staffList) {
                return DropdownButtonFormField<String>(
                  initialValue: _selectedUserId,
                  decoration: InputDecoration(
                    labelText: 'Select Faculty / Staff Member',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  items: staffList.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.name} (${s.role})'))).toList(),
                  onChanged: (val) => setState(() => _selectedUserId = val),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => const Text('Error loading staff', style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _designationController,
              decoration: InputDecoration(
                labelText: 'Designation (e.g. Senior Math Teacher, HOD)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(
                labelText: 'Department (e.g. Science, Admin, Transport)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Base Salary (₹)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Save Profile'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
