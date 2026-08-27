import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class VortiqenSplashScreen extends StatefulWidget {
  final AppRole role;
  final String appTitle;
  final String appSubtitle;
  final String nextRoute;

  const VortiqenSplashScreen({
    super.key,
    required this.role,
    required this.appTitle,
    required this.appSubtitle,
    this.nextRoute = '/login',
  });

  @override
  State<VortiqenSplashScreen> createState() => _VortiqenSplashScreenState();
}

class _VortiqenSplashScreenState extends State<VortiqenSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();

    // Navigate to next route after 2 seconds
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        context.go(widget.nextRoute);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getRoleIcon(AppRole role) {
    switch (role) {
      case AppRole.admin:
        return Icons.admin_panel_settings_rounded;
      case AppRole.teacher:
        return Icons.auto_stories_rounded;
      case AppRole.student:
        return Icons.school_rounded;
      case AppRole.parent:
        return Icons.family_restroom_rounded;
      case AppRole.driver:
        return Icons.directions_bus_filled_rounded;
      case AppRole.director:
        return Icons.account_balance_rounded;
      case AppRole.superAdmin:
        return Icons.shield_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppTheme.getPrimaryColor(widget.role);
    final gradient = AppTheme.getGradient(widget.role);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Glowing Logo Box
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.35),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _getRoleIcon(widget.role),
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // App Title
                Text(
                  widget.appTitle,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle / Tagline
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.appSubtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Minimal clean loading indicator
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
