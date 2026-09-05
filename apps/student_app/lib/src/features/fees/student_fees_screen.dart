import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StudentFeesScreen extends ConsumerStatefulWidget {
  const StudentFeesScreen({super.key});

  @override
  ConsumerState<StudentFeesScreen> createState() => _StudentFeesScreenState();
}

class _StudentFeesScreenState extends ConsumerState<StudentFeesScreen> {
  final List<Map<String, dynamic>> _feeBreakdown = [
    {'category': 'Tuition Fee (Q2 - Jul-Sep)', 'amount': 18000, 'status': 'PAID', 'dueDate': '10 Jul 2026', 'receipt': 'REC-2026-0941'},
    {'category': 'Science & Computer Lab Fee', 'amount': 4500, 'status': 'PAID', 'dueDate': '10 Jul 2026', 'receipt': 'REC-2026-0942'},
    {'category': 'Transport / Bus Fee (Q2)', 'amount': 6000, 'status': 'PAID', 'dueDate': '10 Jul 2026', 'receipt': 'REC-2026-0943'},
    {'category': 'Tuition Fee (Q3 - Oct-Dec)', 'amount': 18000, 'status': 'PENDING', 'dueDate': '10 Oct 2026', 'receipt': null},
    {'category': 'Annual Examination & Sports Fee', 'amount': 3500, 'status': 'PENDING', 'dueDate': '10 Oct 2026', 'receipt': null},
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    int totalPaid = 0;
    int totalDue = 0;

    for (var f in _feeBreakdown) {
      if (f['status'] == 'PAID') {
        totalPaid += (f['amount'] as int);
      } else {
        totalDue += (f['amount'] as int);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Fees & Digital Receipts'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: ResponsiveTwoPane(
            breakpoint: 880,
            leftFlex: 5,
            rightFlex: 7,
            spacing: 24,
            leftPane: Column(
              children: [
                // 1. Fee Overview Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0984E3), Color(0xFF00CEC9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Outstanding Due', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('₹$totalDue', style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Due: 10 Oct 2026', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: Colors.white24, height: 1),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Paid this Year: ₹$totalPaid', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          Text('Session 2026-27', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Quick Pay Action
                if (totalDue > 0)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showUpiPaymentDialog(context, totalDue),
                      icon: const Icon(Icons.payment),
                      label: Text('Pay Outstanding (₹$totalDue) via UPI'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B894),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
              ],
            ),
            rightPane: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Fee Structure & Ledgers
                const Text(
                  'Fee Ledger & Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                ),
                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _feeBreakdown.length,
                  itemBuilder: (context, index) {
                    final item = _feeBreakdown[index];
                    final isPaid = item['status'] == 'PAID';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isPaid ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPaid ? Icons.check : Icons.access_time,
                              color: isPaid ? const Color(0xFF16A34A) : const Color(0xFFB45309),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['category'],
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isPaid ? 'Paid on ${item['dueDate']}' : 'Due on ${item['dueDate']}',
                                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${item['amount']}',
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              if (isPaid)
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Downloading Receipt ${item['receipt']}... 📄'),
                                        backgroundColor: const Color(0xFF00B894),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Receipt 📥',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF2F2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'DUE',
                                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUpiPaymentDialog(BuildContext context, int amount) {
    AdaptiveModal.show(
      context: context,
      maxWidth: 500,
      title: const Text('Pay School Fees', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount Payable', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('₹$amount', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF00B894))),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Select Payment Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 12),
          _buildPaymentOption(Icons.qr_code_scanner, 'Instant UPI QR (Scan & Pay)'),
          _buildPaymentOption(Icons.account_balance_wallet, 'PhonePe / Google Pay / Paytm'),
          _buildPaymentOption(Icons.credit_card, 'Debit / Credit Card & NetBanking'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment of ₹21,500 Successful! Receipt generated. 🎉'),
                backgroundColor: Color(0xFF00B894),
              ),
            );
          },
          child: const Text('Simulate Successful Payment'),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0984E3), size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}
