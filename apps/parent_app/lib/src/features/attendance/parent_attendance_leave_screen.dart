import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentAttendanceLeaveScreen extends StatefulWidget {
  final String childName;
  const ParentAttendanceLeaveScreen({super.key, this.childName = 'Aarav Sharma'});

  @override
  State<ParentAttendanceLeaveScreen> createState() => _ParentAttendanceLeaveScreenState();
}

class _ParentAttendanceLeaveScreenState extends State<ParentAttendanceLeaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Leave Form State
  String _leaveReason = 'Medical Sickness / Fever';
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime _endDate = DateTime.now().add(const Duration(days: 2));
  final TextEditingController _notesController = TextEditingController();
  bool _isDocumentAttached = false;

  final List<Map<String, dynamic>> _leaveHistory = [
    {
      'id': 'lv_001',
      'dates': '12 Aug 2026 - 13 Aug 2026 (2 Days)',
      'reason': 'Viral Flu & Medical Rest',
      'status': 'APPROVED',
      'approvedBy': 'Dr. Priya Verma (Class Teacher)',
      'appliedOn': '11 Aug 2026',
      'hasDoc': true,
    },
    {
      'id': 'lv_002',
      'dates': '24 Jul 2026 (1 Day)',
      'reason': 'Family Religious Ceremony',
      'status': 'APPROVED',
      'approvedBy': 'Dr. Priya Verma (Class Teacher)',
      'appliedOn': '22 Jul 2026',
      'hasDoc': false,
    },
    {
      'id': 'lv_003',
      'dates': '08 Sep 2026 - 09 Sep 2026 (2 Days)',
      'reason': 'Orthodontist Dental Surgery',
      'status': 'PENDING',
      'approvedBy': 'Under Review',
      'appliedOn': '05 Sep 2026',
      'hasDoc': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance & Leave Desk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Student: ${widget.childName} • Class 10-A',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF6366F1),
          unselectedLabelColor: const Color(0xFF64748B),
          indicatorColor: const Color(0xFF6366F1),
          tabs: const [
            Tab(icon: Icon(Icons.analytics_outlined), text: 'Attendance Analytics'),
            Tab(icon: Icon(Icons.event_note_outlined), text: 'Apply & Manage Leaves'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAttendanceAnalyticsTab(),
          _buildLeaveManagementTab(),
        ],
      ),
    );
  }

  Widget _buildAttendanceAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ResponsiveContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    title: 'Term Attendance',
                    value: '94.2%',
                    subtext: 'Meets 75% minimum CBSE rule',
                    color: const Color(0xFF10B981),
                    icon: Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildMetricTile(
                    title: 'Total Present',
                    value: '82 Days',
                    subtext: 'Out of 87 working days',
                    color: const Color(0xFF3B82F6),
                    icon: Icons.calendar_today_outlined,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildMetricTile(
                    title: 'Leaves Taken',
                    value: '3 Days',
                    subtext: 'All officially approved',
                    color: const Color(0xFFF59E0B),
                    icon: Icons.time_to_leave_outlined,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildMetricTile(
                    title: 'Unexcused Absent',
                    value: '2 Days',
                    subtext: 'Parent notification sent',
                    color: const Color(0xFFEF4444),
                    icon: Icons.warning_amber_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Monthly Calendar Heatmap
            AnimatedCard(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE2E8F0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'September 2026 Daily Roll Call Matrix',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          _buildLegendDot(const Color(0xFF10B981), 'Present (P)'),
                          const SizedBox(width: 12),
                          _buildLegendDot(const Color(0xFFEF4444), 'Absent (A)'),
                          const SizedBox(width: 12),
                          _buildLegendDot(const Color(0xFFF59E0B), 'Leave (L)'),
                          const SizedBox(width: 12),
                          _buildLegendDot(const Color(0xFF94A3B8), 'Holiday (H)'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Grid of 30 days
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      // Mock attendance statuses
                      Color cellColor;
                      String statusLetter;

                      if (day % 7 == 6 || day % 7 == 0) {
                        cellColor = const Color(0xFFF1F5F9);
                        statusLetter = 'H';
                      } else if (day == 3) {
                        cellColor = const Color(0xFFFEE2E2);
                        statusLetter = 'A';
                      } else if (day == 8 || day == 9) {
                        cellColor = const Color(0xFFFEF3C7);
                        statusLetter = 'L';
                      } else if (day > 5) {
                        cellColor = const Color(0xFFF8FAFC);
                        statusLetter = '-';
                      } else {
                        cellColor = const Color(0xFFDCFCE7);
                        statusLetter = 'P';
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: day == 5 ? const Color(0xFF6366F1) : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0$day'.length == 3 ? '$day' : '0$day',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(
                                statusLetter,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: statusLetter == 'P'
                                      ? const Color(0xFF16A34A)
                                      : statusLetter == 'A'
                                          ? const Color(0xFFDC2626)
                                          : statusLetter == 'L'
                                              ? const Color(0xFFD97706)
                                              : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtext,
    required Color color,
    required IconData icon,
  }) {
    return AnimatedCard(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
      ],
    );
  }

  Widget _buildLeaveManagementTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: ResponsiveContainer(
        maxWidth: 1200,
        child: ResponsiveTwoPane(
          breakpoint: 840,
          leftFlex: 5,
          rightFlex: 5,
          leftPane: _buildApplyLeaveForm(),
          rightPane: _buildLeaveHistoryTimeline(),
        ),
      ),
    );
  }

  Widget _buildApplyLeaveForm() {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Submit Student Leave Application',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 16),
          const Text(
            'Reason for Absence',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _leaveReason,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Medical Sickness / Fever',
                child: Text('Medical Sickness / Fever'),
              ),
              DropdownMenuItem(
                value: 'Orthodontist / Hospital Visit',
                child: Text('Orthodontist / Hospital Visit'),
              ),
              DropdownMenuItem(
                value: 'Family Function / Marriage',
                child: Text('Family Function / Marriage'),
              ),
              DropdownMenuItem(
                value: 'Bereavement / Emergency',
                child: Text('Bereavement / Emergency'),
              ),
              DropdownMenuItem(
                value: 'Other Urgent Reasons',
                child: Text('Other Urgent Reasons'),
              ),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _leaveReason = val);
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    const SizedBox(height: 6),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) setState(() => _startDate = picked);
                      },
                      icon: const Icon(Icons.calendar_today, size: 14),
                      label: Text('${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    const SizedBox(height: 6),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: _startDate,
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) setState(() => _endDate = picked);
                      },
                      icon: const Icon(Icons.calendar_today, size: 14),
                      label: Text('${_endDate.day}/${_endDate.month}/${_endDate.year}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Parent Notes & Doctor Advice',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Describe symptoms or reasons in detail for the class teacher...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 16),
          // Document Attachment
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                Icon(
                  _isDocumentAttached ? Icons.check_circle : Icons.upload_file,
                  color: _isDocumentAttached ? const Color(0xFF10B981) : const Color(0xFF6366F1),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isDocumentAttached
                        ? 'Medical_Certificate_Prescription.pdf (Attached)'
                        : 'Attach Doctor Note / Prescription (Optional)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: _isDocumentAttached ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _isDocumentAttached = !_isDocumentAttached);
                  },
                  child: Text(_isDocumentAttached ? 'Remove' : 'Browse'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Leave Application submitted to Class Teacher Dr. Priya Verma!'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Submit Application'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveHistoryTimeline() {
    return AnimatedCard(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leave History & Approvals',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _leaveHistory.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final leave = _leaveHistory[index];
              final isApproved = leave['status'] == 'APPROVED';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        leave['dates'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isApproved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          leave['status'],
                          style: TextStyle(
                            color: isApproved ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reason: ${leave['reason']}',
                    style: const TextStyle(fontSize: 13, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.verified_user_outlined, size: 13, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Decision: ${leave['approvedBy']}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      if (leave['hasDoc'] == true) ...[
                        const Icon(Icons.attach_file, size: 13, color: Color(0xFF6366F1)),
                        const Text(
                          'Doc Attached',
                          style: TextStyle(fontSize: 11, color: Color(0xFF6366F1)),
                        ),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
