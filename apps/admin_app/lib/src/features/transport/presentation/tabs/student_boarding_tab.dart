import 'package:flutter/material.dart';
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
    // Collect all students or filtered by bus
    List<StudentPassenger> students = [];
    if (_selectedBusId == 'ALL') {
      students = widget.fleet.expand((v) => v.studentsOnboard).toList();
    } else {
      final bus = widget.fleet.firstWhere((v) => v.id == _selectedBusId, orElse: () => widget.fleet.first);
      students = bus.studentsOnboard;
    }

    // Filter by Boarding Status
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              // Status Filter Chips
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFilterChip('All (${students.length})', 'ALL'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Boarded 🟢 ($totalBoarded)', 'BOARDED', activeColor: const Color(0xFF00B894)),
                  const SizedBox(width: 8),
                  _buildFilterChip('Absent 🔴 ($totalAbsent)', 'ABSENT', activeColor: const Color(0xFFD63031)),
                ],
              ),

              // Bus Selector
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filter Route: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedBusId,
                        isDense: true,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
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
        const SizedBox(height: 16),

        // Students Manifest List
        if (students.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No students found for this filter.'),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final s = students[index];
              final isBoarded = s.isBoarded;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.01),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: isBoarded ? const Color(0xFF00B894).withValues(alpha: 0.12) : const Color(0xFFD63031).withValues(alpha: 0.12),
                      child: Text(
                        s.name[0],
                        style: TextStyle(
                          color: isBoarded ? const Color(0xFF00B894) : const Color(0xFFD63031),
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                s.name,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  s.studentClass,
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isBoarded ? const Color(0xFF00B894).withValues(alpha: 0.1) : const Color(0xFFD63031).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        s.status,
                        style: TextStyle(
                          color: isBoarded ? const Color(0xFF00B894) : const Color(0xFFD63031),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF25D366), size: 20),
                      tooltip: 'WhatsApp Alert to Parent',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('💬 WhatsApp Boarding Notification triggered for ${s.parent} (${s.phone})'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value, {Color activeColor = const Color(0xFF6C5CE7)}) {
    final isSelected = _selectedFilter == value;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? activeColor : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
