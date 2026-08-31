import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentComplaint {
  final String id;
  final String scholarName;
  final String rollNo;
  final String className;
  final String parentName;
  final String relationship;
  final String parentPhone;
  final String category; // 'Academics', 'Behavior & Peer', 'Bus & Transport', 'Homework', 'Health'
  final String priority; // 'HIGH', 'MEDIUM', 'NORMAL'
  final String subject;
  final String description;
  final String timestamp;
  String status; // 'PENDING', 'IN_PROGRESS', 'RESOLVED'
  String? teacherRemarks;
  String? resolvedOn;

  ParentComplaint({
    required this.id,
    required this.scholarName,
    required this.rollNo,
    required this.className,
    required this.parentName,
    required this.relationship,
    required this.parentPhone,
    required this.category,
    required this.priority,
    required this.subject,
    required this.description,
    required this.timestamp,
    required this.status,
    this.teacherRemarks,
    this.resolvedOn,
  });
}

class ParentComplaintsScreen extends StatefulWidget {
  const ParentComplaintsScreen({super.key});

  @override
  State<ParentComplaintsScreen> createState() => _ParentComplaintsScreenState();
}

class _ParentComplaintsScreenState extends State<ParentComplaintsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'ALL';
  String _searchQuery = '';

  late List<ParentComplaint> _complaints;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _complaints = [
      ParentComplaint(
        id: 'comp_101',
        scholarName: 'Rohan Mehta',
        rollNo: '103',
        className: 'Class 10-A',
        parentName: 'Mr. Rajesh Mehta',
        relationship: 'Father',
        parentPhone: '+91 98112 34503',
        category: 'Academics',
        priority: 'HIGH',
        subject: 'Difficulty in understanding Ray Optics numericals in Physics',
        description: 'Rohan is struggling with sign conventions in lens formula. Could Sir please arrange a 15-minute doubt clearing slot or extra practice sheets?',
        timestamp: 'Today, 09:30 AM',
        status: 'PENDING',
      ),
      ParentComplaint(
        id: 'comp_102',
        scholarName: 'Siddharth Rao',
        rollNo: '107',
        className: 'Class 10-A',
        parentName: 'Mrs. Rekha Rao',
        relationship: 'Mother',
        parentPhone: '+91 98112 34507',
        category: 'Bus & Transport',
        priority: 'HIGH',
        subject: 'Route 14 bus arriving 25 minutes late consistently',
        description: 'Due to morning bus delay at Sector 62, Siddharth has been getting marked Late in morning assembly for the past 3 days. Kindly check with transport head.',
        timestamp: 'Yesterday, 04:15 PM',
        status: 'PENDING',
      ),
      ParentComplaint(
        id: 'comp_103',
        scholarName: 'Kabir Kapoor',
        rollNo: '105',
        className: 'Class 10-A',
        parentName: 'Dr. Sunil Kapoor',
        relationship: 'Father',
        parentPhone: '+91 98112 34505',
        category: 'Behavior & Peer',
        priority: 'MEDIUM',
        subject: 'Desk seating rearrangement request in Class 10-A',
        description: 'Kabir sits in the last row and has mild myopia (-1.5D). Could he be shifted to the first two rows until his new glasses arrive next week?',
        timestamp: '28 Aug 2026',
        status: 'IN_PROGRESS',
        teacherRemarks: 'Spoke with Dr. Sunil on phone. Shifted Kabir to Row 2, Desk 3 beside Aarav.',
      ),
      ParentComplaint(
        id: 'comp_104',
        scholarName: 'Diya Patel',
        rollNo: '104',
        className: 'Class 10-A',
        parentName: 'Mrs. Bhavna Patel',
        relationship: 'Mother',
        parentPhone: '+91 98112 34504',
        category: 'Homework',
        priority: 'NORMAL',
        subject: 'Term 1 Science Project submission extension request',
        description: 'Diya was down with seasonal viral fever for 4 days. Requesting a 2-day grace period to submit the Physics working model.',
        timestamp: '26 Aug 2026',
        status: 'IN_PROGRESS',
        teacherRemarks: 'Granted extension until Monday 31 August. Medical prescription verified.',
      ),
      ParentComplaint(
        id: 'comp_105',
        scholarName: 'Ananya Iyer',
        rollNo: '102',
        className: 'Class 10-A',
        parentName: 'Mr. V. Iyer',
        relationship: 'Father',
        parentPhone: '+91 98112 34502',
        category: 'Academics',
        priority: 'NORMAL',
        subject: 'Appreciation for Class 10-A Science Exhibition Guidance',
        description: 'Thanking Prof. Rajesh Sharma for mentoring Ananya in the National Science Olympiad Regional round qualifiers.',
        timestamp: '22 Aug 2026',
        status: 'RESOLVED',
        teacherRemarks: 'Acknowledged note. Ananya shortlisted for State Level.',
        resolvedOn: '23 Aug 2026',
      ),
      ParentComplaint(
        id: 'comp_106',
        scholarName: 'Aarav Sharma',
        rollNo: '101',
        className: 'Class 10-A',
        parentName: 'Mrs. Meenakshi Sharma',
        relationship: 'Mother',
        parentPhone: '+91 98112 34501',
        category: 'Health',
        priority: 'MEDIUM',
        subject: 'Sports period hydration & inhaler permission',
        description: 'Aarav carries a mild asthma inhaler in his bag. Requested physical instructor to monitor him during high sprint drills.',
        timestamp: '18 Aug 2026',
        status: 'RESOLVED',
        teacherRemarks: 'Informed Sports HOD Coach Verma. Aarav allowed custom warmups.',
        resolvedOn: '19 Aug 2026',
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showResolutionModal(ParentComplaint complaint) {
    final remarksController = TextEditingController(text: complaint.teacherRemarks ?? '');
    String currentStatus = complaint.status == 'PENDING' ? 'IN_PROGRESS' : complaint.status;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.rate_review_rounded, color: Color(0xFF6C5CE7), size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resolve Parent Grievance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    Text('${complaint.scholarName} (${complaint.className}) • ${complaint.parentName}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Complaint Details Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subject: ${complaint.subject}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                        const SizedBox(height: 6),
                        Text(complaint.description, style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.phone_rounded, size: 12, color: Color(0xFF10B981)),
                            const SizedBox(width: 4),
                            Text('Parent Phone: ${complaint.parentPhone}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF10B981))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text('Update Grievance Status:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildModalStatusChip('PENDING', 'Pending Review', const Color(0xFFEF4444), currentStatus, (s) => setModalState(() => currentStatus = s)),
                      _buildModalStatusChip('IN_PROGRESS', 'In Progress / Action Taken', const Color(0xFFF59E0B), currentStatus, (s) => setModalState(() => currentStatus = s)),
                      _buildModalStatusChip('RESOLVED', 'Resolved & Closed', const Color(0xFF10B981), currentStatus, (s) => setModalState(() => currentStatus = s)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text('Teacher\'s Official Resolution Remarks & Action Taken:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(height: 6),
                  TextField(
                    controller: remarksController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'e.g. Spoke to parent on phone, adjusted seating plan in Class 10-A, notified bus coordinator...',
                      hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Grievance #${complaint.id} escalated to School Principal & Admin Desk. ⚠️'),
                    backgroundColor: const Color(0xFF6C5CE7),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_upward_rounded, size: 15),
              label: const Text('Escalate to Principal'),
              style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF6C5CE7)),
            ),
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  complaint.status = currentStatus;
                  complaint.teacherRemarks = remarksController.text.trim();
                  if (currentStatus == 'RESOLVED') {
                    complaint.resolvedOn = DateFormat('dd MMM yyyy').format(DateTime.now());
                  }
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Parent Grievance updated to "$currentStatus" with your remarks! ✅'),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text('Save & Notify Parent'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalStatusChip(String key, String label, Color color, String current, Function(String) onSelect) {
    final isSelected = current == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) onSelect(key);
      },
      selectedColor: color.withValues(alpha: 0.15),
      labelStyle: TextStyle(
        fontSize: 11,
        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
        color: isSelected ? color : const Color(0xFF64748B),
      ),
    );
  }

  void _showNewComplaintDialog() {
    final scholarController = TextEditingController();
    final parentController = TextEditingController();
    final phoneController = TextEditingController();
    final subjectController = TextEditingController();
    final descController = TextEditingController();
    String category = 'Academics';
    String priority = 'MEDIUM';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Log Parent Call / Inquiry', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          content: SizedBox(
            width: 460,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: scholarController,
                    decoration: InputDecoration(
                      labelText: 'Scholar Name & Roll No (Class 10-A)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: parentController,
                          decoration: InputDecoration(
                            labelText: 'Parent Name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: subjectController,
                    decoration: InputDecoration(
                      labelText: 'Grievance / Inquiry Subject',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Concern Details & Parent Discussion',
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
            ElevatedButton(
              onPressed: () {
                if (scholarController.text.trim().isEmpty || subjectController.text.trim().isEmpty) return;

                setState(() {
                  _complaints.insert(
                    0,
                    ParentComplaint(
                      id: 'comp_${DateTime.now().millisecondsSinceEpoch}',
                      scholarName: scholarController.text.trim(),
                      rollNo: '110',
                      className: 'Class 10-A',
                      parentName: parentController.text.trim().isNotEmpty ? parentController.text.trim() : 'Parent / Guardian',
                      relationship: 'Guardian',
                      parentPhone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : '+91 98112 00000',
                      category: category,
                      priority: priority,
                      subject: subjectController.text.trim(),
                      description: descController.text.trim(),
                      timestamp: 'Just now',
                      status: 'PENDING',
                    ),
                  );
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Parent inquiry logged successfully in Class 10-A ledger! 📝'), backgroundColor: Color(0xFF10B981)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Save Inquiry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _complaints.where((c) => c.status == 'PENDING').length;
    final inProgressCount = _complaints.where((c) => c.status == 'IN_PROGRESS').length;
    final resolvedCount = _complaints.where((c) => c.status == 'RESOLVED').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Parent Concerns & Grievance Cockpit',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          ElevatedButton.icon(
            onPressed: _showNewComplaintDialog,
            icon: const Icon(Icons.add_comment_rounded, size: 16),
            label: const Text('Log Parent Call'),
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
            // 1. TOP METRICS HEADER
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
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
                      _buildSummaryTile('Total Concerns', '${_complaints.length}', 'Class 10-A Parents', Icons.forum_outlined, const Color(0xFF6C5CE7)),
                      _buildSummaryTile('Action Required', '$pendingCount', 'Awaiting Review', Icons.pending_actions_rounded, const Color(0xFFEF4444)),
                      _buildSummaryTile('In Follow-Up', '$inProgressCount', 'Action in Progress', Icons.autorenew_rounded, const Color(0xFFF59E0B)),
                      _buildSummaryTile('Resolved', '$resolvedCount', 'Satisfied & Closed', Icons.task_alt_rounded, const Color(0xFF10B981)),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 18),

            // 2. TAB CONTROLS & SEARCH BAR
            FadeSlideEntry(
              delay: const Duration(milliseconds: 80),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: const Color(0xFF10B981),
                            indicatorWeight: 3,
                            labelColor: const Color(0xFF10B981),
                            unselectedLabelColor: const Color(0xFF64748B),
                            labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                            tabs: [
                              Tab(text: 'All (${_complaints.length})'),
                              Tab(text: 'Action Required ($pendingCount)'),
                              Tab(text: 'In Progress ($inProgressCount)'),
                              Tab(text: 'Resolved ($resolvedCount)'),
                            ],
                            onTap: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Search & Category Filters
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        Wrap(
                          spacing: 6,
                          children: ['ALL', 'Academics', 'Behavior & Peer', 'Bus & Transport', 'Homework', 'Health'].map((cat) {
                            final isSel = _selectedCategory == cat;
                            return ChoiceChip(
                              label: Text(cat),
                              selected: isSel,
                              onSelected: (val) {
                                if (val) setState(() => _selectedCategory = cat);
                              },
                              selectedColor: const Color(0xFF10B981).withValues(alpha: 0.15),
                              labelStyle: TextStyle(
                                fontSize: 11,
                                fontWeight: isSel ? FontWeight.w800 : FontWeight.w600,
                                color: isSel ? const Color(0xFF10B981) : const Color(0xFF64748B),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            onChanged: (v) => setState(() => _searchQuery = v),
                            decoration: InputDecoration(
                              hintText: 'Search parent, scholar, subject...',
                              hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                              prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: const Color(0xFFF8FAFC),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 3. COMPLAINTS LIST
            FadeSlideEntry(
              delay: const Duration(milliseconds: 140),
              child: _buildComplaintsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String title, String value, String subtitle, IconData icon, Color color) {
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
                Text(value, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: color)),
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintsList() {
    final currentTabIndex = _tabController.index;
    String statusFilter = 'ALL';
    if (currentTabIndex == 1) statusFilter = 'PENDING';
    if (currentTabIndex == 2) statusFilter = 'IN_PROGRESS';
    if (currentTabIndex == 3) statusFilter = 'RESOLVED';

    final filtered = _complaints.where((c) {
      final matchesStatus = statusFilter == 'ALL' || c.status == statusFilter;
      final matchesCat = _selectedCategory == 'ALL' || c.category == _selectedCategory;
      final query = _searchQuery.toLowerCase();
      final matchesQuery = _searchQuery.isEmpty ||
          c.scholarName.toLowerCase().contains(query) ||
          c.parentName.toLowerCase().contains(query) ||
          c.subject.toLowerCase().contains(query) ||
          c.description.toLowerCase().contains(query);
      return matchesStatus && matchesCat && matchesQuery;
    }).toList();

    if (filtered.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: const [
            Icon(Icons.check_circle_outline_rounded, size: 48, color: Color(0xFF10B981)),
            SizedBox(height: 12),
            Text('No Pending Parent Grievances in this View', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('All parent communications are up to date.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final complaint = filtered[index];
        return _buildComplaintCard(complaint);
      },
    );
  }

  Widget _buildComplaintCard(ParentComplaint c) {
    final isPending = c.status == 'PENDING';
    final isInProgress = c.status == 'IN_PROGRESS';
    final isResolved = c.status == 'RESOLVED';

    final Color statusColor = isPending
        ? const Color(0xFFEF4444)
        : isInProgress
            ? const Color(0xFFF59E0B)
            : const Color(0xFF10B981);

    final isHighPriority = c.priority == 'HIGH';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPending ? const Color(0xFFEF4444).withValues(alpha: 0.3) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Scholar, Parent & Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  c.rollNo,
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF10B981), fontSize: 14),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${c.scholarName} (${c.className})',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
                        ),
                        const SizedBox(width: 8),
                        if (isHighPriority)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(4)),
                            child: const Text('HIGH PRIORITY 🚨', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFFDC2626))),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Parent: ${c.parentName} (${c.relationship}) • Submitted: ${c.timestamp}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  c.status == 'PENDING' ? 'ACTION REQUIRED' : c.status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.w900, fontSize: 10),
                ),
              ),
            ],
          ),
          const Divider(height: 22),

          // Subject & Description
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                child: Text(c.category, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  c.subject,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            c.description,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569), height: 1.4),
          ),

          // Action Taken Box (if any)
          if (c.teacherRemarks != null && c.teacherRemarks!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.forum_rounded, size: 14, color: Color(0xFF16A34A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Teacher Action & Response:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF166534))),
                        const SizedBox(height: 2),
                        Text(c.teacherRemarks!, style: const TextStyle(fontSize: 11, color: Color(0xFF14532D))),
                        if (c.resolvedOn != null)
                          Text('Closed on ${c.resolvedOn}', style: const TextStyle(fontSize: 10, color: Color(0xFF16A34A))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),

          // Action Buttons: Call Parent, Respond & Resolve
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Dialing ${c.parentName} (${c.parentPhone})... 📞')),
                  );
                },
                icon: const Icon(Icons.phone_in_talk_rounded, size: 14),
                label: Text('Call ${c.parentPhone}'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showResolutionModal(c),
                icon: const Icon(Icons.rate_review_rounded, size: 14),
                label: Text(isResolved ? 'View & Edit Remarks' : 'Respond & Take Action'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isResolved ? Colors.white : const Color(0xFF10B981),
                  foregroundColor: isResolved ? const Color(0xFF1E293B) : Colors.white,
                  side: isResolved ? const BorderSide(color: Color(0xFFCBD5E1)) : null,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
