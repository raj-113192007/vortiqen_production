import 'package:flutter/material.dart';

class NavGroup {
  final String title;
  final List<NavEntry> items;

  const NavGroup({required this.title, required this.items});
}

class NavEntry {
  final int index;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String? badge;

  const NavEntry({
    required this.index,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.badge,
  });
}

class DashboardLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const DashboardLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool _isExpanded = true;

  static const List<NavGroup> _navGroups = [
    NavGroup(
      title: 'EXECUTIVE COCKPIT',
      items: [
        NavEntry(index: 0, label: 'Overview', icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded),
        NavEntry(index: 1, label: '5-in-1 Onboarding', icon: Icons.cloud_upload_outlined, selectedIcon: Icons.cloud_upload_rounded, badge: 'AUTO'),
      ],
    ),
    NavGroup(
      title: 'ACADEMICS & SCHOLARS',
      items: [
        NavEntry(index: 2, label: 'Students & Scholars', icon: Icons.people_outline, selectedIcon: Icons.people_rounded),
        NavEntry(index: 3, label: 'Classrooms & Live', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
        NavEntry(index: 5, label: 'Exams & Marks', icon: Icons.assignment_outlined, selectedIcon: Icons.assignment_rounded),
      ],
    ),
    NavGroup(
      title: 'ADMIN & OPERATIONS',
      items: [
        NavEntry(index: 4, label: 'Fees & Master Matrix', icon: Icons.receipt_long_outlined, selectedIcon: Icons.receipt_long_rounded),
        NavEntry(index: 6, label: 'Faculty & HR Staff', icon: Icons.badge_outlined, selectedIcon: Icons.badge_rounded),
        NavEntry(index: 7, label: 'Transport & Fleet', icon: Icons.directions_bus_outlined, selectedIcon: Icons.directions_bus_rounded),
        NavEntry(index: 8, label: 'Campus CCTV Live', icon: Icons.videocam_outlined, selectedIcon: Icons.videocam_rounded),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Row(
            children: [
              Text('VortiQen Admin', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF1E293B))),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded, color: Color(0xFF6C5CE7)),
              onPressed: () => _openGlobalCommandPalette(context),
            ),
            IconButton(
              icon: const Icon(Icons.cloud_upload_rounded, color: Color(0xFF6C5CE7)),
              onPressed: () => widget.onItemSelected(1),
            ),
          ],
        ),
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _getMobileNavIndex(widget.selectedIndex),
          onDestinationSelected: (idx) {
            final mapped = [0, 1, 2, 4, 7][idx];
            widget.onItemSelected(mapped);
          },
          indicatorColor: const Color(0xFF6C5CE7).withOpacity(0.12),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF6C5CE7)), label: 'Overview'),
            NavigationDestination(icon: Icon(Icons.cloud_upload_outlined), selectedIcon: Icon(Icons.cloud_upload_rounded, color: Color(0xFF6C5CE7)), label: 'Onboard'),
            NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people_rounded, color: Color(0xFF6C5CE7)), label: 'Students'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded, color: Color(0xFF6C5CE7)), label: 'Fees'),
            NavigationDestination(icon: Icon(Icons.directions_bus_outlined), selectedIcon: Icon(Icons.directions_bus_rounded, color: Color(0xFF6C5CE7)), label: 'Fleet'),
          ],
        ),
      );
    }

    // Tablet & Desktop Layout
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // Sleek Grouped Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isExpanded ? 260 : 78,
            curve: Curves.easeInOut,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),
                // Brand Header & Collapse Toggle
                InkWell(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      mainAxisAlignment: _isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFF6C5CE7).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.school_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                        if (_isExpanded) ...[
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('VortiQen ERP', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B), letterSpacing: -0.5)),
                                Text('DELHI PUBLIC INTL', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7), letterSpacing: 0.6)),
                              ],
                            ),
                          ),
                          Icon(Icons.unfold_more_rounded, size: 18, color: Colors.grey[400]),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 8),

                // Grouped Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _navGroups.length,
                    itemBuilder: (context, gIdx) {
                      final group = _navGroups[gIdx];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 16, bottom: 6),
                              child: Text(
                                group.title,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF94A3B8),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            )
                          else
                            const SizedBox(height: 12),

                          ...group.items.map((item) {
                            final isSelected = widget.selectedIndex == item.index;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: InkWell(
                                onTap: () => widget.onItemSelected(item.index),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: _isExpanded ? 12 : 0, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.09) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: isSelected ? Border.all(color: const Color(0xFF6C5CE7).withOpacity(0.2)) : null,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: _isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isSelected ? item.selectedIcon : item.icon,
                                        color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF64748B),
                                        size: 20,
                                      ),
                                      if (_isExpanded) ...[
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            item.label,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                                              color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF334155),
                                            ),
                                          ),
                                        ),
                                        if (item.badge != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF00B894),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              item.badge!,
                                              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),

                // Bottom Session Tag
                if (_isExpanded)
                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF6C5CE7)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('Session 2026-27 (Term 2)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Main Canvas with Top Command Header
          Expanded(
            child: Column(
              children: [
                // Top Global Command Header
                _buildTopGlobalHeader(context),

                // Child Screen Content
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8FAFC),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getMobileNavIndex(int current) {
    if (current == 0) return 0;
    if (current == 1) return 1;
    if (current == 2) return 2;
    if (current == 4) return 3;
    if (current == 7) return 4;
    return 0;
  }

  Widget _buildTopGlobalHeader(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: School Selector & Session
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified_rounded, color: Color(0xFF6C5CE7), size: 14),
                    SizedBox(width: 6),
                    Text('Delhi Public Intl School (CBSE)', style: TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),

          // Center: Global Command Palette Search (Ctrl + K)
          InkWell(
            onTap: () => _openGlobalCommandPalette(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 380,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 18),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('Search Student, Teacher, Bus, or Class...', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFCBD5E1))),
                    child: const Text('Ctrl K', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                  ),
                ],
              ),
            ),
          ),

          // Right: Quick Action + Notification + Principal Profile
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _showQuickActionSheet(context),
                icon: const Icon(Icons.bolt_rounded, size: 16),
                label: const Text('Quick Action'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 14),

              // Notifications
              IconButton(
                icon: const Badge(
                  label: Text('3'),
                  backgroundColor: Color(0xFFFF7675),
                  child: Icon(Icons.notifications_none_rounded, color: Color(0xFF64748B), size: 22),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('3 Urgent Action Items: 2 Student Leaves pending, 1 Bus Inspection due')),
                  );
                },
              ),
              const SizedBox(width: 10),

              // Principal Profile Avatar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF6C5CE7),
                      child: Text('P', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dr. A. Sharma', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                        Row(
                          children: [
                            const Text('Principal', style: TextStyle(fontSize: 9, color: Color(0xFF00B894), fontWeight: FontWeight.w700)),
                            const SizedBox(width: 4),
                            Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF00B894), shape: BoxShape.circle)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- GLOBAL COMMAND PALETTE (CTRL + K) ---
  void _openGlobalCommandPalette(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.topCenter,
          insetPadding: const EdgeInsets.only(top: 80, left: 24, right: 24),
          child: Container(
            width: 580,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF6C5CE7)),
                      hintText: 'Jump to any Student, Teacher, Bus Route, or Feature...',
                      hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                SizedBox(
                  height: 280,
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      _buildCommandItem(
                        icon: Icons.person_rounded,
                        title: 'Aarav Sharma',
                        sub: 'Scholar #101 • Class 10-A • Bus #04',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onItemSelected(2); // Students
                        },
                      ),
                      _buildCommandItem(
                        icon: Icons.school_rounded,
                        title: 'Dr. Priya Verma',
                        sub: 'HOD Science • Class Teacher 10-A',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onItemSelected(6); // HR & Staff
                        },
                      ),
                      _buildCommandItem(
                        icon: Icons.directions_bus_rounded,
                        title: 'Bus #04 (DL 01 PB 4488)',
                        sub: 'Dwarka Route • Moving @ 34 km/h',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onItemSelected(7); // Transport
                        },
                      ),
                      _buildCommandItem(
                        icon: Icons.meeting_room_rounded,
                        title: 'Class 10 - Section A',
                        sub: 'Room 204 • Physics Lab Live Now',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onItemSelected(3); // Classrooms
                        },
                      ),
                      _buildCommandItem(
                        icon: Icons.receipt_long_rounded,
                        title: 'School Fee Matrix Master',
                        sub: 'Tuition, Lab & Transport Slabs',
                        onTap: () {
                          Navigator.pop(context);
                          widget.onItemSelected(4); // Fees
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommandItem({required IconData icon, required String title, required String sub, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF6C5CE7).withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: const Color(0xFF6C5CE7), size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                  Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFFCBD5E1)),
          ],
        ),
      ),
    );
  }

  // --- QUICK ACTION MODAL SHEET ---
  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Executive Quick Actions', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.person_add_rounded,
                      color: const Color(0xFF6C5CE7),
                      title: 'New Admission',
                      onTap: () {
                        Navigator.pop(context);
                        widget.onItemSelected(2);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.receipt_rounded,
                      color: const Color(0xFF00B894),
                      title: 'Collect Fees',
                      onTap: () {
                        Navigator.pop(context);
                        widget.onItemSelected(4);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.campaign_rounded,
                      color: const Color(0xFF0984E3),
                      title: 'Broadcast Alert',
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Draft SMS/WhatsApp Notice Modal Opened')));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionCard({required IconData icon, required Color color, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }
}
