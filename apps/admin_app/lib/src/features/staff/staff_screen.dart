import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class TeacherProfile {
  final String id;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final List<String> assignedClasses;
  final String status;
  final String todayStatus;
  final String rating;

  const TeacherProfile({
    required this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.email,
    required this.phone,
    required this.assignedClasses,
    required this.status,
    required this.todayStatus,
    required this.rating,
  });
}

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _selectedDept = 'ALL';
  String _searchQuery = '';

  static const List<TeacherProfile> _mockTeachers = [
    TeacherProfile(
      id: 'tch_01',
      name: 'Dr. Priya Verma',
      designation: 'Senior Faculty & HOD',
      department: 'Science & Math',
      email: 'priya.verma@school.edu',
      phone: '+91 98111 22334',
      assignedClasses: ['Class 10-A', 'Class 12-A Physics'],
      status: 'ACTIVE',
      todayStatus: 'PRESENT',
      rating: '4.9 ★',
    ),
    TeacherProfile(
      id: 'tch_02',
      name: 'Prof. Alok Mukherjee',
      designation: 'Associate Professor',
      department: 'Science & Math',
      email: 'alok.m@school.edu',
      phone: '+91 98222 33445',
      assignedClasses: ['Class 9-B', 'Class 10-B Chemistry'],
      status: 'ACTIVE',
      todayStatus: 'ON LEAVE (2 Days)',
      rating: '4.8 ★',
    ),
    TeacherProfile(
      id: 'tch_03',
      name: 'Mrs. Sunita Rao',
      designation: 'Head of Department',
      department: 'Languages',
      email: 'sunita.rao@school.edu',
      phone: '+91 98333 44556',
      assignedClasses: ['Class 8-A', 'Class 10-A English'],
      status: 'ACTIVE',
      todayStatus: 'PRESENT',
      rating: '4.9 ★',
    ),
    TeacherProfile(
      id: 'tch_04',
      name: 'Mr. Rajesh Nambiar',
      designation: 'Faculty Lead',
      department: 'Commerce & Eco',
      email: 'rajesh.n@school.edu',
      phone: '+91 98444 55667',
      assignedClasses: ['Class 11-C', 'Class 12-C Accountancy'],
      status: 'ACTIVE',
      todayStatus: 'PRESENT',
      rating: '4.7 ★',
    ),
    TeacherProfile(
      id: 'tch_05',
      name: 'Ms. Ananya Sengupta',
      designation: 'Computer Science Instructor',
      department: 'Technology',
      email: 'ananya.s@school.edu',
      phone: '+91 98555 66778',
      assignedClasses: ['Class 10-A', 'Class 11-A AI & Python'],
      status: 'ACTIVE',
      todayStatus: 'PRESENT',
      rating: '5.0 ★',
    ),
    TeacherProfile(
      id: 'tch_06',
      name: 'Coach Vikram Rathore',
      designation: 'Sports & Physical Ed Director',
      department: 'Physical Ed',
      email: 'vikram.sports@school.edu',
      phone: '+91 98666 77889',
      assignedClasses: ['All Grades Athletic Squad'],
      status: 'ACTIVE',
      todayStatus: 'ON DUTY (Ground)',
      rating: '4.9 ★',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    final filteredTeachers = _mockTeachers.where((t) {
      final matchesDept = _selectedDept == 'ALL' || t.department == _selectedDept;
      final matchesSearch = t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.department.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.assignedClasses.any((c) => c.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesDept && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          _buildTopBar(context),
          const SizedBox(height: 20),

          // Department Filters & Search Row
          _buildFilterAndSearchBar(context),
          const SizedBox(height: 24),

          // Teacher Cards Grid
          _buildTeacherGrid(context, filteredTeachers, isDesktop),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Faculty & Teachers Directory',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Manage 84 Teaching Staff • Class Allocations & Real-Time Duty Status',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✨ Open Add New Teacher Dialog')),
              );
            },
            icon: const Icon(Icons.person_add_rounded, size: 16),
            label: const Text('Add Faculty'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearchBar(BuildContext context) {
    const depts = [
      {'label': 'All Faculty (84)', 'key': 'ALL'},
      {'label': 'Science & Math', 'key': 'Science & Math'},
      {'label': 'Languages', 'key': 'Languages'},
      {'label': 'Commerce & Eco', 'key': 'Commerce & Eco'},
      {'label': 'Technology', 'key': 'Technology'},
      {'label': 'Physical Ed', 'key': 'Physical Ed'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: const InputDecoration(
              icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8)),
              hintText: 'Search teacher by name, subject, or assigned class (e.g. Physics, Class 10)...',
              hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Department Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: depts.map((d) {
              final isSelected = _selectedDept == d['key'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(d['label']!),
                  selected: isSelected,
                  selectedColor: const Color(0xFF6C5CE7),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12,
                  ),
                  side: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedDept = d['key']!);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherGrid(BuildContext context, List<TeacherProfile> teachers, bool isDesktop) {
    if (teachers.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: const Column(
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No faculty found matching your search.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: teachers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: crossAxisCount == 1 ? 1.8 : 1.35,
          ),
          itemBuilder: (context, index) {
            final t = teachers[index];
            return _buildTeacherCard(context, t);
          },
        );
      },
    );
  }

  Widget _buildTeacherCard(BuildContext context, TeacherProfile t) {
    final isOnLeave = t.todayStatus.contains('LEAVE');
    final statusColor = isOnLeave ? const Color(0xFFF39C12) : const Color(0xFF00B894);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: Avatar + Name + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.12),
                    child: Text(
                      t.name.split(' ').last[0],
                      style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.name,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.designation,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        t.department,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  t.rating,
                  style: const TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
            ],
          ),

          // Assigned Classes Chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: t.assignedClasses.map((c) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  c,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7)),
                ),
              );
            }).toList(),
          ),

          // Status & Actions Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    t.todayStatus,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: Color(0xFF00B894)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('💬 Opening WhatsApp Chat with ${t.name}')),
                      );
                    },
                    tooltip: 'Message on WhatsApp',
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0984E3)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('📞 Calling ${t.phone}...')),
                      );
                    },
                    tooltip: 'Call Teacher',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
