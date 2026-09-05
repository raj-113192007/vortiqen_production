import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentFeePaymentScreen extends StatefulWidget {
  final String childName;
  const ParentFeePaymentScreen({super.key, this.childName = 'Aarav Sharma'});

  @override
  State<ParentFeePaymentScreen> createState() => _ParentFeePaymentScreenState();
}

class _ParentFeePaymentScreenState extends State<ParentFeePaymentScreen> {
  bool _isPaying = false;
  String _selectedPaymentMethod = 'UPI_QR';

  final List<Map<String, dynamic>> _feeBreakdown = [
    {'title': 'Quarter 3 Tuition Fee (Oct - Dec)', 'amount': 18000, 'isMandatory': true},
    {'title': 'School Bus Transport (Route 14)', 'amount': 4500, 'isMandatory': true},
    {'title': 'Robotics & STEM Lab Surcharge', 'amount': 1500, 'isMandatory': true},
    {'title': 'Annual Sports & Activity Kit', 'amount': 500, 'isMandatory': false},
  ];

  final List<Map<String, dynamic>> _pastTransactions = [
    {
      'receiptNo': 'REC-2026-0892',
      'title': 'Quarter 2 Tuition & Transport Fee',
      'amount': '₹24,500',
      'paidDate': '10 Jul 2026',
      'method': 'UPI (Google Pay)',
      'status': 'SUCCESS',
    },
    {
      'receiptNo': 'REC-2026-0411',
      'title': 'Quarter 1 Tuition Fee & Annual Charges',
      'amount': '₹32,000',
      'paidDate': '08 Apr 2026',
      'method': 'HDFC Net Banking',
      'status': 'SUCCESS',
    },
  ];

  int get _totalAmount =>
      _feeBreakdown.fold(0, (sum, item) => sum + (item['amount'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fees & Online Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Student: ${widget.childName} • Roll No: 1024', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: ResponsiveTwoPane(
            breakpoint: 860,
            leftFlex: 6,
            rightFlex: 5,
            leftPane: _buildDueCardAndBreakdown(),
            rightPane: _buildPaymentHistoryPane(),
          ),
        ),
      ),
    );
  }

  Widget _buildDueCardAndBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Outstanding Dues Banner
        AnimatedCard(
          padding: const EdgeInsets.all(24),
          color: const Color(0xFF1E293B),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CURRENT OUTSTANDING DUE',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFEF4444)),
                    ),
                    child: const Text('Due in 10 Days', style: TextStyle(color: Color(0xFFFCA5A5), fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '₹$_totalAmount',
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'Quarter 3 (October - December 2026) • Due Date: 15 Oct 2026',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showPaymentModal(context),
                  icon: const Icon(Icons.lock_outline, size: 18),
                  label: const Text('Pay ₹24,500 Securely Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Itemized Breakdown
        AnimatedCard(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Itemized Fee Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              const SizedBox(height: 16),
              ..._feeBreakdown.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_box, color: const Color(0xFF6366F1), size: 18),
                          const SizedBox(width: 8),
                          Text(item['title'], style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
                        ],
                      ),
                      Text('₹${item['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                    ],
                  ),
                );
              }),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Payable Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
                  Text('₹$_totalAmount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF6366F1))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentHistoryPane() {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Payment History & Receipts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              Icon(Icons.receipt_long, color: Colors.grey[600], size: 20),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pastTransactions.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final tx = _pastTransactions[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tx['receiptNo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF6366F1))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('PAID', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount: ${tx['amount']} • ${tx['method']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      Text(tx['paidDate'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloading Tax Receipt ${tx['receiptNo']}...')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 14),
                    label: const Text('Download Official PDF Receipt', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Choose Payment Gateway', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    value: 'UPI_QR',
                    groupValue: _selectedPaymentMethod,
                    title: const Text('Instant UPI (Google Pay / PhonePe / Paytm / BHIM)'),
                    subtitle: const Text('Zero convenience surcharge • Instant confirmation'),
                    onChanged: (val) => setModalState(() => _selectedPaymentMethod = val!),
                  ),
                  RadioListTile<String>(
                    value: 'NET_BANKING',
                    groupValue: _selectedPaymentMethod,
                    title: const Text('Net Banking (HDFC, SBI, ICICI, Axis)'),
                    subtitle: const Text('Direct bank debit'),
                    onChanged: (val) => setModalState(() => _selectedPaymentMethod = val!),
                  ),
                  RadioListTile<String>(
                    value: 'CARDS',
                    groupValue: _selectedPaymentMethod,
                    title: const Text('Credit / Debit Card (Visa, MasterCard, RuPay)'),
                    subtitle: const Text('Supports EMI option'),
                    onChanged: (val) => setModalState(() => _selectedPaymentMethod = val!),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isPaying
                          ? null
                          : () async {
                              setModalState(() => _isPaying = true);
                              await Future.delayed(const Duration(seconds: 2));
                              if (mounted) {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Payment Successful! Receipt generated & sent to email.'),
                                    backgroundColor: Color(0xFF10B981),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _isPaying
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Proceed to Pay ₹24,500', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
