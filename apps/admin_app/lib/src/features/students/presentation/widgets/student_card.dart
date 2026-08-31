import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../../domain/student_models.dart';

class StudentCard extends StatelessWidget {
  final StudentFullProfile student;
  final VoidCallback onOpenDossier;

  const StudentCard({
    super.key,
    required this.student,
    required this.onOpenDossier,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = student.isFeePaid;

    return HoverLiftCard(
      onTap: onOpenDossier,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header: Avatar, Name, GR, Class badge
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: student.avatarUrl != null && student.avatarUrl!.isNotEmpty
                      ? Image.network(
                          student.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildFallbackInitial(),
                        )
                      : _buildFallbackInitial(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${student.className} - ${student.section} • ${student.grNo}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPaid ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isPaid)
                      const PulsingLiveDot(size: 4, pulseScale: 2.2, color: Color(0xFF10B981))
                    else
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text(
                      isPaid ? 'PAID' : 'DUE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isPaid ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Metadata Grid: Attendance, Parent Phone, Roll No
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ATTENDANCE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 1),
                    Text('${student.attendancePct}% (${student.presentDays}d)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ROLL NO', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 1),
                    Text('Roll #${student.rollNo}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PARENT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 1),
                    Text(student.fatherName.split(' ')[0], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 32,
            child: ElevatedButton.icon(
              onPressed: onOpenDossier,
              icon: const Icon(Icons.open_in_new_rounded, size: 13),
              label: const Text('View 360° Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.08),
                foregroundColor: const Color(0xFF4F46E5),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackInitial() {
    return Center(
      child: Text(
        student.name[0],
        style: const TextStyle(
          color: Color(0xFF4F46E5),
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),
    );
  }
}
