import 'package:flutter/material.dart';
import '../../domain/student_models.dart';

class Student360Modal extends StatefulWidget {
  final StudentFullProfile student;

  const Student360Modal({
    super.key,
    required this.student,
  });

  @override
  State<Student360Modal> createState() => _Student360ModalState();
}

class _Student360ModalState extends State<Student360Modal> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 960;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: isDesktop ? 900 : size.width * 0.95,
        constraints: BoxConstraints(maxHeight: size.height * 0.85),
        child: Column(
          children: [
            // Top Header
            _buildTopHeader(s),

            // Tab Bar
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E8F0)),
                  bottom: BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: const Color(0xFF4F46E5),
                indicatorWeight: 2.5,
                labelColor: const Color(0xFF4F46E5),
                unselectedLabelColor: const Color(0xFF64748B),
                labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                tabs: const [
                  Tab(icon: Icon(Icons.badge_outlined, size: 16), text: 'Admission & Bio'),
                  Tab(icon: Icon(Icons.family_restroom_outlined, size: 16), text: 'Parents & Contact'),
                  Tab(icon: Icon(Icons.receipt_long_outlined, size: 16), text: 'Fees Ledger'),
                  Tab(icon: Icon(Icons.assessment_outlined, size: 16), text: 'Marksheet & Grades'),
                  Tab(icon: Icon(Icons.verified_user_outlined, size: 16), text: 'KYC & Transport'),
                ],
              ),
            ),

            // Tab View Contents
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAdmissionTab(s),
                  _buildParentsTab(s),
                  _buildFeesTab(s),
                  _buildAcademicsTab(s),
                  _buildKycTab(s),
                ],
              ),
            ),

            // Footer Actions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exporting complete scholar dossier for ${s.name}...')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 15),
                    label: const Text('Export Dossier PDF'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader(StudentFullProfile s) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(26),
              ),
              child: s.avatarUrl != null && s.avatarUrl!.isNotEmpty
                  ? Image.network(
                      s.avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildFallbackInitial(s),
                    )
                  : _buildFallbackInitial(s),
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
                      s.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${s.className} - ${s.section}',
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Roll #${s.rollNo}',
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'GR Number: ${s.grNo} • Class Teacher: ${s.classTeacher} • House: ${s.house}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackInitial(StudentFullProfile s) {
    return Center(
      child: Text(
        s.name[0],
        style: const TextStyle(
          color: Color(0xFF4F46E5),
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
    );
  }

  // --- TAB 1: ADMISSION & BIO (Includes the Admission Date!) ---
  Widget _buildAdmissionTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Academic Enrolment & School Metadata', Icons.school_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Admission Date', 'val': s.admissionDate, 'icon': Icons.calendar_today_outlined},
            {'label': 'General Register (GR)', 'val': s.grNo, 'icon': Icons.receipt_outlined},
            {'label': 'Current Grade & Section', 'val': '${s.className} (Section ${s.section})', 'icon': Icons.class_outlined},
            {'label': 'Class Teacher', 'val': s.classTeacher, 'icon': Icons.person_outline_rounded},
            {'label': 'Assigned House', 'val': s.house, 'icon': Icons.flag_outlined},
            {'label': 'Student Category', 'val': s.category, 'icon': Icons.category_outlined},
          ]),
          const SizedBox(height: 18),

          _buildSectionTitle('Personal & Biological Details', Icons.badge_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Date of Birth', 'val': s.dob, 'icon': Icons.cake_outlined},
            {'label': 'Gender', 'val': s.gender, 'icon': Icons.person_outline},
            {'label': 'Blood Group', 'val': s.bloodGroup, 'icon': Icons.water_drop_outlined},
            {'label': 'Attendance Record', 'val': '${s.attendancePct}% (${s.presentDays}/${s.totalDays} Days)', 'icon': Icons.how_to_reg_outlined},
          ]),
        ],
      ),
    );
  }

  // --- TAB 2: PARENTS & CONTACT ---
  Widget _buildParentsTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Parents & Family Background', Icons.family_restroom_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Father\'s Name', 'val': s.fatherName, 'icon': Icons.person_outline},
            {'label': 'Father\'s Occupation', 'val': s.fatherOccupation, 'icon': Icons.work_outline},
            {'label': 'Mother\'s Name', 'val': s.motherName, 'icon': Icons.person_outline},
            {'label': 'Mother\'s Occupation', 'val': s.motherOccupation, 'icon': Icons.work_outline},
          ]),
          const SizedBox(height: 18),

          _buildSectionTitle('Emergency Contacts & Address', Icons.contact_phone_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Primary Parent Phone', 'val': s.parentPhone, 'icon': Icons.phone_outlined},
            {'label': 'Parent Email Address', 'val': s.parentEmail, 'icon': Icons.email_outlined},
            {'label': 'Emergency SOS Phone', 'val': s.emergencyPhone, 'icon': Icons.phone_in_talk_outlined},
            {'label': 'Residential Address', 'val': s.residentialAddress, 'icon': Icons.home_outlined},
          ]),
        ],
      ),
    );
  }

  // --- TAB 3: FEES LEDGER ---
  Widget _buildFeesTab(StudentFullProfile s) {
    final isPaid = s.isFeePaid;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  'Annual Tuition Fee',
                  '₹ ${s.annualFee.toInt()}',
                  'Total Assigned',
                  Icons.account_balance_wallet_outlined,
                  const Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  'Fee Paid Amount',
                  '₹ ${s.feePaidAmount.toInt()}',
                  'Cleared',
                  Icons.check_circle_outline_rounded,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  'Fee Balance Due',
                  '₹ ${s.feeDueAmount.toInt()}',
                  isPaid ? 'All Cleared' : s.nextDueDate,
                  Icons.pending_actions_outlined,
                  isPaid ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          _buildSectionTitle('Fee Payment Receipts & Ledger', Icons.receipt_long_outlined),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: s.feeHistory.length,
            itemBuilder: (context, index) {
              final item = s.feeHistory[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B))),
                        Text('Paid on ${item.date} • Ref: ${item.ref}', style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      ],
                    ),
                    Text(
                      item.amount,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF047857)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- TAB 4: MARK SHEET & ACADEMICS ---
  Widget _buildAcademicsTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  'Overall Percentage',
                  '${s.overallPercentage}%',
                  'Academic Aggregate',
                  Icons.trending_up_rounded,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  'Class Standing',
                  s.classRank,
                  'Current Term',
                  Icons.star_outline_rounded,
                  const Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          _buildSectionTitle('Subject-wise Performance & Marksheet', Icons.assessment_outlined),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 4, child: Text('SUBJECT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                      Expanded(flex: 2, child: Text('SCORE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                      Expanded(flex: 2, child: Text('GRADE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                      Expanded(flex: 3, child: Text('FACULTY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B)))),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: s.subjectMarks.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  itemBuilder: (context, index) {
                    final mark = s.subjectMarks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(flex: 4, child: Text(mark.subject, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xFF1E293B)))),
                          Expanded(flex: 2, child: Text('${mark.marks}/${mark.maxMarks}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: Color(0xFF047857)))),
                          Expanded(flex: 2, child: Text(mark.grade, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: Color(0xFF4F46E5)))),
                          Expanded(flex: 3, child: Text(mark.teacher, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)))),
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

  // --- TAB 5: KYC & TRANSPORT ---
  Widget _buildKycTab(StudentFullProfile s) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Identity & Aadhaar Verification Vault', Icons.verified_user_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Aadhaar Number', 'val': s.aadhaarNumber, 'icon': Icons.credit_card_outlined},
            {'label': 'Verification Status', 'val': s.aadhaarVerified ? 'Verified Active' : 'Pending', 'icon': Icons.check_circle_outline_rounded},
          ]),
          const SizedBox(height: 18),

          _buildSectionTitle('Transport & Daily Commute Route', Icons.directions_bus_outlined),
          const SizedBox(height: 10),
          _buildInfoGrid([
            {'label': 'Assigned Fleet Corridor', 'val': s.busRoute, 'icon': Icons.alt_route_outlined},
            {'label': 'Boarding Stop & Bus Plate', 'val': s.busStop, 'icon': Icons.pin_drop_outlined},
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF4F46E5)),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(List<Map<String, dynamic>> items) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
        childAspectRatio: 3.5,
        children: items.map((item) {
          return Row(
            children: [
              Icon(item['icon'] as IconData, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['label'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
                    Text(item['val'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMetricTile(String title, String mainVal, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                Text(mainVal, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
