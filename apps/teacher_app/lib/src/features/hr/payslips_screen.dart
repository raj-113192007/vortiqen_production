import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class MonthlySalarySlip {
  final String id;
  final String month;
  final int year;
  final double basicPay;
  final double hra;
  final double da;
  final double specialAllowance;
  final double epfDeduction;
  final double professionalTax;
  final double tds;
  final double netSalary;
  final String status; // 'CREDITED', 'PROCESSING', 'PENDING'
  final String paymentDate;
  final String transactionRef;
  final int workingDays;
  final int presentDays;
  final int leavesTaken;

  double get grossSalary => basicPay + hra + da + specialAllowance;
  double get totalDeductions => epfDeduction + professionalTax + tds;

  const MonthlySalarySlip({
    required this.id,
    required this.month,
    required this.year,
    required this.basicPay,
    required this.hra,
    required this.da,
    required this.specialAllowance,
    required this.epfDeduction,
    required this.professionalTax,
    required this.tds,
    required this.netSalary,
    required this.status,
    required this.paymentDate,
    required this.transactionRef,
    required this.workingDays,
    required this.presentDays,
    required this.leavesTaken,
  });
}

class PayslipsScreen extends StatefulWidget {
  const PayslipsScreen({super.key});

  @override
  State<PayslipsScreen> createState() => _PayslipsScreenState();
}

class _PayslipsScreenState extends State<PayslipsScreen> {
  final List<MonthlySalarySlip> _slips = const [
    MonthlySalarySlip(
      id: 'slip_aug_2026',
      month: 'August',
      year: 2026,
      basicPay: 38000,
      hra: 12500,
      da: 7600,
      specialAllowance: 5000,
      epfDeduction: 4560,
      professionalTax: 200,
      tds: 1500,
      netSalary: 56840,
      status: 'CREDITED',
      paymentDate: '31 Aug 2026',
      transactionRef: 'NEFT-HDFC-98210948',
      workingDays: 24,
      presentDays: 23,
      leavesTaken: 1,
    ),
    MonthlySalarySlip(
      id: 'slip_jul_2026',
      month: 'July',
      year: 2026,
      basicPay: 38000,
      hra: 12500,
      da: 7600,
      specialAllowance: 5000,
      epfDeduction: 4560,
      professionalTax: 200,
      tds: 1500,
      netSalary: 56840,
      status: 'CREDITED',
      paymentDate: '31 Jul 2026',
      transactionRef: 'NEFT-HDFC-87192841',
      workingDays: 26,
      presentDays: 26,
      leavesTaken: 0,
    ),
    MonthlySalarySlip(
      id: 'slip_jun_2026',
      month: 'June',
      year: 2026,
      basicPay: 38000,
      hra: 12500,
      da: 7600,
      specialAllowance: 5000,
      epfDeduction: 4560,
      professionalTax: 200,
      tds: 1500,
      netSalary: 56840,
      status: 'CREDITED',
      paymentDate: '30 Jun 2026',
      transactionRef: 'NEFT-HDFC-76192830',
      workingDays: 24,
      presentDays: 24,
      leavesTaken: 0,
    ),
    MonthlySalarySlip(
      id: 'slip_may_2026',
      month: 'May',
      year: 2026,
      basicPay: 38000,
      hra: 12500,
      da: 7600,
      specialAllowance: 5000,
      epfDeduction: 4560,
      professionalTax: 200,
      tds: 1500,
      netSalary: 56840,
      status: 'CREDITED',
      paymentDate: '31 May 2026',
      transactionRef: 'NEFT-HDFC-65192822',
      workingDays: 22,
      presentDays: 21,
      leavesTaken: 1,
    ),
    MonthlySalarySlip(
      id: 'slip_apr_2026',
      month: 'April',
      year: 2026,
      basicPay: 38000,
      hra: 12500,
      da: 7600,
      specialAllowance: 5000,
      epfDeduction: 4560,
      professionalTax: 200,
      tds: 1500,
      netSalary: 56840,
      status: 'CREDITED',
      paymentDate: '30 Apr 2026',
      transactionRef: 'NEFT-HDFC-54192811',
      workingDays: 24,
      presentDays: 24,
      leavesTaken: 0,
    ),
  ];

  void _showDetailedPayslipModal(MonthlySalarySlip slip) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 640,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.school_rounded, color: Color(0xFF10B981), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('VORTIQEN PUBLIC SENIOR SECONDARY SCHOOL', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                            Text('Salary Slip for ${slip.month} ${slip.year}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close_rounded)),
                  ],
                ),
                const Divider(height: 24),

