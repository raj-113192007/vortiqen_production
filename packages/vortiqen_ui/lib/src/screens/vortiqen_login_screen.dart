import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class VortiqenLoginScreen extends ConsumerStatefulWidget {
  final AppRole role;
  final String title;
  final String subtitle;
  final String defaultEmail;

  const VortiqenLoginScreen({
    super.key,
    required this.role,
    required this.title,
    required this.subtitle,
    this.defaultEmail = '',
  });

  @override
  ConsumerState<VortiqenLoginScreen> createState() => _VortiqenLoginScreenState();
}

class _VortiqenLoginScreenState extends ConsumerState<VortiqenLoginScreen> with SingleTickerProviderStateMixin {
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController(text: 'password123');
  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _blobController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.defaultEmail.isNotEmpty ? widget.defaultEmail : 'schooladmin@vortiqen.com');
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _blobController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => _isLoading = true);
    final success = await ref.read(authProvider.notifier).login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    setState(() => _isLoading = false);

    if (success && mounted) {
      context.go('/dashboard');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Invalid email or password. Please try again.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }
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
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 960;
    final primaryColor = AppTheme.getPrimaryColor(widget.role);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
        ),
        child: Stack(
          children: [
            // Animated Gradient Mesh Blobs
            AnimatedBuilder(
              animation: _blobController,
              builder: (context, child) {
                final offset = _blobController.value * 24;
                return Stack(
                  children: [
                    Positioned(
                      top: -60 + offset,
                      left: -60 - offset,
                      child: Container(
                        width: 420,
                        height: 420,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -80 - offset,
                      right: -80 + offset,
                      child: Container(
                        width: 480,
                        height: 480,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6366F1).withValues(alpha: 0.10),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Main Content Area
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: isDesktop
                    ? Container(
                        constraints: const BoxConstraints(maxWidth: 1040),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Left Hero Column (Branding & Key Features)
                            Expanded(
                              flex: 5,
                              child: _buildLeftHero(primaryColor),
                            ),
                            const SizedBox(width: 48),
                            // Right Login Card
                            Expanded(
                              flex: 5,
                              child: _buildLoginCard(primaryColor),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: Column(
                          children: [
                            _buildMobileHeader(primaryColor),
                            const SizedBox(height: 24),
                            _buildLoginCard(primaryColor),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftHero(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Badge
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.hub_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VortiQen',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'Intelligent School Management System',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Welcome Headline
        Text(
          'Next-Gen Operations for Modern Campuses.',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0F172A),
            height: 1.2,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Unified faculty management, live GPS transport tracking, automated fee invoicing, and student intelligence all in one seamless console.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF475569),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),

        // 3 Compact Feature Pills
        _buildFeaturePill(Icons.alt_route_rounded, 'Real-time Transport', 'Live GPS route tracking, speed governors, and instant alerts.', primaryColor),
        const SizedBox(height: 12),
        _buildFeaturePill(Icons.groups_rounded, 'Faculty & Payroll Control', 'Automated period timetables, leave rosters, and payslips.', const Color(0xFF0EA5E9)),
        const SizedBox(height: 12),
        _buildFeaturePill(Icons.shield_outlined, 'RTO & Compliance Vault', 'Instant vehicle fitness, insurance, and audit readiness.', const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildFeaturePill(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(Color primaryColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.hub_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 10),
        Text(
          'VortiQen ERP',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
          ),
        ),
        Text(
          'Sign in to manage your campus operations',
          style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildLoginCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Role & Sign In Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Enter your portal credentials',
                    style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(_getRoleIcon(widget.role), size: 14, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      widget.role.name.toUpperCase(),
                      style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Quick Demo Credentials Selector
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Fill Demo Account:',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildDemoChip('School Admin', 'schooladmin@vortiqen.com', primaryColor),
                    _buildDemoChip('Principal', 'principal@vortiqen.com', const Color(0xFF0EA5E9)),
                    _buildDemoChip('Faculty', 'teacher@vortiqen.com', const Color(0xFF10B981)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Email Input
          Text(
            'Email Address or Phone',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _emailController,
            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: 'name@school.edu',
              hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
              prefixIcon: Icon(Icons.mail_outline_rounded, color: primaryColor, size: 18),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Password Input
          Text(
            'Password',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 13),
              prefixIcon: Icon(Icons.lock_outline_rounded, color: primaryColor, size: 18),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF94A3B8),
                  size: 18,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Submit Button
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      'Sign In to Dashboard',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Register New School Link
          OutlinedButton.icon(
            onPressed: () {
              context.push('/register');
            },
            icon: const Icon(Icons.app_registration_rounded, size: 16),
            label: const Text('Register New School'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF475569),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 14),

          // Footer Info
          Center(
            child: Text(
              'Powered by VortiQen Intelligent Ecosystem',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoChip(String label, String email, Color color) {
    final isSelected = _emailController.text == email;
    return InkWell(
      onTap: () {
        setState(() {
          _emailController.text = email;
          _passwordController.text = 'password123';
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? color : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}
