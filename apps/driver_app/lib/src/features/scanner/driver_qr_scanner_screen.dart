import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DriverQrScannerScreen extends StatefulWidget {
  const DriverQrScannerScreen({super.key});

  @override
  State<DriverQrScannerScreen> createState() => _DriverQrScannerScreenState();
}

class _DriverQrScannerScreenState extends State<DriverQrScannerScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _scannedStudent;

  final List<Map<String, dynamic>> _studentsManifest = [
    {
      'id': 'st_01',
      'name': 'Aarav Sharma',
      'rollNo': '1024',
      'class': 'Class 10-A',
      'stop': 'Palm Greens Gate 2',
      'parentPhone': '+91 98765 43210',
      'isBoarded': true,
      'boardedTime': '07:34 AM',
    },
    {
      'id': 'st_02',
      'name': 'Riya Kapoor',
      'rollNo': '1019',
      'class': 'Class 10-A',
      'stop': 'Sector 62 Metro Junction',
      'parentPhone': '+91 98111 22334',
      'isBoarded': true,
      'boardedTime': '07:22 AM',
    },
    {
      'id': 'st_03',
      'name': 'Vivaan Singhania',
      'rollNo': '1031',
      'class': 'Class 9-B',
      'stop': 'Palm Greens Gate 2',
      'parentPhone': '+91 97234 56789',
      'isBoarded': false,
      'boardedTime': null,
    },
    {
      'id': 'st_04',
      'name': 'Ananya Sharma',
      'rollNo': '618',
      'class': 'Class 6-B',
      'stop': 'Palm Greens Gate 2',
      'parentPhone': '+91 98765 43210',
      'isBoarded': true,
      'boardedTime': '07:34 AM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scannedStudent = _studentsManifest.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _boardedCount => _studentsManifest.where((s) => s['isBoarded'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBF7),
      appBar: AppBar(
        title: const Text('Student Boarding Scanner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: ResponsiveTwoPane(
            breakpoint: 860,
            leftFlex: 5,
            rightFlex: 6,
            leftPane: _buildScannerCameraPane(),
            rightPane: _buildStudentManifestPane(),
          ),
        ),
      ),
    );
  }

  Widget _buildScannerCameraPane() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Camera Viewport Simulation Card
        AnimatedCard(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF0F172A),
          child: Column(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Reticle
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF39C12), width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.qr_code_scanner, size: 60, color: Color(0xFFF39C12)),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Align Student ID Card QR in box', style: TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Simulated QR Code Detected! Reading card data...')),
                        );
                        setState(() => _scannedStudent = _studentsManifest[2]);
                      },
                      icon: const Icon(Icons.camera_alt, size: 16),
                      label: const Text('Simulate Scan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF39C12),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.flash_on, color: Colors.amber),
                    onPressed: () {},
                    tooltip: 'Toggle Flashlight',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Scanned Student Result Card
        if (_scannedStudent != null)
          AnimatedCard(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE2E8F0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFF39C12).withOpacity(0.2),
                      child: const Icon(Icons.person, color: Color(0xFFF39C12), size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_scannedStudent!['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Roll No: ${_scannedStudent!['rollNo']} • ${_scannedStudent!['class']}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Assigned Stop: ${_scannedStudent!['stop']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text('Parent Phone: ${_scannedStudent!['parentPhone']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final currentStatus = _scannedStudent!['isBoarded'] as bool;
                      setState(() {
                        _scannedStudent!['isBoarded'] = !currentStatus;
                        _scannedStudent!['boardedTime'] = !currentStatus ? '07:36 AM' : null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(!currentStatus ? 'Student Boarded! Instant parent push alert sent.' : 'Student marked Deboarded.'),
                          backgroundColor: const Color(0xFF10B981),
                        ),
                      );
                    },
                    icon: Icon(_scannedStudent!['isBoarded'] ? Icons.check_circle : Icons.login),
                    label: Text(_scannedStudent!['isBoarded'] ? 'Boarded at 07:34 AM (Tap to undo)' : 'Confirm Student Boarding'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _scannedStudent!['isBoarded'] ? const Color(0xFF10B981) : const Color(0xFFF39C12),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStudentManifestPane() {
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
              const Text('Route 14 Passenger Manifest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                child: Text('$_boardedCount / ${_studentsManifest.length} On Board', style: const TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _studentsManifest.length,
            separatorBuilder: (_, __) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final student = _studentsManifest[index];
              final isBoarded = student['isBoarded'] == true;

              return InkWell(
                onTap: () => setState(() => _scannedStudent = student),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: isBoarded ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                      child: Icon(
                        isBoarded ? Icons.check : Icons.close,
                        color: isBoarded ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('${student['class']} • Stop: ${student['stop']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    Text(
                      isBoarded ? 'Boarded (${student['boardedTime']})' : 'Pending',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isBoarded ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                      ),
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
}
