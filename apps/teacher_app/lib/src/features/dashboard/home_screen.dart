import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value?.user;
    final today = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF4FDF9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vibrant Header
            VibrantHeader(
              role: AppRole.teacher,
              title: 'Teacher Workspace',
              subtitle: 'Today is $today',
              userName: user?.name ?? 'Teacher',
            ),

            const SizedBox(height: 24),

            // Top Animated Stat Cards
            Row(
              children: [
                Expanded(
                  child: AnimatedCard(
                    borderColor: const Color(0xFF00B894).withOpacity(0.3),
                    backgroundColor: Colors.white,
                    onTap: () => context.go('/mark-attendance'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00B894).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF00B894), size: 22),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00B894).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Pending', style: TextStyle(color: Color(0xFF00B894), fontWeight: FontWeight.bold, fontSize: 11)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Class Attendance',
                          style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mark for Today',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AnimatedCard(
                    borderColor: const Color(0xFF0984E3).withOpacity(0.3),
                    backgroundColor: Colors.white,
                    onTap: () => context.go('/assignments'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0984E3).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.assignment_outlined, color: Color(0xFF0984E3), size: 22),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0984E3).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('4 Active', style: TextStyle(color: Color(0xFF0984E3), fontWeight: FontWeight.bold, fontSize: 11)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Assignments',
                          style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Review Submissions',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Today's Timetable / Classes
            Text(
              "Today's Schedule",
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 14),

            _buildScheduleItem('Period 1', 'Mathematics', 'Class 10-A (Room 204)', '08:30 AM - 09:15 AM', const Color(0xFF00B894)),
            const SizedBox(height: 10),
            _buildScheduleItem('Period 3', 'Algebra & Geometry', 'Class 9-B (Room 108)', '10:15 AM - 11:00 AM', const Color(0xFF0984E3)),
            const SizedBox(height: 10),
            _buildScheduleItem('Period 5', 'Science Lab', 'Class 10-B (Physics Lab)', '12:30 PM - 01:15 PM', const Color(0xFFE84393)),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String period, String subject, String location, String timing, Color accentColor) {
    return AnimatedCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              period,
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B))),
                const SizedBox(height: 2),
                Text(location, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
              ],
            ),
          ),
          Text(timing, style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}
