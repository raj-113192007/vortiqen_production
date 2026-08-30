import 'package:flutter/material.dart';
import '../../domain/student_models.dart';

class StudentTableRow extends StatelessWidget {
  final StudentFullProfile student;
  final VoidCallback onOpenDossier;

  const StudentTableRow({
    super.key,
    required this.student,
    required this.onOpenDossier,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = student.isFeePaid;

    return InkWell(
      onTap: onOpenDossier,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Student & GR-Number (NO Admission date here!)
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    child: Text(
                      student.name[0],
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
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
                          student.grNo,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Class & Roll
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${student.className} - ${student.section}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Roll #${student.rollNo}',
                    style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),

            // Parent & Contact
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.fatherName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF1E293B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          student.parentPhone,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 15, color: Color(0xFF25D366)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Message Parent',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('WhatsApp notification dispatched to ${student.fatherName} (${student.parentPhone})'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Attendance
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${student.attendancePct}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      color: Color(0xFF047857),
                    ),
                  ),
                  const SizedBox(height: 3),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: SizedBox(
                      height: 4,
                      width: 70,
                      child: LinearProgressIndicator(
                        value: student.attendancePct / 100,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF10B981)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fee Status
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isPaid ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isPaid ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isPaid ? 'PAID' : 'DUE ₹${student.feeDueAmount.toInt()}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isPaid ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Dossier Action
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.open_in_new_rounded, size: 15, color: Color(0xFF4F46E5)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onOpenDossier,
                  tooltip: 'View 360° Dossier',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
