import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorApprovalsScreen extends StatefulWidget {
  const DirectorApprovalsScreen({super.key});

  @override
  State<DirectorApprovalsScreen> createState() => _DirectorApprovalsScreenState();
}

class _DirectorApprovalsScreenState extends State<DirectorApprovalsScreen> {
  final List<Map<String, dynamic>> _pendingApprovals = [
    {
      'id': 'REQ-2026-881',
      'title': 'Procurement of 20 High-End Workstations for AI & Robotics Lab',
      'department': 'IT & Computer Science Directorate',
      'requestedBy': 'Mr. Rajesh Mehra (Head of IT)',
      'amount': '₹ 14,50,000',
      'date': '04 Sep 2026',
      'justification': 'Required for teaching CBSE Python, Machine Learning and ROS Robotics syllabus for Grades 10-12.',
      'type': 'CAPEX_PURCHASE',
      'isApproved': false,
    },
    {
      'id': 'REQ-2026-874',
      'title': 'National Stadium Rental & Equipment for 34th Annual Athletic Meet',
      'department': 'Physical Education & Sports Cell',
      'requestedBy': 'Mr. Vikram Rathore (Sports Director)',
      'amount': '₹ 3,20,000',
      'date': '02 Sep 2026',
      'justification': 'Olympic track reservation for 1,200 participating students and parents on 15th October.',
      'type': 'EVENT_BUDGET',
      'isApproved': false,
    },
    {
      'id': 'REQ-2026-869',
      'title': 'CBSE Board Reference Books & Digital Research Subscriptions',
      'department': 'Central Library & Academic Cell',
      'requestedBy': 'Mrs. Sunita Kaul (Chief Librarian)',
      'amount': '₹ 1,85,000',
      'date': '29 Aug 2026',
      'justification': 'Procurement of 600 textbook volumes and IEEE science journal database access.',
      'type': 'ACADEMIC_RESOURCE',
      'isApproved': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Executive Governance & Approval Desk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('High-Value Capex & Policy Authorizations', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pending Count Banner
              AnimatedCard(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFF0F172A),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFD4AF37).withValues(alpha: 0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.approval, color: Color(0xFFD4AF37), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('PENDING EXECUTIVE SIGN-OFFS', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          const SizedBox(height: 2),
                          Text('${_pendingApprovals.where((a) => !a['isApproved']).length} Requisitions Awaiting Board Clearance (Total: ₹ 19.55 Lakhs)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // List of Approvals
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _pendingApprovals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final req = _pendingApprovals[index];
                  final isApproved = req['isApproved'] as bool;

                  return AnimatedCard(
                    padding: const EdgeInsets.all(22),
                    color: Colors.white,
                    border: Border.all(color: isApproved ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(req['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFD4AF37))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isApproved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isApproved ? 'APPROVED & AUTHORIZED' : 'PENDING BOARD SIGNATURE',
                                style: TextStyle(
                                  color: isApproved ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          req['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.business, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(req['department'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            const SizedBox(width: 14),
                            Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(req['requestedBy'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Justification: ${req['justification']}',
                            style: const TextStyle(fontSize: 13, color: Color(0xFF334155), height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Budget Value: ${req['amount']}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B)),
                            ),
                            if (!isApproved)
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Requisition ${req['id']} returned to department for revision.')),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFEF4444)),
                                    child: const Text('Reject / Request Revision'),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() => req['isApproved'] = true);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Digital Signature Applied! ${req['id']} Approved and funds disbursed.'),
                                          backgroundColor: const Color(0xFF10B981),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.verified_user, size: 16),
                                    label: const Text('Authorize & Sign'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF10B981),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
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
    );
  }
}
