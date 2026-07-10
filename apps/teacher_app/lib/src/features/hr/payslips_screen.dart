import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class PayslipsScreen extends ConsumerWidget {
  const PayslipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPayrollsAsync = ref.watch(myPayrollsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Payslips'),
      ),
      body: myPayrollsAsync.when(
        data: (payrolls) {
          if (payrolls.isEmpty) {
            return const Center(child: Text('No payslips generated for you yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payrolls.length,
            itemBuilder: (context, index) {
              final p = payrolls[index];
              final monthName = DateFormat('MMMM').format(DateTime(2000, p.month));
              
              return Card(
                color: Colors.white.withValues(alpha: 0.05),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$monthName ${p.year}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: p.status == 'PAID' ? Colors.green.withValues(alpha: 0.2) : Colors.orange.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              p.status,
                              style: TextStyle(color: p.status == 'PAID' ? Colors.green : Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white24, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Base Salary:', style: TextStyle(color: Colors.white70)),
                          Text('₹${p.baseSalary.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Allowances:', style: TextStyle(color: Colors.white70)),
                          Text('+ ₹${p.allowances.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Deductions:', style: TextStyle(color: Colors.white70)),
                          Text('- ₹${p.deductions.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const Divider(color: Colors.white24, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Net Pay:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                          Text('₹${p.netPay.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.greenAccent)),
                        ],
                      ),
                      if (p.paymentDate != null) ...[
                        const SizedBox(height: 8),
                        Text('Paid on: ${DateFormat('dd MMM yyyy').format(p.paymentDate!)}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                      ]
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
    );
  }
}

