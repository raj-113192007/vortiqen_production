import 'package:flutter/material.dart';
import '../../domain/staff_models.dart';

class Teacher360Modal extends StatelessWidget {
  final TeacherProfile teacher;

  const Teacher360Modal({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 740,
        constraints: const BoxConstraints(maxHeight: 680),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          child: teacher.avatarUrl != null && teacher.avatarUrl!.isNotEmpty
                              ? Image.network(
                                  teacher.avatarUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
                                )
                              : _buildFallbackAvatar(),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                teacher.name,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                                child: Text(teacher.empId, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          Text(
                            '${teacher.designation} • ${teacher.department}',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 20),

              // Section 1: Academic & Professional Credentials
              _buildSectionTitle('Academic Qualifications & Experience', Icons.school_outlined),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildInfoItem('Qualifications', teacher.qualifications)),
                        Expanded(child: _buildInfoItem('Total Experience', teacher.experience)),
                      ],
                    ),
                    const Divider(height: 18),
                    Row(
                      children: [
                        Expanded(child: _buildInfoItem('Email', teacher.email)),
                        Expanded(child: _buildInfoItem('Contact Phone', teacher.phone)),
                        Expanded(child: _buildInfoItem('Blood Group', teacher.bloodGroup)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section 2: Teaching Allocations & Workload
              _buildSectionTitle('Class Allocations & Teaching Workload', Icons.menu_book_outlined),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildInfoItem('Class Teacher Of', '${teacher.classTeacherOf} (${teacher.roomNumber})')),
                        Expanded(child: _buildInfoItem('Weekly Workload', '${teacher.weeklyPeriods} Periods/week', isHighlight: true)),
                      ],
                    ),
                    const Divider(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: teacher.subjectsTaught.map((s) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline_rounded, size: 14, color: Color(0xFF10B981)),
                              const SizedBox(width: 6),
                              Text('${s.subject}: ', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                              Text('Taught in ${s.classes} (${s.periods})', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section 3: Payroll & Attendance Vault
              _buildSectionTitle('Payroll Status & Annual Attendance', Icons.payments_outlined),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Net Monthly Salary',
                      '₹ ${teacher.netSalary.toInt()}',
                      'Status: ${teacher.payrollStatus}',
                      Icons.account_balance_wallet_outlined,
                      const Color(0xFF0284C7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      'Annual Attendance',
                      '${teacher.attendancePct}%',
                      '${teacher.presentDays} / ${teacher.totalDays} Days Present',
                      Icons.verified_outlined,
                      const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Modal Footer Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Exporting complete service dossier for ${teacher.name}...')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 15),
                    label: const Text('Export Faculty Dossier'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Center(
      child: Text(
        teacher.name.split(' ').length > 1
            ? '${teacher.name.split(' ')[0][0]}${teacher.name.split(' ')[1][0]}'
            : teacher.name[0],
        style: const TextStyle(
          color: Color(0xFF4F46E5),
          fontWeight: FontWeight.w900,
          fontSize: 16,
        ),
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

  Widget _buildInfoItem(String label, String value, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isHighlight ? const Color(0xFF4F46E5) : const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String mainVal, String sub, IconData icon, Color color) {
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                Text(mainVal, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: color)),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
