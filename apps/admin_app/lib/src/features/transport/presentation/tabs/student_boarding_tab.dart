import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../../domain/transport_models.dart';

class StudentBoardingTab extends StatefulWidget {
  final List<VehicleFleetInfo> fleet;

  const StudentBoardingTab({
    super.key,
    required this.fleet,
  });

  @override
  State<StudentBoardingTab> createState() => _StudentBoardingTabState();
}

class _StudentBoardingTabState extends State<StudentBoardingTab> {
  String _selectedFilter = 'ALL'; // 'ALL', 'BOARDED', 'ABSENT'
  String _selectedBusId = 'ALL';

  @override
  Widget build(BuildContext context) {
    List<StudentPassenger> students = [];
    if (_selectedBusId == 'ALL') {
      students = widget.fleet.expand((v) => v.studentsOnboard).toList();
    } else {
      final bus = widget.fleet.firstWhere((v) => v.id == _selectedBusId, orElse: () => widget.fleet.first);
      students = bus.studentsOnboard;
    }

    if (_selectedFilter == 'BOARDED') {
      students = students.where((s) => s.isBoarded).toList();
    } else if (_selectedFilter == 'ABSENT') {
      students = students.where((s) => !s.isBoarded).toList();
    }

    final totalBoarded = students.where((s) => s.isBoarded).length;
    final totalAbsent = students.where((s) => !s.isBoarded).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter & Controls Header
        FadeSlideEntry(
          duration: const Duration(milliseconds: 350),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                // Status Filter Chips with semantic dots
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterChip('All (${students.length})', 'ALL'),
                    const SizedBox(width: 6),
                    _buildFilterChip('Boarded ($totalBoarded)', 'BOARDED', dotColor: const Color(0xFF10B981)),
                    const SizedBox(width: 6),
                    _buildFilterChip('Absent ($totalAbsent)', 'ABSENT', dotColor: const Color(0xFFEF4444)),
                  ],
                ),

                // Bus Selector
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Route: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedBusId,
                          isDense: true,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                          items: [
                            const DropdownMenuItem(value: 'ALL', child: Text('All Fleet Routes')),
                            for (var v in widget.fleet)
                              DropdownMenuItem(value: v.id, child: Text(v.busNumber)),
                          ],
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedBusId = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Students Manifest List
        if (students.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('No students found for this filter.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ),
          )
        else
          FadeSlideEntry(
            delay: const Duration(milliseconds: 100),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final s = students[index];
                final isBoarded = s.isBoarded;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: HoverLiftCard(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    borderRadius: 12,
                    hoverBorderColor: isBoarded ? const Color(0xFF10B981).withValues(alpha: 0.35) : const Color(0xFFEF4444).withValues(alpha: 0.35),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: isBoarded ? const Color(0xFF10B981).withValues(alpha: 0.1) : const Color(0xFFEF4444).withValues(alpha: 0.1),
                          child: Text(
                            s.name[0],
                            style: TextStyle(
                              color: isBoarded ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    s.name,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1E293B)),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      s.studentClass,
                                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Stop: ${s.stop} • Boarded: ${s.boardedTime} • Parent: ${s.parent}',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isBoarded ? const Color(0xFF10B981).withValues(alpha: 0.1) : const Color(0xFFEF4444).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: isBoarded ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                s.status,
                                style: TextStyle(
                                  color: isBoarded ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF25D366), size: 16),
                          tooltip: 'Send Parent Alert',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('WhatsApp notification dispatched to ${s.parent} (${s.phone})'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value, {Color? dotColor}) {
    final isSelected = _selectedFilter == value;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = value),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null && !isSelected) ...[
              Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
