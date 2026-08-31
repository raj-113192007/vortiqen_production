import 'package:flutter/material.dart';

class DataOnboardingHubScreen extends StatefulWidget {
  const DataOnboardingHubScreen({super.key});

  @override
  State<DataOnboardingHubScreen> createState() => _DataOnboardingHubScreenState();
}

class _DataOnboardingHubScreenState extends State<DataOnboardingHubScreen>
    with SingleTickerProviderStateMixin {
  int _activeTab = 0; // 0: Excel, 1: Parent WhatsApp, 2: Staff Invites, 3: Quick Add
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadStatusText;
  bool _isBroadcasting = false;
  bool _broadcastSent = false;

  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOutBack);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _simulateExcelUpload() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.1;
      _uploadStatusText = 'Parsing Excel sheets (Students, Classes, Routes)...';
    });

    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _uploadProgress = 0.45;
      _uploadStatusText = 'Validating 1,450 rows & checking duplicates...';
    });

    await Future.delayed(const Duration(milliseconds: 900));
    setState(() {
      _uploadProgress = 0.85;
      _uploadStatusText = 'Generating student IDs & allocating sections...';
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _uploadProgress = 1.0;
      _uploadStatusText = 'Success! 1,448 Students & 52 Staff imported cleanly.';
      _isUploading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF00B894),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Bulk Import Complete! 1,448 students created.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _simulateWhatsAppBroadcast() async {
    setState(() {
      _isBroadcasting = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() {
      _isBroadcasting = false;
      _broadcastSent = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF6C5CE7),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: const [
              Icon(Icons.mark_chat_read, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'WhatsApp verification link sent to 1,448 parents!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner with Vibrant Gradient & Animation
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_upload_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Onboarding & Migration Hub',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Effortlessly bring thousands of students, teachers, buses & staff into VortiQen in minutes.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B894),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Text(
                            '5-in-1 Engine',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Method Selector Tab Pills
            Row(
              children: [
                _buildTabPill(0, '1. Smart Excel / CSV', Icons.table_chart_rounded, const Color(0xFF00B894)),
                const SizedBox(width: 12),
                _buildTabPill(1, '2. Parent WhatsApp Link', Icons.chat_bubble_outline_rounded, const Color(0xFF25D366)),
                const SizedBox(width: 12),
                _buildTabPill(2, '3. Staff Direct Invites', Icons.send_rounded, const Color(0xFF0984E3)),
                const SizedBox(width: 12),
                _buildTabPill(3, '4. Quick Walk-in Entry', Icons.person_add_alt_1_rounded, const Color(0xFFE84393)),
              ],
            ),

            const SizedBox(height: 28),

            // Tab Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: _buildActiveTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPill(int index, String label, IconData icon, Color accentColor) {
    final isSelected = _activeTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _activeTab = index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? accentColor : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: accentColor.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? accentColor : Colors.grey[600], size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black87 : Colors.grey[700],
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildExcelImportSection();
      case 1:
        return _buildParentCrowdsourceSection();
      case 2:
        return _buildStaffInvitesSection();
      case 3:
        return _buildQuickAddSection();
      default:
        return const SizedBox.shrink();
    }
  }

  // 1. SMART EXCEL SECTION
  Widget _buildExcelImportSection() {
    return Container(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Step 1: Download Standard Template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Use our pre-formatted Excel template with auto-column matching.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
              Wrap(
                spacing: 12,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded, color: Color(0xFF00B894)),
                    label: const Text('Students Template.xlsx', style: TextStyle(color: Color(0xFF00B894))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00B894)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded, color: Color(0xFF0984E3)),
                    label: const Text('Staff & Buses Template.xlsx', style: TextStyle(color: Color(0xFF0984E3))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0984E3)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 20),

          const Text(
            'Step 2: Upload Filled Excel / CSV File',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Drop Zone Container
          InkWell(
            onTap: _isUploading ? null : _simulateExcelUpload,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF00B894).withOpacity(0.6), style: BorderStyle.solid, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B894).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.file_upload_outlined, size: 48, color: Color(0xFF00B894)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Click to Browse or Drag & Drop Excel Sheet Here',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3436)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Supports .xlsx, .xls, .csv files up to 50MB (up to 10,000 students at once)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (_isUploading || _uploadProgress > 0) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: _uploadProgress,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00B894)),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _uploadStatusText ?? '',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF00B894)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. PARENT CROWDSOURCING SECTION
  Widget _buildParentCrowdsourceSection() {
    return Container(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Parent WhatsApp Self-Verification Engine',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Let parents upload student passport photos, blood groups, and birth certificates themselves.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isBroadcasting ? null : _simulateWhatsAppBroadcast,
                icon: _isBroadcasting
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.send_rounded),
                label: Text(_isBroadcasting ? 'Broadcasting...' : 'Broadcast to All Parents'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 20),

          // Live Progress Tracker Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFF39C12).withOpacity(0.1), const Color(0xFFF1C40F).withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF39C12).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Live Parent Response Progress',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _broadcastSent ? '1,120 out of 1,448 parents have completed photo & profile verification.' : 'Broadcast link ready to send to 1,448 parents.',
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: _broadcastSent ? 0.77 : 0.0,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF25D366)),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        _broadcastSent ? '77%' : '0%',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF25D366)),
                      ),
                      const Text('Completed', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. STAFF DIRECT INVITES SECTION
  Widget _buildStaffInvitesSection() {
    return Container(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1-Click Teacher & Driver Invitation Engine',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Send instant login credentials and app download links to your teachers and bus drivers.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildInviteCard(
                  title: 'Teachers & Staff',
                  count: '48 Pending Invites',
                  icon: Icons.school,
                  color: const Color(0xFF00B894),
                  buttonLabel: 'Invite 48 Teachers',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildInviteCard(
                  title: 'Bus Drivers & Conductors',
                  count: '12 Pending Invites',
                  icon: Icons.directions_bus,
                  color: const Color(0xFFF39C12),
                  buttonLabel: 'Invite 12 Drivers',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInviteCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required String buttonLabel,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(count, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: color,
                    content: Text('Invites successfully dispatched for $title!'),
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded, size: 16),
              label: Text(buttonLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. QUICK WALK-IN ENTRY
  Widget _buildQuickAddSection() {
    return Container(
      key: const ValueKey(3),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Single Walk-in Admission',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Add a new student in 30 seconds for daily walk-in admissions.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Student Full Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Parent Mobile (WhatsApp)',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Class & Section',
                    prefixIcon: const Icon(Icons.class_),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: const [
                    DropdownMenuItem(value: '10-A', child: Text('Class 10 - Section A')),
                    DropdownMenuItem(value: '10-B', child: Text('Class 10 - Section B')),
                    DropdownMenuItem(value: '9-A', child: Text('Class 9 - Section A')),
                  ],
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Admission / Roll No',
                    prefixIcon: const Icon(Icons.badge),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color(0xFF6C5CE7),
                  content: Text('Student registered & Welcome SMS sent to parent!'),
                ),
              );
            },
            icon: const Icon(Icons.check),
            label: const Text('Save & Send Welcome Kit to Parent'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
