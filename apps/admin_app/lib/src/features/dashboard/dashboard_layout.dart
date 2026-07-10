import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: _isExpanded ? 250 : 80,
            curve: Curves.easeInOut,
            child: Material(
              elevation: 4,
              color: colorScheme.surface,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Logo/Brand Area
                  InkWell(
                    onTap: () {
                      setState(() => _isExpanded = !_isExpanded);
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: _isExpanded 
                            ? MainAxisAlignment.start 
                            : MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, 
                            color: colorScheme.primary, 
                            size: 32,
                          ),
                          if (_isExpanded) ...[
                            const SizedBox(width: 12),
                            Text(
                              'VortiQen',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Navigation Items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: [
                        _buildNavItem(0, Icons.dashboard, 'Dashboard'),
                        _buildNavItem(1, Icons.apartment, 'Schools'),
                        _buildNavItem(2, Icons.badge, 'Staff'),
                        _buildNavItem(3, Icons.class_, 'Academics'),
                        _buildNavItem(4, Icons.people, 'Students'),
                        _buildNavItem(5, Icons.directions_bus, 'Transport'),
                        _buildNavItem(6, Icons.check_circle_outline, 'Attendance'),
                        _buildNavItem(7, Icons.payment, 'Fees'),
                        _buildNavItem(8, Icons.assignment_ind, 'Admissions'),
                        _buildNavItem(9, Icons.inventory, 'Inventory'),
                        _buildNavItem(10, Icons.assignment, 'Exams'),
                        _buildNavItem(11, Icons.people_alt, 'Human Resources'),
                        _buildNavItem(12, Icons.chat, 'Communications'),
                        _buildNavItem(13, Icons.bar_chart, 'Reports'),
                        _buildNavItem(14, Icons.videocam, 'CCTV Cameras'),
                        _buildNavItem(15, Icons.settings, 'Settings'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar Area
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.8),
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Admin Dashboard',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      // Profile Actions
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          'SA',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Child Content
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected 
                ? colorScheme.primary.withValues(alpha: 0.1) 
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: _isExpanded 
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
              if (_isExpanded) ...[
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

