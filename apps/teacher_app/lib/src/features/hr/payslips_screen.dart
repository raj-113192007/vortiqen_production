import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class PayslipsScreen extends ConsumerWidget {
  const PayslipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPayrollsAsync = ref.watch(myPayrollsProvider);
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
            child: _buildHeader(),
          ),
          const SizedBox(height: 20),

          myPayrollsAsync.when(
            data: (payrolls) {
              if (payrolls.isEmpty) {
                return _buildEmptyState();
              }

              final totalDisbursed = payrolls
                  .where((p) => p.status == 'PAID')
                  .fold<double>(0, (sum, p) => sum + p.netPay);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KPI Summary Tiles
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 80),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildKpiTile(totalDisbursed, 'Total Disbursed MTD', '₹ ', '', Icons.account_balance_wallet_outlined, const Color(0xFF10B981)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildKpiTile(payrolls.length.toDouble(), 'Generated Slips', '', ' Receipts Available', Icons.receipt_long_rounded, const Color(0xFF6C5CE7)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Payslip Cards List
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 140),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: payrolls.length,
                      itemBuilder: (context, index) {
                        final p = payrolls[index];
                        final monthName = DateFormat('MMMM').format(DateTime(2000, p.month));
                        final isPaid = p.status == 'PAID';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: HoverLiftCard(
                            padding: const EdgeInsets.all(20),
                            borderRadius: 16,
                            hoverBorderColor: isPaid ? const Color(0xFF10B981).withValues(alpha: 0.4) : const Color(0xFFF59E0B).withValues(alpha: 0.4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(Icons.receipt_rounded, color: Color(0xFF10B981), size: 22),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$monthName ${p.year} Salary Slip',
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Slip ID: #${p.id.substring(0, 8).toUpperCase()}',
                                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isPaid ? const Color(0xFF10B981).withValues(alpha: 0.12) : const Color(0xFFF59E0B).withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        p.status,
                                        style: TextStyle(
                                          color: isPaid ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Divider(color: Color(0xFFF1F5F9), height: 1),
                                const SizedBox(height: 14),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildLineItem('Base Salary', '₹ ${p.baseSalary.toStringAsFixed(0)}'),
                                    _buildLineItem('Allowances', '+ ₹ ${p.allowances.toStringAsFixed(0)}'),
                                    _buildLineItem('TDS / Deductions', '- ₹ ${p.deductions.toStringAsFixed(0)}'),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text('Net Disbursed', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
                                        const SizedBox(height: 2),
                                        Text(
                                          '₹ ${p.netPay.toStringAsFixed(0)}',
                                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF10B981)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                if (p.paymentDate != null) ...[
                                  const SizedBox(height: 14),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Credited on ${DateFormat('dd MMM yyyy').format(p.paymentDate!)} via Bank NEFT',
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Downloading official signed PDF Payslip... 📄')),
                                          );
                                        },
                                        icon: const Icon(Icons.download_rounded, size: 14),
                                        label: const Text('Download Slip'),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
            loading: () => const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator())),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Monthly Salary Slips & Form 16',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Official Salary Statements, Allowances, PF, TDS Deductions & Disbursal Records',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Icon(Icons.payments_rounded, color: Color(0xFF10B981), size: 32),
        ],
      ),
    );
  }

  Widget _buildKpiTile(double value, String title, String prefix, String suffix, IconData icon, Color color) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                  suffix: suffix,
                  fractionDigits: 0,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
      ],
    );
  }

  Widget _buildEmptyState() {
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
            Text('No Payslips Generated Yet', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('Your monthly salary slips will appear here once disbursed by the school accounts department.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}
