import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../../domain/staff_models.dart';

class TeacherCard extends StatelessWidget {
  final TeacherProfile teacher;
  final VoidCallback onOpenDossier;

  const TeacherCard({
    super.key,
    required this.teacher,
    required this.onOpenDossier,
  });

  @override
  Widget build(BuildContext context) {
    final isPresent = teacher.isPresentToday;

    return HoverLiftCard(
      onTap: onOpenDossier,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar (Photo), Name, Designation, Department Tag & Status Dot
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: teacher.avatarUrl != null && teacher.avatarUrl!.isNotEmpty
                      ? Image.network(
                          teacher.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildFallbackInitial(),
                        )
                      : _buildFallbackInitial(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          teacher.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            teacher.empId,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${teacher.designation} • ${teacher.department}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),

              // Status Indicator with Pulse & Rating
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPresent ? const Color(0xFF10B981).withValues(alpha: 0.1) : const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isPresent)
                          const PulsingLiveDot(size: 4.5, pulseScale: 2.2, color: Color(0xFF10B981))
                        else
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        const SizedBox(width: 5),
                        Text(
                          teacher.todayStatus,
                          style: TextStyle(
                            color: isPresent ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 2),
                      Text(
                        '${teacher.rating}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Metadata Grid: Class Teacher, Room, Subjects, Workload
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.school_outlined, size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Text(
                      'Class Teacher: ${teacher.classTeacherOf} (${teacher.roomNumber})',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.schedule_outlined, size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Text(
                      'Workload: ${teacher.weeklyPeriods} Periods/wk',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF4F46E5)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 15, color: Color(0xFF10B981)),
                    const SizedBox(width: 5),
                    Text(
                      'Attendance: ${teacher.attendancePct}%',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF047857)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Subjects Chips & Action Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: teacher.subjectsTaught.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Text(
                        '${s.subject} (${s.periods})',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: onOpenDossier,
                icon: const Icon(Icons.open_in_new_rounded, size: 13),
                label: const Text('Faculty 360'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                  foregroundColor: const Color(0xFF4F46E5),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackInitial() {
    return Center(
      child: Text(
        teacher.name.split(' ').length > 1
            ? '${teacher.name.split(' ')[0][0]}${teacher.name.split(' ')[1][0]}'
            : teacher.name[0],
        style: const TextStyle(
          color: Color(0xFF4F46E5),
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
    );
  }
}
