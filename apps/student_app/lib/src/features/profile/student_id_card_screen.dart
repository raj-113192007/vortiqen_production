import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class StudentIdCardScreen extends ConsumerStatefulWidget {
  const StudentIdCardScreen({super.key});

  @override
  ConsumerState<StudentIdCardScreen> createState() => _StudentIdCardScreenState();
}

class _StudentIdCardScreenState extends ConsumerState<StudentIdCardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCardFlip() {
    if (_isFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Digital Student ID Card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing Digital ID Card Card... 📲')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1000,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Tap on the ID card to flip 🔄',
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),

              // Responsive Two-Pane Layout
              ResponsiveTwoPane(
                breakpoint: 800,
                leftFlex: 1,
                rightFlex: 1,
                spacing: 24,
                leftPane: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: GestureDetector(
                      onTap: _toggleCardFlip,
                      child: AnimatedBuilder(
                        animation: _flipAnimation,
                        builder: (context, child) {
                          final angle = _flipAnimation.value * pi;
                          final isUnder = _flipAnimation.value >= 0.5;

                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(angle),
                            alignment: Alignment.center,
                            child: isUnder
                                ? Transform(
                                    transform: Matrix4.identity()..rotateY(pi),
                                    alignment: Alignment.center,
                                    child: _buildBackCard(context, user),
                                  )
                                : _buildFrontCard(context, user),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                rightPane: Column(
                  children: [
                    // ID Card Actions
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _buildIdActionTile(
                            Icons.qr_code_2,
                            'Gate Entry QR Verification',
                            'Present at the school gate or library scanner for tapless entry.',
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('QR Code verified for Smart Gate Entry!')),
                              );
                            },
                          ),
                          const Divider(height: 20, color: Color(0xFFF1F5F9)),
                          _buildIdActionTile(
                            Icons.download_for_offline_outlined,
                            'Save Offline ID Badge',
                            'Store in Apple Wallet / Google Wallet pass for offline use.',
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('ID Card saved to offline wallet pass!')),
                              );
                            },
                          ),
                          const Divider(height: 20, color: Color(0xFFF1F5F9)),
                          _buildIdActionTile(
                            Icons.lock_reset,
                            'Report Lost RFID Card',
                            'Instantly block lost RFID chip to prevent unauthorized campus access.',
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Lost card report submitted to Security!')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard(BuildContext context, User? user) {
    return Container(
      width: double.infinity,
      height: 480,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0984E3), Color(0xFF1E293B)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0984E3).withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // School Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text('V', style: TextStyle(color: Color(0xFF0984E3), fontWeight: FontWeight.w900, fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VORTIQEN PUBLIC SCHOOL',
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                      ),
                      Text(
                        'Affiliated to CBSE • Code: 213098',
                        style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('STUDENT', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Student Photo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          Text(
            user?.name ?? 'Aarav Sharma',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.3),
          ),
          const SizedBox(height: 2),
          const Text(
            'Class 10th - Section A  •  Roll #24',
            style: TextStyle(color: Color(0xFF74B9FF), fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),

          // Metadata Grid
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _IdDetailCol('ADM NO', 'VQ-2024-891'),
                _IdDetailCol('BLOOD GRP', 'B +ve'),
                _IdDetailCol('VALID UPTO', 'MAR 2027'),
              ],
            ),
          ),
          const Spacer(),

          // Simulated Barcode
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code, color: Colors.black, size: 28),
                SizedBox(width: 8),
                Text('||| | | |||| | ||| || ||||', style: TextStyle(fontFamily: 'Courier', fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(BuildContext context, User? user) {
    return Container(
      width: double.infinity,
      height: 480,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'STUDENT INFORMATION & EMERGENCY CONTACT',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11, color: Color(0xFF0984E3), letterSpacing: 0.5),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 16),

          _buildBackRow('Father Name', 'Mr. Ramesh Sharma'),
          _buildBackRow('Mother Name', 'Mrs. Sunita Sharma'),
          _buildBackRow('Emergency Phone', '+91 98765 43210 / 98111 22334'),
          _buildBackRow('Residential Address', 'Flat 402, Sector 15 Heights, New Delhi'),
          _buildBackRow('Bus Route Allotted', 'Route #7 (North City Loop)'),
          const Spacer(),

          // Signature and Stamp
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VortiQen Security Chip', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  const Text('UID: 8941-X99-2026', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  const Text('Dr. S. K. Mukherjee', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 13)),
                  Container(width: 100, height: 1, color: Colors.black),
                  const Text('Principal Signature', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }

  Widget _buildIdActionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0984E3).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF0984E3), size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

class _IdDetailCol extends StatelessWidget {
  final String title;
  final String val;
  const _IdDetailCol(this.title, this.val);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 9, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
      ],
    );
  }
}