                // Employee Details Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Employee Name: Prof. Rajesh Sharma', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                            Text('Employee ID: EMP-2024-089 • PGT Physics', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                            Text('PAN: ABCDE1234F • UAN: 101489201948', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bank: HDFC Bank (A/C: XXXXXX4821)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                            Text('Working Days: ${slip.workingDays} • Present: ${slip.presentDays}', style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                            Text('Status: ${slip.status} on ${slip.paymentDate}', style: const TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Earnings & Deductions Dual Column
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Earnings
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('EARNINGS & ALLOWANCES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF10B981))),
                            const Divider(height: 12),
                            _buildBreakdownRow('Basic Pay', '₹ ${slip.basicPay.toInt()}'),
                            _buildBreakdownRow('House Rent (HRA)', '₹ ${slip.hra.toInt()}'),
                            _buildBreakdownRow('Dearness Allowance (DA)', '₹ ${slip.da.toInt()}'),
                            _buildBreakdownRow('Special / HOD Allowance', '₹ ${slip.specialAllowance.toInt()}'),
                            const Divider(height: 12),
                            _buildBreakdownRow('Gross Earnings', '₹ ${slip.grossSalary.toInt()}', isBold: true, color: const Color(0xFF10B981)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Deductions
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DEDUCTIONS & TAX', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFFEF4444))),
                            const Divider(height: 12),
                            _buildBreakdownRow('Provident Fund (EPF 12%)', '₹ ${slip.epfDeduction.toInt()}'),
                            _buildBreakdownRow('Professional Tax (PT)', '₹ ${slip.professionalTax.toInt()}'),
                            _buildBreakdownRow('Income Tax (TDS)', '₹ ${slip.tds.toInt()}'),
                            _buildBreakdownRow('Other Deductions', '₹ 0'),
                            const Divider(height: 12),
                            _buildBreakdownRow('Total Deductions', '₹ ${slip.totalDeductions.toInt()}', isBold: true, color: const Color(0xFFEF4444)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Net Salary Callout
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('NET SALARY TAKE-HOME', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                          Text('Direct credited to HDFC Bank (${slip.transactionRef})', style: const TextStyle(fontSize: 10, color: Colors.white70)),
                        ],
                      ),
                      Text(
                        '₹ ${slip.netSalary.toInt()}',
                        style: const TextStyle(color: Color(0xFF10B981), fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Downloading official PDF Payslip for ${slip.month} ${slip.year}... 📄'),
                            backgroundColor: const Color(0xFF10B981),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 16),
                      label: const Text('Download PDF Slip'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String title, String amount, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 11, fontWeight: isBold ? FontWeight.w800 : FontWeight.w500, color: const Color(0xFF475569))),
          Text(amount, style: TextStyle(fontSize: 11, fontWeight: isBold ? FontWeight.w900 : FontWeight.w700, color: color ?? const Color(0xFF1E293B))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double grossMonthly = 63100;
    const double totalDisbursedYtd = 284200;
    const double totalPfAccumulated = 184500;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Salary, Compensation & Payslips',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading Annual Form 16 Tax Certificate (PDF)... 📑'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            icon: const Icon(Icons.receipt_long_rounded, size: 16),
            label: const Text('Download Form 16'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              side: const BorderSide(color: Color(0xFF10B981)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP SALARY SUMMARY HERO CARD
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const PulsingLiveDot(size: 4, pulseScale: 2.2, color: Color(0xFF10B981)),
                              const SizedBox(width: 8),
                              const Text(
                                'CURRENT SALARY SLATE • AUGUST 2026 (ACTIVE)',
                                style: TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: const [
                              Text('₹ 56,840', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                              SizedBox(width: 6),
                              Text('/ Month Take-Home', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Gross: ₹ 63,100 • Total Deductions: ₹ 6,260 (EPF, PT, TDS) • Bank: HDFC (****4821)',
                            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: const [
                          Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 22),
                          SizedBox(height: 4),
                          Text('August Credited', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w900)),
                          Text('On 31 Aug 2026', style: TextStyle(color: Colors.white70, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 2. FINANCIAL KPIS GRID (YTD, Gross, PF Balance, Tax)
            FadeSlideEntry(
              delay: const Duration(milliseconds: 80),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossCount = constraints.maxWidth < 650 ? 2 : 4;
                  return GridView.count(
                    crossAxisCount: crossCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: crossCount == 4 ? 2.3 : 2.0,
                    children: [
                      _buildKpiCard('Gross Monthly Pay', '₹ ${grossMonthly.toInt()}', 'Base + HRA + DA + HOD', Icons.monetization_on_outlined, const Color(0xFF0984E3)),
                      _buildKpiCard('Total Disbursed YTD', '₹ ${totalDisbursedYtd.toInt()}', '5 Months Credited', Icons.account_balance_wallet_outlined, const Color(0xFF10B981)),
                      _buildKpiCard('Accumulated EPF', '₹ ${totalPfAccumulated.toInt()}', 'Employee + Employer PF', Icons.savings_outlined, const Color(0xFF6C5CE7)),
                      _buildKpiCard('Income Tax Paid (YTD)', '₹ 7,500', 'New Regime Form 16', Icons.receipt_long_outlined, const Color(0xFFF59E0B)),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 3. MONTHLY PAYSLIPS TABLE & CARDS
            FadeSlideEntry(
              delay: const Duration(milliseconds: 140),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Monthly Payslip Ledger & Receipts',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                        ),
                        Text(
                          '${_slips.length} Payslips Available',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _slips.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final slip = _slips[index];
                        return _buildPayslipCard(slip);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color)),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayslipCard(MonthlySalarySlip slip) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.receipt_long_rounded, color: Color(0xFF10B981), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${slip.month} ${slip.year} Payslip',
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 10),
                          const SizedBox(width: 3),
                          Text(slip.status, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF10B981))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Gross: ₹ ${slip.grossSalary.toInt()} • Deductions: ₹ ${slip.totalDeductions.toInt()} • Credited on ${slip.paymentDate}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹ ${slip.netSalary.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF10B981)),
              ),
              const SizedBox(height: 4),
              ElevatedButton.icon(
                onPressed: () => _showDetailedPayslipModal(slip),
                icon: const Icon(Icons.visibility_rounded, size: 13),
                label: const Text('View Slip'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
