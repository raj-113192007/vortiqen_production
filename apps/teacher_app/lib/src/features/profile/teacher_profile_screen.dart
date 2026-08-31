import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class TeacherDocItem {
  final String id;
  final String title;
  final String category;
  final String fileType; // PDF, JPG, PNG
  final String fileSize;
  final String uploadedOn;
  String status; // 'VERIFIED', 'PENDING', 'REJECTED'
  final String docNumber;

  TeacherDocItem({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.fileSize,
    required this.uploadedOn,
    required this.status,
    required this.docNumber,
  });
}

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showAadhaarNumber = false;
  bool _showPanNumber = false;
  bool _showBankNumber = false;

  late List<TeacherDocItem> _documents;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _documents = [
      TeacherDocItem(
        id: 'doc_1',
        title: 'Aadhaar Card (UIDAI Verified)',
        category: 'Identity Proof',
        fileType: 'PDF',
        fileSize: '1.4 MB',
        uploadedOn: '14 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'XXXX-XXXX-8921',
      ),
      TeacherDocItem(
        id: 'doc_2',
        title: 'PAN Card (Income Tax Dept)',
        category: 'Statutory & Tax',
        fileType: 'JPG',
        fileSize: '840 KB',
        uploadedOn: '14 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'ABCDE1234F',
      ),
      TeacherDocItem(
        id: 'doc_3',
        title: 'M.Sc. Physics Degree & Marksheet',
        category: 'Educational Qualification',
        fileType: 'PDF',
        fileSize: '2.8 MB',
        uploadedOn: '15 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'DU-DEG-2018-849',
      ),
      TeacherDocItem(
        id: 'doc_4',
        title: 'Bachelor of Education (B.Ed) Certificate',
        category: 'Teaching Qualification',
        fileType: 'PDF',
        fileSize: '1.9 MB',
        uploadedOn: '15 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'BED-JMI-2020-112',
      ),
      TeacherDocItem(
        id: 'doc_5',
        title: 'CTET Paper-II Eligibility Certificate',
        category: 'Competitive Certification',
        fileType: 'PDF',
        fileSize: '1.1 MB',
        uploadedOn: '18 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'CTET-CBSE-993821',
      ),
      TeacherDocItem(
        id: 'doc_6',
        title: 'Previous School Relieving & Experience Letter',
        category: 'Experience Record',
        fileType: 'PDF',
        fileSize: '3.2 MB',
        uploadedOn: '20 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'DPS-EXP-2021-04',
      ),
      TeacherDocItem(
        id: 'doc_7',
        title: 'Signed Appointment Letter & Service Agreement',
        category: 'Employment Contract',
        fileType: 'PDF',
        fileSize: '4.1 MB',
        uploadedOn: '22 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'VORTIQEN-APPT-2021-89',
      ),
      TeacherDocItem(
        id: 'doc_8',
        title: 'Cancelled Cheque / Bank Passbook Copy',
        category: 'Salary & Banking',
        fileType: 'PNG',
        fileSize: '950 KB',
        uploadedOn: '25 Jul 2021',
        status: 'VERIFIED',
        docNumber: 'HDFC-CHQ-4821',
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showUploadDocumentModal() {
    final titleController = TextEditingController();
    final docNumberController = TextEditingController();
    String selectedCategory = 'Educational Qualification';
    String fileType = 'PDF';

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
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.upload_file_rounded, color: Color(0xFF10B981), size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Upload KYC Document / Certificate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
              ),
            ],
          ),
          content: SizedBox(
            width: 460,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Document Category:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
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
                        value: selectedCategory,
                        isExpanded: true,
                        items: [
                          'Educational Qualification',
                          'Teaching Qualification (B.Ed/CTET)',
                          'Identity Proof (Aadhaar/Passport)',
                          'Statutory (PAN Card/Form 16)',
                          'Experience / Relieving Letter',
                          'Medical & Police Verification',
                          'Banking & Salary Proof',
                        ].map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (v) {
                          if (v != null) setModalState(() => selectedCategory = v);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Document Title (e.g. Master\'s Degree / Aadhaar)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: docNumberController,
                    decoration: InputDecoration(
                      labelText: 'Document / Registration Number (Optional)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // File upload box simulation
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF94A3B8), style: BorderStyle.solid),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.cloud_upload_outlined, size: 36, color: Color(0xFF6C5CE7)),
                        const SizedBox(height: 8),
                        const Text('Choose PDF, JPG or PNG file (Max 10 MB)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B))),
                        const SizedBox(height: 4),
                        const Text('Selected File: teacher_credential_scan.pdf (1.8 MB)', style: TextStyle(fontSize: 11, color: Color(0xFF10B981), fontWeight: FontWeight.w600)),
                      ],
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
                if (titleController.text.trim().isEmpty) return;

                setState(() {
                  _documents.insert(
                    0,
                    TeacherDocItem(
                      id: 'doc_${DateTime.now().millisecondsSinceEpoch}',
                      title: titleController.text.trim(),
                      category: selectedCategory,
                      fileType: fileType,
                      fileSize: '1.8 MB',
                      uploadedOn: DateFormat('dd MMM yyyy').format(DateTime.now()),
                      status: 'PENDING',
                      docNumber: docNumberController.text.trim().isNotEmpty ? docNumberController.text.trim() : 'DOC-${DateTime.now().millisecond}',
                    ),
                  );
                });

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Document "${titleController.text}" uploaded successfully! Sent to School Admin for verification. 📄'),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text('Upload & Submit to Admin'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Faculty Profile & Identity Dossier',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          ElevatedButton.icon(
            onPressed: _showUploadDocumentModal,
            icon: const Icon(Icons.upload_file_rounded, size: 16),
            label: const Text('Upload KYC Document'),
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
            // 1. TOP TEACHER IDENTITY HUD CARD
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: _buildTeacherHeroCard(),
            ),
            const SizedBox(height: 20),

            // 2. TAB SELECTOR BAR
            FadeSlideEntry(
              delay: const Duration(milliseconds: 80),
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
                  labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  tabs: const [
                    Tab(icon: Icon(Icons.badge_rounded, size: 18), text: 'Personal & Identity'),
                    Tab(icon: Icon(Icons.school_rounded, size: 18), text: 'Academics & Teaching'),
                    Tab(icon: Icon(Icons.folder_shared_rounded, size: 18), text: 'KYC Document Vault'),
                    Tab(icon: Icon(Icons.account_balance_wallet_rounded, size: 18), text: 'Banking & Payroll'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 3. TAB CONTENT
            FadeSlideEntry(
              delay: const Duration(milliseconds: 140),
              child: SizedBox(
                height: 720,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPersonalTab(),
                    _buildAcademicsTab(),
                    _buildDocumentsTab(),
                    _buildBankingTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Top Identity Hero Card
  Widget _buildTeacherHeroCard() {
    return Container(
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: const Text('PS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                      child: const Icon(Icons.verified_rounded, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Prof. Rajesh Sharma',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.4)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 12),
                              SizedBox(width: 4),
                              Text('KYC Verified Staff', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Senior PGT Physics Faculty • HOD Science Department • Class Teacher (10-A)',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        _buildHeroTag(Icons.badge_outlined, 'Employee ID: EMP-2024-089'),
                        _buildHeroTag(Icons.calendar_today_rounded, 'Joined: 15 July 2021 (5 Years)'),
                        _buildHeroTag(Icons.bloodtype_outlined, 'Blood Group: O+ve'),
                        _buildHeroTag(Icons.room_rounded, 'Staff Room: Desk 4 (Block B)'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroTag(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF38BDF8)),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // TAB 1: PERSONAL & IDENTITY VAULT
  Widget _buildPersonalTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardSection(
            title: 'Government Identity Proofs (Aadhaar & PAN)',
            icon: Icons.shield_rounded,
            badge: 'Verified with Admin Records',
            child: Column(
              children: [
                _buildSensitveDataRow(
                  label: 'Aadhaar Card Number',
                  value: _showAadhaarNumber ? '5829 4812 8921' : 'XXXX-XXXX-8921',
                  isVisible: _showAadhaarNumber,
                  onToggle: () => setState(() => _showAadhaarNumber = !_showAadhaarNumber),
                  verified: true,
                  issuer: 'UIDAI Govt. of India',
                ),
                const Divider(height: 20),
                _buildSensitveDataRow(
                  label: 'Permanent Account Number (PAN)',
                  value: _showPanNumber ? 'ABCDE1234F' : 'XXXXX1234F',
                  isVisible: _showPanNumber,
                  onToggle: () => setState(() => _showPanNumber = !_showPanNumber),
                  verified: true,
                  issuer: 'Income Tax Department of India',
                ),
                const Divider(height: 20),
                _buildSensitveDataRow(
                  label: 'Teacher Registration (TRN)',
                  value: 'TRN-DEL-984210',
                  isVisible: true,
                  onToggle: null,
                  verified: true,
                  issuer: 'Directorate of Education, Delhi',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _buildCardSection(
            title: 'Contact & Residential Information',
            icon: Icons.contact_mail_rounded,
            child: Column(
              children: [
                _buildInfoGrid([
                  {'label': 'Official Email', 'value': 'rajesh.sharma@vortiqen.edu', 'icon': Icons.email_outlined},
                  {'label': 'Registered Mobile Phone', 'value': '+91 98765 43210', 'icon': Icons.phone_android_rounded},
                  {'label': 'Emergency Contact Person', 'value': 'Mrs. Sunita Sharma (Spouse) - +91 98112 88492', 'icon': Icons.emergency_rounded},
                  {'label': 'Date of Birth & Gender', 'value': '14 August 1988 (38 Years) • Male', 'icon': Icons.cake_outlined},
                  {'label': 'Permanent Home Address', 'value': 'B-402, Greenfield Heights, Sector 62, Noida, UP - 201309', 'icon': Icons.home_outlined},
                  {'label': 'Current Residential City', 'value': 'Delhi NCR (Near School Campus)', 'icon': Icons.location_city_rounded},
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 2: ACADEMICS & TEACHING ALLOCATIONS
  Widget _buildAcademicsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardSection(
            title: 'Academic Degrees & Professional Qualifications',
            icon: Icons.school_rounded,
            badge: 'Verified Credentials',
            child: Column(
              children: [
                _buildQualificationItem('Master of Science (M.Sc. Physics)', 'Delhi University • Gold Medalist', '2016 - 2018', '84.5% Distinction'),
                const Divider(height: 18),
                _buildQualificationItem('Bachelor of Education (B.Ed)', 'Jamia Millia Islamia • Pedagogy of Science', '2018 - 2020', '88.2% First Class'),
                const Divider(height: 18),
                _buildQualificationItem('Bachelor of Science (B.Sc. Hons Physics)', 'Hansraj College, University of Delhi', '2013 - 2016', '81.0% First Class'),
                const Divider(height: 18),
                _buildQualificationItem('Central Teacher Eligibility Test (CTET Paper II)', 'CBSE • Qualified for High School & Senior Sec', '2020', 'Score: 128/150'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _buildCardSection(
            title: 'Teaching Allocations & Weekly Workload',
            icon: Icons.calendar_view_week_rounded,
            badge: '22 Total Periods / Week',
            child: Column(
              children: [
                _buildAllocationRow('Class 10-A', 'Physics Theory & Numerical Solving', '6 Periods/Week', 'Room 204 (Class Teacher)'),
                const Divider(height: 14),
                _buildAllocationRow('Class 10-A Practical', 'Physics Laboratory Experiments', '2 Periods/Week', 'Physics Lab Block B'),
                const Divider(height: 14),
                _buildAllocationRow('Class 9-B', 'Mathematics & Algebra', '6 Periods/Week', 'Room 108'),
                const Divider(height: 14),
                _buildAllocationRow('Class 11-A', 'Applied Mechanics & Thermodynamics', '8 Periods/Week', 'Room 302'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 3: KYC DOCUMENT VAULT
  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Official Documents & KYC Repository',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
              ),
              ElevatedButton.icon(
                onPressed: _showUploadDocumentModal,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('+ Upload Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _documents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final doc = _documents[index];
              return _buildDocumentCard(doc);
            },
          ),
        ],
      ),
    );
  }

  // TAB 4: BANKING & PAYROLL VAULT
  Widget _buildBankingTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardSection(
            title: 'Salary Bank Account & Direct Deposit',
            icon: Icons.account_balance_rounded,
            badge: 'Active for Direct Credit',
            child: Column(
              children: [
                _buildSensitveDataRow(
                  label: 'Salary Bank Account Number',
                  value: _showBankNumber ? '50100482910482' : 'XXXXXXXXXX4821',
                  isVisible: _showBankNumber,
                  onToggle: () => setState(() => _showBankNumber = !_showBankNumber),
                  verified: true,
                  issuer: 'HDFC Bank Ltd • Sector 62 Branch',
                ),
                const Divider(height: 20),
                _buildInfoGrid([
                  {'label': 'Bank Name', 'value': 'HDFC Bank Limited', 'icon': Icons.account_balance_rounded},
                  {'label': 'IFSC Code', 'value': 'HDFC0001234', 'icon': Icons.numbers_rounded},
                  {'label': 'Account Holder Name', 'value': 'Rajesh Sharma', 'icon': Icons.person_outline_rounded},
                  {'label': 'Account Type', 'value': 'Corporate Salary Account', 'icon': Icons.savings_outlined},
                ]),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _buildCardSection(
            title: 'Statutory Provident Fund & Tax Deductions',
            icon: Icons.receipt_long_rounded,
            child: Column(
              children: [
                _buildInfoGrid([
                  {'label': 'Universal Account Number (UAN)', 'value': '101489201948', 'icon': Icons.badge_outlined},
                  {'label': 'Provident Fund (PF) Member ID', 'value': 'DL/CPM/84920/104', 'icon': Icons.security_rounded},
                  {'label': 'Income Tax Regime', 'value': 'New Tax Regime (Section 115BAC)', 'icon': Icons.receipt_outlined},
                  {'label': 'Gratuity Nomination Status', 'value': 'Nominated (100% to Spouse)', 'icon': Icons.family_restroom_rounded},
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HELPERS
  Widget _buildCardSection({required String title, required IconData icon, String? badge, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    child: Icon(icon, color: const Color(0xFF10B981), size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                ],
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(badge, style: const TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w800)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildSensitveDataRow({
    required String label,
    required String value,
    required bool isVisible,
    VoidCallback? onToggle,
    required bool verified,
    required String issuer,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  if (verified) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.verified_rounded, color: Color(0xFF10B981), size: 14),
                    const SizedBox(width: 4),
                    const Text('Verified', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w800)),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: 0.5),
              ),
              const SizedBox(height: 2),
              Text(issuer, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
        ),
        if (onToggle != null)
          IconButton(
            onPressed: onToggle,
            icon: Icon(isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF64748B), size: 20),
            tooltip: isVisible ? 'Hide Number' : 'Reveal Number',
          ),
      ],
    );
  }

  Widget _buildInfoGrid(List<Map<String, dynamic>> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth < 600 ? 1 : 2;
        return GridView.count(
          crossAxisCount: crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: crossCount == 1 ? 4.5 : 3.6,
          crossAxisSpacing: 14,
          mainAxisSpacing: 12,
          children: items.map((it) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
                  child: Icon(it['icon'] as IconData, size: 16, color: const Color(0xFF64748B)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(it['label'] as String, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(
                        it['value'] as String,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildQualificationItem(String title, String institute, String duration, String score) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.school_outlined, color: Color(0xFF6C5CE7), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Color(0xFF1E293B))),
              const SizedBox(height: 2),
              Text(institute, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
              child: Text(score, style: const TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 2),
            Text(duration, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
          ],
        ),
      ],
    );
  }

  Widget _buildAllocationRow(String classTitle, String subject, String periods, String room) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(classTitle, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Color(0xFF10B981))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
              Text(room, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
        ),
        Text(periods, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
      ],
    );
  }

  Widget _buildDocumentCard(TeacherDocItem doc) {
    final isVerified = doc.status == 'VERIFIED';
    final Color statusColor = isVerified ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: doc.fileType == 'PDF' ? const Color(0xFFEF4444).withValues(alpha: 0.1) : const Color(0xFF0984E3).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              doc.fileType == 'PDF' ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
              color: doc.fileType == 'PDF' ? const Color(0xFFEF4444) : const Color(0xFF0984E3),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(doc.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(isVerified ? Icons.check_circle_rounded : Icons.pending_rounded, size: 10, color: statusColor),
                          const SizedBox(width: 3),
                          Text(doc.status, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: statusColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '${doc.category} • Ref: ${doc.docNumber} • ${doc.fileSize} • Uploaded: ${doc.uploadedOn}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening secure viewer for "${doc.title}"... 📑')),
              );
            },
            icon: const Icon(Icons.visibility_rounded, size: 14),
            label: const Text('View Document'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
