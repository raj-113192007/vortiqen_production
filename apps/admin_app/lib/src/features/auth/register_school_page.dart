import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'terms_page.dart';
import 'privacy_page.dart';

class RegisterSchoolPage extends StatefulWidget {
  const RegisterSchoolPage({super.key});

  @override
  State<RegisterSchoolPage> createState() => _RegisterSchoolPageState();
}

class _RegisterSchoolPageState extends State<RegisterSchoolPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _schoolNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _pinController = TextEditingController();
  final _studentsCountController = TextEditingController();

  bool _agreeToTerms = false;
  String? _selectedBoard = 'CBSE';
  String? _selectedState = 'Delhi';
  late AnimationController _blobController;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _pinController.dispose();
    _studentsCountController.dispose();
    _blobController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept the Terms of Service & Privacy Policy.'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('School registered successfully! Entering admin console...'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 960;
    const primaryColor = Color(0xFF4F46E5);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF8FAFC),
        child: Stack(
          children: [
            // Floating Mesh Gradient Blobs
            AnimatedBuilder(
              animation: _blobController,
              builder: (context, child) {
                final offset = _blobController.value * 24;
                return Stack(
                  children: [
                    Positioned(
                      top: -80 + offset,
                      left: -80 - offset,
                      child: Container(
                        width: 440,
                        height: 440,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -100 - offset,
                      right: -100 + offset,
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0EA5E9).withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Top Bar
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text('Back to Login'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => context.go('/dashboard'),
                    icon: const Icon(Icons.fast_forward_rounded, size: 16),
                    label: const Text('Demo Direct Entry'),
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xFFE2E8F0))),
                      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Body
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
                child: isDesktop
                    ? Container(
                        constraints: const BoxConstraints(maxWidth: 1060),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Branding Column
                            Expanded(
                              flex: 5,
                              child: _buildLeftHero(primaryColor),
                            ),
                            const SizedBox(width: 48),
                            // Right Registration Form Card
                            Expanded(
                              flex: 6,
                              child: _buildRegistrationCard(primaryColor),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Column(
                          children: [
                            _buildMobileHeader(primaryColor),
                            const SizedBox(height: 20),
                            _buildRegistrationCard(primaryColor),
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
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VortiQen',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                ),
                Text(
                  'Institution Onboarding Engine',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 36),

        const Text(
          'Register Your School in 2 Minutes.',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            height: 1.2,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Setup faculty departments, class sections, live bus corridors, and automated billing seamlessly with zero onboarding friction.',
          style: TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.5),
        ),
        const SizedBox(height: 32),

        // Features
        _buildFeatureItem(Icons.hub_outlined, 'Unified Campus Database', 'Sync attendance, marks, fees, and GPS across one cloud schema.', primaryColor),
        const SizedBox(height: 14),
        _buildFeatureItem(Icons.analytics_outlined, 'Real-time Analytical Insights', 'Automated student progress and fleet performance analytics.', const Color(0xFF0EA5E9)),
        const SizedBox(height: 14),
        _buildFeatureItem(Icons.lock_outline_rounded, 'Role-Based Access & Security', 'Independent portals for Admin, Faculty, Parents, and Drivers.', const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.school_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        const Text(
          'Register School Institution',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
        ),
        const Text(
          'Quick 2-minute cloud setup',
          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildRegistrationCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: primaryColor.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header & Step
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('INSTITUTION PROFILE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0, color: Color(0xFF4F46E5))),
                    SizedBox(height: 2),
                    Text('School Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                  child: const Text('Step 1 of 2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // School Name & Board
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildFormField('School Name', _schoolNameController, 'e.g. St. Xavier Global School', Icons.business_outlined, required: true),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdownField('Board', ['CBSE', 'ICSE', 'State Board', 'IB'], _selectedBoard, (v) => setState(() => _selectedBoard = v)),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Admin Email
            _buildFormField('Admin Email Address', _emailController, 'admin@school.edu', Icons.mail_outline_rounded, required: true),
            const SizedBox(height: 14),

            // State & City
            Row(
              children: [
                Expanded(
                  child: _buildDropdownField('State', ['Delhi', 'Maharashtra', 'Karnataka', 'UP', 'Haryana', 'Other'], _selectedState, (v) => setState(() => _selectedState = v)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFormField('City / Region', _cityController, 'e.g. New Delhi', Icons.location_city_outlined),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Pin & Student Capacity
            Row(
              children: [
                Expanded(
                  child: _buildFormField('PIN Code', _pinController, '110001', Icons.pin_drop_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFormField('Total Scholars (Approx)', _studentsCountController, 'e.g. 850', Icons.groups_outlined),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Terms & Conditions Checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  activeColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsPage())),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPage())),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Proceed to Setup Dashboard', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Already Registered
            Center(
              child: TextButton(
                onPressed: () => context.go('/login'),
                child: const Text(
                  'Already registered? Sign In to Console',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF4F46E5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, String hint, IconData icon, {bool required = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B)),
          validator: required ? (v) => v == null || v.isEmpty ? 'Required' : null : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
            prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 16),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
