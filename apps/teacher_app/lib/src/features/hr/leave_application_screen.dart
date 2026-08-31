import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({super.key});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  String _selectedLeaveType = 'Casual Leave (CL)';
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  final _reasonController = TextEditingController();

  final List<Map<String, String>> _leaveHistory = [
    {
      'type': 'Casual Leave (CL)',
      'dates': '14 Aug 2026 - 15 Aug 2026 (2 Days)',
      'reason': 'Family religious ceremony & festival',
      'status': 'APPROVED',
      'appliedOn': '10 Aug 2026',
    },
    {
      'type': 'Medical Leave (ML)',
      'dates': '02 Jul 2026 - 04 Jul 2026 (3 Days)',
      'reason': 'Viral fever and doctor prescription',
      'status': 'APPROVED',
      'appliedOn': '01 Jul 2026',
    },
  ];

  void _submitLeave() {
    if (_reasonController.text.isEmpty) return;

    setState(() {
      _leaveHistory.insert(0, {
        'type': _selectedLeaveType,
        'dates': '${DateFormat('dd MMM yyyy').format(_startDate)} - ${DateFormat('dd MMM yyyy').format(_endDate)}',
        'reason': _reasonController.text,
        'status': 'PENDING APPROVAL',
        'appliedOn': DateFormat('dd MMM yyyy').format(DateTime.now()),
      });
      _reasonController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Leave Application submitted to Principal & Admin Desk! 📨'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
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
            child: _buildHeader(),
          ),
          const SizedBox(height: 20),

          // Leave Balance Tiles
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: _buildLeaveBalances(),
          ),
          const SizedBox(height: 20),

          // Apply for Leave Form
          FadeSlideEntry(
            delay: const Duration(milliseconds: 150),
            child: _buildApplyForm(),
          ),
          const SizedBox(height: 24),

          // History of Leaves
          FadeSlideEntry(
            delay: const Duration(milliseconds: 200),
            child: _buildHistorySection(),
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
                'Teacher Leave Portal & Balance Vault',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Apply for Paid Casual Leaves, Medical Time-Off & Track Principal Approval Status',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Icon(Icons.event_busy_rounded, color: Color(0xFF10B981), size: 32),
        ],
      ),
    );
  }

  Widget _buildLeaveBalances() {
    return Row(
      children: [
        Expanded(child: _buildBalancePill(8.0, 'Casual Leaves (CL)', 'Available Balance', const Color(0xFF10B981))),
        const SizedBox(width: 12),
        Expanded(child: _buildBalancePill(6.0, 'Medical Leaves (ML)', 'Paid Sick Leave', const Color(0xFF0984E3))),
        const SizedBox(width: 12),
        Expanded(child: _buildBalancePill(12.0, 'Earned Leaves (EL)', 'Accrued Annual', const Color(0xFF6C5CE7))),
      ],
    );
  }

  Widget _buildBalancePill(double count, String title, String sub, Color color) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      borderRadius: 14,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.date_range_rounded, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: count,
                  suffix: ' Days',
                  fractionDigits: 0,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Submit New Leave Request', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _selectedLeaveType,
            decoration: InputDecoration(
              labelText: 'Select Leave Category',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: ['Casual Leave (CL)', 'Medical Leave (ML)', 'Earned Leave (EL)', 'Duty Leave (On-Duty)'].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
            onChanged: (val) => setState(() => _selectedLeaveType = val!),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(context: context, initialDate: _startDate, firstDate: DateTime.now(), lastDate: DateTime(2028));
                    if (picked != null) setState(() => _startDate = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(DateFormat('dd MMM yyyy').format(_startDate), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(context: context, initialDate: _endDate, firstDate: _startDate, lastDate: DateTime(2028));
                    if (picked != null) setState(() => _endDate = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(DateFormat('dd MMM yyyy').format(_endDate), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _reasonController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Reason for Leave & Proxy Period Arrangements',
              hintText: 'e.g. Urgent family matter. Mr. Sharma will cover Class 10-A Math period.',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _submitLeave,
              icon: const Icon(Icons.send_rounded, size: 16),
              label: const Text('Submit Application'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Previous Leave Applications & Approvals', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _leaveHistory.length,
          itemBuilder: (context, index) {
            final l = _leaveHistory[index];
            final isApproved = l['status'] == 'APPROVED';

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: HoverLiftCard(
                padding: const EdgeInsets.all(16),
                borderRadius: 14,
                hoverBorderColor: isApproved ? const Color(0xFF10B981).withValues(alpha: 0.35) : const Color(0xFFF59E0B).withValues(alpha: 0.35),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: isApproved ? const Color(0xFF10B981).withValues(alpha: 0.12) : const Color(0xFFF59E0B).withValues(alpha: 0.12),
                      child: Icon(isApproved ? Icons.check_circle_rounded : Icons.pending_rounded, color: isApproved ? const Color(0xFF10B981) : const Color(0xFFF59E0B), size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(l['type']!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                              const SizedBox(width: 8),
                              Text('(${l['dates']})', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('Reason: ${l['reason']}', style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isApproved ? const Color(0xFF10B981).withValues(alpha: 0.12) : const Color(0xFFF59E0B).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l['status']!,
                        style: TextStyle(color: isApproved ? const Color(0xFF10B981) : const Color(0xFFF59E0B), fontWeight: FontWeight.w800, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
