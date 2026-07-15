import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'terms_page.dart';
import 'privacy_page.dart';
import 'otp_verification_page.dart';
import 'school_setup_dashboard.dart';

class RegisterSchoolPage extends StatefulWidget {
  const RegisterSchoolPage({super.key});

  @override
  State<RegisterSchoolPage> createState() => _RegisterSchoolPageState();
}

class _RegisterSchoolPageState extends State<RegisterSchoolPage> {
  bool _agreeToTerms = false;
  String? _selectedBoard;
  String? _selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3EDF7),
              Color(0xFFF3E7F9),
              Color(0xFFE9F2FF),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative blobs (Floating Animation)
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF6B8EFF).withOpacity(0.15)),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .moveY(begin: -20, end: 20, duration: 4.seconds, curve: Curves.easeInOut)
               .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 5.seconds),
            ),
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFC784FF).withOpacity(0.15)),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .moveX(begin: -20, end: 20, duration: 5.seconds, curve: Curves.easeInOut)
               .scale(begin: const Offset(1, 1), end: const Offset(0.9, 0.9), duration: 4.seconds),
            ),


            // Main Content
            SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align to top when scrolling
                      children: [
                        // Left Column
                        Expanded(
                          flex: 5,
                          child: _buildLeftColumn(),
                        ),
                        const SizedBox(width: 60),
                        // Right Column
                        Expanded(
                          flex: 6,
                          child: _buildRightColumn(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // DEV ONLY: Skip to Dashboard
            Positioned(
              top: 24,
              right: 24,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SchoolSetupDashboard()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.fast_forward_rounded, color: Color(0xFF0F52BA)),
                label: const Text('Skip to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F52BA))),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo & Name
        Row(
          children: [
            if (Navigator.canPop(context))
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F52BA)),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F52BA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/icon.png',
                width: 24,
                height: 24,
                color: Colors.white,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.school, color: Colors.white, size: 24),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vortiqen',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F52BA)),
                ),
                Text(
                  'ERP Admin Ecosystem',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
                ),
              ],
            ),
          ],
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 40),
        
        // Welcome Heading
        const Text(
          'Welcome to\n',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 1.1, color: Color(0xFF1E293B)),
        ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const Text(
          'Vortiqen',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 0.5, color: Color(0xFF0F52BA)),
        ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 24),
        
        // Description
        Text(
          'The world\'s first fluid school management system\ndesigned for modern education teams. Registration\ntakes less than 2 minutes.',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700),
        ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 48),
        
        // Feature Cards (Staggered Animation)
        _buildFeatureCard(
          icon: Icons.hub_outlined,
          iconColor: const Color(0xFF3B82F6),
          title: 'Unified Ecosystem',
          description: 'Connect faculty, students, and parents in one vibrant\nglassmorphic dashboard.',
        ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 16),
        
        _buildFeatureCard(
          icon: Icons.trending_up,
          iconColor: const Color(0xFFA855F7),
          title: 'Insightful Analytics',
          description: 'Real-time data visualization that helps your school grow\nwith confidence.',
        ).animate().fadeIn(delay: 1000.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
      ],
    );
  }

  Widget _buildFeatureCard({required IconData icon, required Color iconColor, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white, size: 24),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .shimmer(delay: 2.seconds, duration: 1.seconds, color: Colors.white30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'GET STARTED',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: Color(0xFF3B82F6)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Register School',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Step 1 of 2', style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(width: 24, height: 4, decoration: BoxDecoration(color: const Color(0xFF0F52BA), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 4),
                      Container(width: 24, height: 4, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2))),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // Form Fields (Animate sequentially)
          Row(
            children: [
              Expanded(child: _buildTextField('School Name', 'e.g. St. Xavier International', Icons.business)),
              const SizedBox(width: 24),
              Expanded(child: _buildDropdownField('Board', 'Select Board', Icons.book, items: ['BSEB', 'CBSE', 'ICSE', 'Open Schooling'], value: _selectedBoard, onChanged: (val) => setState(() => _selectedBoard = val))),
            ],
          ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 24),
          _buildTextField('Admin Email Address', 'admin@school.edu', Icons.email_outlined).animate().fadeIn(delay: 1000.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(child: _buildTextField('Address Line 1', 'Street, Building, Area', Icons.home_outlined)),
              const SizedBox(width: 24),
              Expanded(child: _buildTextField('City', 'e.g. New Delhi', Icons.location_city_outlined)),
            ],
          ).animate().fadeIn(delay: 1100.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _buildDropdownField('State', 'Select State', Icons.map_outlined, items: ['Delhi', 'Maharashtra', 'Karnataka', 'UP', 'Bihar', 'Other'], value: _selectedState, onChanged: (val) => setState(() => _selectedState = val))),
              const SizedBox(width: 24),
              Expanded(child: _buildTextField('Pin Code', 'e.g. 110001', Icons.pin_drop_outlined)),
            ],
          ).animate().fadeIn(delay: 1200.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _buildTextField('Total Students (Approx)', 'e.g. 500', Icons.people_outline)),
              const SizedBox(width: 24),
              const Expanded(child: SizedBox()),
            ],
          ).animate().fadeIn(delay: 1300.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 32),
          
          // Terms Checkbox
          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                onChanged: (val) {
                  setState(() {
                    _agreeToTerms = val ?? false;
                  });
                },
                activeColor: const Color(0xFF0F52BA),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    children: [
                      const TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms of Service', 
                        style: const TextStyle(color: Color(0xFF0F52BA), fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsPage()));
                        },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy', 
                        style: const TextStyle(color: Color(0xFF0F52BA), fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPage()));
                        },
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 1400.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 32),
          
          // Register Button (Slightly scales in and shimmers continuously)
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to next step
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OtpVerificationPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0346F2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register School', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 1600.ms, duration: 800.ms).scale(delay: 1600.ms, curve: Curves.easeOutBack, duration: 800.ms)
           .animate(onPlay: (controller) => controller.repeat())
           .shimmer(delay: 3.seconds, duration: 1.seconds, color: Colors.white24, angle: 1), // Continuous subtle shimmer
          
          const SizedBox(height: 24),
          
          Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                children: const [
                  TextSpan(text: 'Already registered? '),
                  TextSpan(text: 'Sign in to Admin Dashboard', style: TextStyle(color: Color(0xFF0F52BA), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 1800.ms, duration: 800.ms),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.02, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildTextField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.transparent),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint, IconData icon, {List<String> items = const [], String? value, ValueChanged<String?>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.transparent),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey.shade400, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: value,
                    hint: Text(hint, style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B))),
                      );
                    }).toList(),
                    onChanged: onChanged ?? (val) {},
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
