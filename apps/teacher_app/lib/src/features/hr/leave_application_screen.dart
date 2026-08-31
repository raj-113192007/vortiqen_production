import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ScholarLeaveItem {
  final String id;
  final String scholarName;
  final String rollNo;
  final String className;
  final String parentName;
  final String parentPhone;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String reason;
  final String leaveType; // 'Medical Leave', 'Family & Personal', 'Sports / Co-curricular', 'Casual'
  final String? attachmentName;
  final String appliedOn;
  String status; // 'PENDING', 'APPROVED', 'REJECTED', 'TRANSFERRED_TO_PRINCIPAL'
  String? teacherRemarks;
  String? actionDate;

  ScholarLeaveItem({
    required this.id,
    required this.scholarName,
    required this.rollNo,
    required this.className,
    required this.parentName,
    required this.parentPhone,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.reason,
    required this.leaveType,
    this.attachmentName,
    required this.appliedOn,
    required this.status,
    this.teacherRemarks,
    this.actionDate,
  });
}

class TeacherLeaveRequest {
  final String id;
  final String leaveType;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String reason;
  final String substituteTeacher;
  final String appliedOn;
  String status; // 'APPROVED', 'PENDING', 'REJECTED'
  final String? principalRemarks;

  TeacherLeaveRequest({
    required this.id,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.reason,
    required this.substituteTeacher,
    required this.appliedOn,
    required this.status,
    this.principalRemarks,
  });
}

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({super.key});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Teacher Leaves
  late List<TeacherLeaveRequest> _teacherLeaves;

  // Scholar Leaves for Class 10-A
  late List<ScholarLeaveItem> _scholarLeaves;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _teacherLeaves = [
      TeacherLeaveRequest(
        id: 'tl_1',
        leaveType: 'Casual Leave (CL)',
        startDate: '14 Aug 2026',
        endDate: '15 Aug 2026',
        totalDays: 2,
        reason: 'Family religious festival and ancestral puja at hometown.',
        substituteTeacher: 'Mr. Arvind Verma (PGT Chemistry - Room 204)',
        appliedOn: '10 Aug 2026',
        status: 'APPROVED',
        principalRemarks: 'Sanctioned. Lesson plans adjusted.',
      ),
      TeacherLeaveRequest(
        id: 'tl_2',
        leaveType: 'Medical Leave (ML)',
        startDate: '02 Jul 2026',
        endDate: '04 Jul 2026',
        totalDays: 3,
        reason: 'Severe viral fever with throat infection. Doctor prescription submitted.',
        substituteTeacher: 'Mrs. Sunita Kapoor (TGT Math)',
        appliedOn: '01 Jul 2026',
        status: 'APPROVED',
        principalRemarks: 'Approved with medical certificate.',
      ),
    ];

    _scholarLeaves = [
      ScholarLeaveItem(
        id: 'sl_101',
        scholarName: 'Rohan Mehta',
        rollNo: '103',
        className: 'Class 10-A',
        parentName: 'Mr. Rajesh Mehta (Father)',
        parentPhone: '+91 98112 34503',
        startDate: '02 Sep 2026',
        endDate: '04 Sep 2026',
        totalDays: 3,
        reason: 'Diagnosed with viral flu and high temperature. Advised 3 days complete bed rest by pediatrician.',
        leaveType: 'Medical Leave',
        attachmentName: 'Dr_Mehta_Medical_Prescription.pdf (1.2 MB)',
        appliedOn: 'Today, 08:15 AM',
        status: 'PENDING',
      ),
      ScholarLeaveItem(
        id: 'sl_102',
        scholarName: 'Kabir Kapoor',
        rollNo: '105',
        className: 'Class 10-A',
        parentName: 'Dr. Sunil Kapoor (Father)',
        parentPhone: '+91 98112 34505',
        startDate: '05 Sep 2026',
        endDate: '09 Sep 2026',
        totalDays: 5,
        reason: 'Elder brother\'s wedding ceremonies and rituals scheduled in Jaipur.',
        leaveType: 'Family & Personal',
        attachmentName: 'Wedding_Invitation_Card.jpg (850 KB)',
        appliedOn: 'Yesterday, 06:40 PM',
        status: 'PENDING',
      ),
      ScholarLeaveItem(
        id: 'sl_103',
        scholarName: 'Siddharth Rao',
        rollNo: '107',
        className: 'Class 10-A',
        parentName: 'Mrs. Rekha Rao (Mother)',
        parentPhone: '+91 98112 34507',
        startDate: '10 Sep 2026',
        endDate: '17 Sep 2026',
        totalDays: 8,
        reason: 'Representing Delhi State in Under-16 National Badminton Championship at Bengaluru.',
        leaveType: 'Sports / Co-curricular',
        attachmentName: 'State_Badminton_Federation_Letter.pdf (2.4 MB)',
        appliedOn: '28 Aug 2026',
        status: 'TRANSFERRED_TO_PRINCIPAL',
        teacherRemarks: 'Recommended for sanction under School Sports Quota. Total 8 days duration requires Principal signature.',
        actionDate: '29 Aug 2026',
      ),
      ScholarLeaveItem(
        id: 'sl_104',
        scholarName: 'Diya Patel',
        rollNo: '104',
        className: 'Class 10-A',
        parentName: 'Mrs. Bhavna Patel (Mother)',
        parentPhone: '+91 98112 34504',
        startDate: '25 Aug 2026',
        endDate: '26 Aug 2026',
        totalDays: 2,
        reason: 'Family wedding event in Ahmedabad.',
        leaveType: 'Family & Personal',
        appliedOn: '23 Aug 2026',
        status: 'APPROVED',
        teacherRemarks: 'Approved. Missed class notes shared via portal.',
        actionDate: '24 Aug 2026',
      ),
      ScholarLeaveItem(
        id: 'sl_105',
        scholarName: 'Vivaan Joshi',
        rollNo: '109',
        className: 'Class 10-A',
        parentName: 'Mr. Alok Joshi (Father)',
        parentPhone: '+91 98112 34509',
        startDate: '20 Aug 2026',
        endDate: '21 Aug 2026',
        totalDays: 2,
        reason: 'Unplanned family road trip during Mid-term unit test week.',
        leaveType: 'Casual',
        appliedOn: '19 Aug 2026',
        status: 'REJECTED',
        teacherRemarks: 'Rejected due to mandatory Science Unit Test-1 scheduled on 20 Aug.',
        actionDate: '19 Aug 2026',
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 1. Modal to Apply for Teacher's Own Leave
  void _showApplyTeacherLeaveModal() {
    final reasonController = TextEditingController();
    DateTime start = DateTime.now().add(const Duration(days: 1));
    DateTime end = DateTime.now().add(const Duration(days: 2));
    String leaveType = 'Casual Leave (CL)';
    String substitute = 'Mr. Arvind Verma (PGT Chemistry)';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          final daysCount = end.difference(start).inDays + 1;
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add_task_rounded, color: Color(0xFF10B981), size: 22),
                ),
                const SizedBox(width: 12),
                const Text('Apply for Faculty Leave', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
              ],
            ),
            content: SizedBox(
              width: 480,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Leave Type
                    const Text('Leave Type & Quota:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: leaveType,
                          isExpanded: true,
                          items: [
                            'Casual Leave (CL - 8 Remaining)',
                            'Medical Leave (ML - 10 Remaining)',
                            'Earned Leave (EL - 5 Remaining)',
                            'Duty / Exam Invigilation Leave (DL)',
                            'Half Day Leave',
                          ].map((e) => DropdownMenuItem(value: e.split(' - ')[0], child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (v) {
                            if (v != null) setModalState(() => leaveType = v);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Date Pickers
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Start Date:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () async {
                                  final p = await showDatePicker(context: context, initialDate: start, firstDate: DateTime.now(), lastDate: DateTime(2027));
                                  if (p != null) {
                                    setModalState(() {
                                      start = p;
                                      if (end.isBefore(start)) end = start;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFCBD5E1))),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF10B981)),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('dd MMM yyyy').format(start), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('End Date:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () async {
                                  final p = await showDatePicker(context: context, initialDate: end, firstDate: start, lastDate: DateTime(2027));
                                  if (p != null) {
                                    setModalState(() => end = p);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFCBD5E1))),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF10B981)),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('dd MMM yyyy').format(end), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Total Duration: $daysCount Day(s)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF10B981))),
                    const SizedBox(height: 14),

                    // Substitute Teacher
                    const Text('Classroom / Period Substitute Arrangement:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: substitute,
                          isExpanded: true,
                          items: [
                            'Mr. Arvind Verma (PGT Chemistry)',
                            'Mrs. Sunita Kapoor (TGT Math)',
                            'Ms. Pooja Mehra (TGT Science)',
                          ].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (v) {
                            if (v != null) setModalState(() => substitute = v);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Reason
                    TextField(
                      controller: reasonController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Reason for Leave',
                        hintText: 'Brief explanation for Principal and Headmistress approval...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              ElevatedButton.icon(
                onPressed: () {
                  if (reasonController.text.trim().isEmpty) return;

                  setState(() {
                    _teacherLeaves.insert(
                      0,
                      TeacherLeaveRequest(
                        id: 'tl_${DateTime.now().millisecondsSinceEpoch}',
                        leaveType: leaveType,
                        startDate: DateFormat('dd MMM yyyy').format(start),
                        endDate: DateFormat('dd MMM yyyy').format(end),
                        totalDays: daysCount,
                        reason: reasonController.text.trim(),
                        substituteTeacher: substitute,
                        appliedOn: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        status: 'PENDING',
                      ),
                    );
                  });

                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Leave application submitted to School Principal & Management! 📨'),
                      backgroundColor: Color(0xFF10B981),
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded, size: 16),
                label: const Text('Submit Application'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 2. Scholar Leave Action Modals (Approve, Reject, Transfer)
  void _openScholarLeaveActionDialog(ScholarLeaveItem leave) {
    final remarksController = TextEditingController(text: leave.teacherRemarks ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.fact_check_rounded, color: Color(0xFF6C5CE7), size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class 10-A Leave Action', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                  Text('${leave.scholarName} (Roll ${leave.rollNo}) • ${leave.totalDays} Days', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 480,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Period: ${leave.startDate} to ${leave.endDate} (${leave.totalDays} Days)', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF1E293B))),
                      const SizedBox(height: 4),
                      Text('Type: ${leave.leaveType}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7))),
                      const SizedBox(height: 4),
                      Text('Reason: ${leave.reason}', style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                      if (leave.attachmentName != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_file_rounded, size: 14, color: Color(0xFF0984E3)),
                            const SizedBox(width: 4),
                            Text('Attached: ${leave.attachmentName}', style: const TextStyle(fontSize: 11, color: Color(0xFF0984E3), fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Teacher Remarks / Justification (Mandatory for Reject/Forward):', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                const SizedBox(height: 6),
                TextField(
                  controller: remarksController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'e.g. Prescription verified • Transferred to Principal due to sports quota...',
                    hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // 1. REJECT BUTTON
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                leave.status = 'REJECTED';
                leave.teacherRemarks = remarksController.text.trim().isNotEmpty ? remarksController.text.trim() : 'Rejected by Class Teacher';
                leave.actionDate = DateFormat('dd MMM yyyy').format(DateTime.now());
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Leave application for ${leave.scholarName} REJECTED. ❌'), backgroundColor: const Color(0xFFEF4444)),
              );
            },
            icon: const Icon(Icons.cancel_outlined, size: 14),
            label: const Text('Reject'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
              side: const BorderSide(color: Color(0xFFEF4444)),
            ),
          ),

          // 2. FORWARD TO PRINCIPAL BUTTON
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                leave.status = 'TRANSFERRED_TO_PRINCIPAL';
                leave.teacherRemarks = remarksController.text.trim().isNotEmpty ? remarksController.text.trim() : 'Forwarded to Principal Desk for approval';
                leave.actionDate = DateFormat('dd MMM yyyy').format(DateTime.now());
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Leave application for ${leave.scholarName} TRANSFERRED to Principal Desk. 🏛️'), backgroundColor: const Color(0xFF6C5CE7)),
              );
            },
            icon: const Icon(Icons.account_balance_rounded, size: 14),
            label: const Text('Forward to Principal'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6C5CE7),
              side: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
          ),

          // 3. APPROVE BUTTON
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                leave.status = 'APPROVED';
                leave.teacherRemarks = remarksController.text.trim().isNotEmpty ? remarksController.text.trim() : 'Approved by Class Teacher';
                leave.actionDate = DateFormat('dd MMM yyyy').format(DateTime.now());
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Leave application for ${leave.scholarName} APPROVED & marked in Register! ✅'), backgroundColor: const Color(0xFF10B981)),
              );
            },
            icon: const Icon(Icons.check_circle_rounded, size: 15),
            label: const Text('Approve Leave'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingScholarLeaves = _scholarLeaves.where((l) => l.status == 'PENDING').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Leave & Absence Sanction Hub',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          ElevatedButton.icon(
            onPressed: _showApplyTeacherLeaveModal,
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text('Apply Faculty Leave'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
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
            // 1. TOP TAB SWITCHER (My Leaves vs Scholar Leaves)
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF10B981),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFF10B981),
                  unselectedLabelColor: const Color(0xFF64748B),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.school_rounded, size: 18),
                      text: 'Class 10-A Scholar Leaves ($pendingScholarLeaves Action Required)',
                    ),
                    const Tab(
                      icon: Icon(Icons.person_pin_rounded, size: 18),
                      text: 'My Faculty Leaves & Quota (Teacher Self-Service)',
                    ),
                  ],
                  onTap: (_) => setState(() {}),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 2. TAB VIEW CONTAINER
            FadeSlideEntry(
              delay: const Duration(milliseconds: 100),
              child: SizedBox(
                height: 720,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildScholarLeavesTab(),
                    _buildTeacherLeavesTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 1: SCHOLAR LEAVE APPROVALS (CLASS 10-A)
  Widget _buildScholarLeavesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.how_to_reg_rounded, color: Color(0xFF10B981), size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Class 10-A Parent Leave Sanction Cockpit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
                      SizedBox(height: 2),
                      Text(
                        'As designated Class Teacher, you can Approve, Reject, or Forward long leaves (>3 days) to Principal Desk.',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _scholarLeaves.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final leave = _scholarLeaves[index];
              return _buildScholarLeaveCard(leave);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScholarLeaveCard(ScholarLeaveItem leave) {
    final isPending = leave.status == 'PENDING';
    final isApproved = leave.status == 'APPROVED';
    final isTransferred = leave.status == 'TRANSFERRED_TO_PRINCIPAL';

    final Color statusColor = isApproved
        ? const Color(0xFF10B981)
        : isPending
            ? const Color(0xFFF59E0B)
            : isTransferred
                ? const Color(0xFF6C5CE7)
                : const Color(0xFFEF4444);

    final String statusLabel = isApproved
        ? 'APPROVED ✅'
        : isPending
            ? 'ACTION REQUIRED ⏳'
            : isTransferred
                ? 'AT PRINCIPAL DESK 🏛️'
                : 'REJECTED ❌';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPending ? const Color(0xFFF59E0B).withValues(alpha: 0.3) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Text(leave.rollNo, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Color(0xFF10B981))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${leave.scholarName} (${leave.className})', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B))),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                          child: Text('${leave.totalDays} Days Leave', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('Parent: ${leave.parentName} (${leave.parentPhone}) • Applied: ${leave.appliedOn}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                child: Text(statusLabel, style: TextStyle(color: statusColor, fontWeight: FontWeight.w900, fontSize: 10)),
              ),
            ],
          ),
          const Divider(height: 20),

          // Leave Details
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(leave.leaveType, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
              ),
              const SizedBox(width: 8),
              Text('${leave.startDate} to ${leave.endDate}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Color(0xFF1E293B))),
            ],
          ),
          const SizedBox(height: 8),
          Text(leave.reason, style: const TextStyle(fontSize: 12, color: Color(0xFF475569), height: 1.4)),

          if (leave.attachmentName != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF86EFAC))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.attach_file_rounded, size: 14, color: Color(0xFF16A34A)),
                  const SizedBox(width: 6),
                  Text(leave.attachmentName!, style: const TextStyle(fontSize: 11, color: Color(0xFF16A34A), fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],

          if (leave.teacherRemarks != null) ...[
            const SizedBox(height: 10),
            Text('Action Log: ${leave.teacherRemarks!} (On ${leave.actionDate ?? 'Recently'})', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontStyle: FontStyle.italic)),
          ],

          const SizedBox(height: 14),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isPending) ...[
                OutlinedButton.icon(
                  onPressed: () => _openScholarLeaveActionDialog(leave),
                  icon: const Icon(Icons.rule_rounded, size: 15),
                  label: const Text('Review & Sanction (Approve / Reject / Forward)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF10B981),
                    side: const BorderSide(color: Color(0xFF10B981)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                  ),
                ),
              ] else ...[
                OutlinedButton.icon(
                  onPressed: () => _openScholarLeaveActionDialog(leave),
                  icon: const Icon(Icons.edit_note_rounded, size: 15),
                  label: const Text('Update Decision Remarks'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // TAB 2: TEACHER'S OWN LEAVE APPLICATION & QUOTA
  Widget _buildTeacherLeavesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 4 Leave Balances KPI Tiles
          LayoutBuilder(
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
                  _buildQuotaCard('Casual Leave (CL)', '8 Left', 'Total: 12 / Year', Icons.beach_access_rounded, const Color(0xFF10B981)),
                  _buildQuotaCard('Medical Leave (ML)', '10 Left', 'Total: 14 / Year', Icons.medical_services_rounded, const Color(0xFF0984E3)),
                  _buildQuotaCard('Earned Leave (EL)', '5 Left', 'Accumulated', Icons.workspace_premium_rounded, const Color(0xFF6C5CE7)),
                  _buildQuotaCard('Duty Leave (DL)', '4 Left', 'CBSE / Training', Icons.assignment_turned_in_rounded, const Color(0xFFF59E0B)),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Leave History
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('My Leave Request History', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    ElevatedButton.icon(
                      onPressed: _showApplyTeacherLeaveModal,
                      icon: const Icon(Icons.add_rounded, size: 15),
                      label: const Text('Apply New Leave'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _teacherLeaves.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final l = _teacherLeaves[index];
                    final isApproved = l.status == 'APPROVED';
                    final isPending = l.status == 'PENDING';
                    final Color color = isApproved ? const Color(0xFF10B981) : (isPending ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));

                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(l.leaveType, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                                  const SizedBox(width: 8),
                                  Text('• ${l.totalDays} Day(s) (${l.startDate} to ${l.endDate})', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
                                child: Text(l.status, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Reason: ${l.reason}', style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
                          const SizedBox(height: 4),
                          Text('Substitute: ${l.substituteTeacher}', style: const TextStyle(fontSize: 10, color: Color(0xFF6C5CE7), fontWeight: FontWeight.w700)),
                          if (l.principalRemarks != null) ...[
                            const SizedBox(height: 4),
                            Text('Principal Remarks: "${l.principalRemarks}"', style: const TextStyle(fontSize: 10, color: Color(0xFF10B981), fontStyle: FontStyle.italic)),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotaCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
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
}
