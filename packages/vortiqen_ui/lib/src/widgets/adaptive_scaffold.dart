import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AdaptiveNavItem {
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? badge;

  const AdaptiveNavItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.badge,
  });
}

class AdaptiveScaffold extends StatefulWidget {
  final AppRole role;
  final String title;
  final String? subtitle;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<AdaptiveNavItem> destinations;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AdaptiveScaffold({
    super.key,
    required this.role,
    required this.title,
    this.subtitle,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = AppTheme.getPrimaryColor(widget.role);
    final width = MediaQuery.of(context).size.width;

    final isDesktop = width >= 1024;
    final isTablet = width >= 600 && width < 1024;

    // 1. DESKTOP VIEW (>= 1024px)
    if (isDesktop) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        body: Row(
          children: [
            // Left Desktop Sidebar
            _buildDesktopSidebar(primaryColor, theme),

            // Main Content Area with Header
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(primaryColor, theme, isDesktop: true),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1400),
                        child: widget.body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      );
    }

    // 2. TABLET VIEW (600px - 1023px)
    if (isTablet) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: Colors.white,
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              labelType: NavigationRailLabelType.selected,
              indicatorColor: primaryColor.withValues(alpha: 0.15),
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppTheme.getGradient(widget.role)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('V', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
                  ),
                ),
              ),
              destinations: widget.destinations.map((item) {
                return NavigationRailDestination(
                  icon: item.badge != null
                      ? Badge(
                          label: Text(item.badge!),
                          backgroundColor: primaryColor,
                          child: Icon(item.icon),
                        )
                      : Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon ?? item.icon, color: primaryColor),
                  label: Text(item.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1, color: Color(0xFFE2E8F0)),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(primaryColor, theme, isDesktop: false),
                  Expanded(child: widget.body),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      );
    }

    // 3. MOBILE VIEW (< 600px)
    // On small phones, protect actions from overflowing horizontally
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
        centerTitle: false,
        actions: widget.actions != null
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.actions!,
                  ),
                ),
              ]
            : null,
      ),
      body: widget.body,
      bottomNavigationBar: widget.destinations.length > 1
          ? NavigationBar(
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              indicatorColor: primaryColor.withValues(alpha: 0.15),
              elevation: 4,
              destinations: widget.destinations.map((item) {
                return NavigationDestination(
                  icon: item.badge != null
                      ? Badge(
                          label: Text(item.badge!),
                          backgroundColor: primaryColor,
                          child: Icon(item.icon),
                        )
                      : Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon ?? item.icon, color: primaryColor),
                  label: item.label,
                );
              }).toList(),
            )
          : null,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildDesktopSidebar(Color primaryColor, ThemeData theme) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Logo Box
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppTheme.getGradient(widget.role)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('V', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VortiQen',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5),
                    ),
                    Text(
                      widget.role.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          // Nav Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: widget.destinations.length,
              itemBuilder: (context, index) {
                final item = widget.destinations[index];
                final isSelected = widget.selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: InkWell(
                    onTap: () => widget.onDestinationSelected(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                            color: isSelected ? primaryColor : const Color(0xFF64748B),
                            size: 20,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? primaryColor : const Color(0xFF334155),
                              ),
                            ),
                          ),
                          if (item.badge != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.badge!,
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // User Profile at Bottom
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor.withValues(alpha: 0.2),
                  child: Text(
                    widget.role.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aarav Sharma',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Class 10-A • Online',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(Color primaryColor, ThemeData theme, {required bool isDesktop}) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.3),
              ),
              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
            ],
          ),
          const Spacer(),
          if (widget.actions != null) ...widget.actions!,
        ],
      ),
    );
  }
}
