import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

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

  static const List<AdaptiveNavItem> _navItems = [
    AdaptiveNavItem(label: 'Overview', icon: Icons.dashboard_outlined, selectedIcon: Icons.dashboard_rounded),
    AdaptiveNavItem(label: 'Onboarding', icon: Icons.cloud_upload_outlined, selectedIcon: Icons.cloud_upload_rounded, badge: '5-in-1'),
    AdaptiveNavItem(label: 'Students', icon: Icons.people_outline, selectedIcon: Icons.people_rounded),
    AdaptiveNavItem(label: 'Attendance', icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check_rounded),
    AdaptiveNavItem(label: 'Fees Ledger', icon: Icons.receipt_long_outlined, selectedIcon: Icons.receipt_long_rounded),
    AdaptiveNavItem(label: 'Exams & Marks', icon: Icons.assignment_outlined, selectedIcon: Icons.assignment_rounded),
    AdaptiveNavItem(label: 'HR & Staff', icon: Icons.badge_outlined, selectedIcon: Icons.badge_rounded),
    AdaptiveNavItem(label: 'CCTV Live', icon: Icons.videocam_outlined, selectedIcon: Icons.videocam_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('VortiQen Admin', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.cloud_upload_rounded, color: Color(0xFF6C5CE7)),
              onPressed: () => widget.onItemSelected(1),
              tooltip: 'Data Onboarding Hub',
            ),
          ],
        ),
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: widget.selectedIndex > 4 ? 0 : widget.selectedIndex,
          onDestinationSelected: widget.onItemSelected,
          indicatorColor: const Color(0xFF6C5CE7).withOpacity(0.15),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF6C5CE7)), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.cloud_upload_outlined), selectedIcon: Icon(Icons.cloud_upload_rounded, color: Color(0xFF6C5CE7)), label: 'Onboard'),
            NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people_rounded, color: Color(0xFF6C5CE7)), label: 'Students'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded, color: Color(0xFF6C5CE7)), label: 'Fees'),
            NavigationDestination(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
          ],
        ),
      );
    }

    // Tablet & Desktop Responsive Layout
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Row(
        children: [
          // Sidebar
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
                const SizedBox(height: 20),
                // Logo/Brand Area
                InkWell(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Row(
                      mainAxisAlignment: _isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFF6C5CE7).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: const Center(
                            child: Text('V', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
                          ),
                        ),
                        if (_isExpanded) ...[
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('VortiQen', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5)),
                                Text('SCHOOL ADMIN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7), letterSpacing: 0.8)),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),

                // Nav Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _navItems.length,
                    itemBuilder: (context, index) {
                      final item = _navItems[index];
                      final isSelected = widget.selectedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InkWell(
                          onTap: () => widget.onItemSelected(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: _isExpanded ? 14 : 0, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: _isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                                  color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF64748B),
                                  size: 22,
                                ),
                                if (_isExpanded) ...[
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                        color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF334155),
                                      ),
                                    ),
                                  ),
                                  if (item.badge != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C5CE7),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        item.badge!,
                                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main View Content
          Expanded(
            child: Container(
              color: const Color(0xFFF8F9FE),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
