import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'set_password_page.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  bool _otpSent = false;
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
            colors: [Color(0xFFE3EDF7), Color(0xFFF3E7F9), Color(0xFFE9F2FF)],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                const Text('Vortiqen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F52BA))),
                Text('ERP Admin Ecosystem', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
              ],
            ),
          ],
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 40),
        const Text('Secure your\n', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 1.1, color: Color(0xFF1E293B)))
            .animate().fadeIn(delay: 200.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const Text('Account', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 0.5, color: Color(0xFF0F52BA)))
            .animate().fadeIn(delay: 400.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 24),
        Text('We use industry-standard encryption to keep\nyour school\'s data safe. Verify your identity\nto access the admin dashboard.',
             style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700))
            .animate().fadeIn(delay: 600.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 48),
        _buildFeatureCard(
          icon: Icons.shield_outlined,
          iconColor: const Color(0xFF10B981), // Emerald green for security
          title: 'Bank-Grade Security',
          description: 'Your data is encrypted at rest and in transit\nensuring maximum privacy.',
        ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 16),
        _buildFeatureCard(
          icon: Icons.speed,
          iconColor: const Color(0xFFF59E0B), // Amber for speed
          title: 'Lightning Fast',
          description: 'Our cloud infrastructure guarantees 99.9% uptime\nand instant data retrieval.',
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white, size: 24),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(delay: 2.seconds, duration: 1.seconds, color: Colors.white30),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15))],
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF3B82F6), size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text('VERIFICATION', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: Color(0xFF3B82F6))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Verify Identity', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Step 2 of 2', style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(width: 24, height: 4, decoration: BoxDecoration(color: const Color(0xFF0F52BA), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 4),
                      Container(width: 24, height: 4, decoration: BoxDecoration(color: const Color(0xFF0F52BA), borderRadius: BorderRadius.circular(2))),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          // Form Area
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(animation),
                  child: child,
                ),
              );
            },
            child: _otpSent ? _buildOtpEntry() : _buildContactEntry(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.02, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildContactEntry() {
    return Column(
      key: const ValueKey('contact'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Mobile Number', '+91 98765 43210', Icons.phone_android, controller: _mobileController)
            .animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 24),
        _buildTextField('Email Address', 'admin@school.edu', Icons.email_outlined, controller: _emailController)
            .animate().fadeIn(delay: 1000.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 40),
        
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _otpSent = true;
              });
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
                Text('Send OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Icon(Icons.send_rounded, size: 20),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 1200.ms, duration: 800.ms).scale(delay: 1200.ms, curve: Curves.easeOutBack, duration: 800.ms),
      ],
    );
  }

  Widget _buildOtpEntry() {
    return Column(
      key: const ValueKey('otp'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone_android, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Mobile OTP sent to ${_mobileController.text.isNotEmpty ? _mobileController.text : "your number"}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 16),
        _buildOtpRow().animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 32),
        
        Row(
          children: [
            Icon(Icons.email_outlined, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Email OTP sent to ${_emailController.text.isNotEmpty ? _emailController.text : "your email"}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 16),
        _buildOtpRow().animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 32),
        
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SetPasswordPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981), // Green for success/verify
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Verify & Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Icon(Icons.check_circle_outline, size: 20),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 1000.ms, duration: 800.ms).scale(delay: 1000.ms, curve: Curves.easeOutBack, duration: 800.ms),
        const SizedBox(height: 24),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                _otpSent = false;
              });
            },
            child: const Text('Change Mobile/Email', style: TextStyle(color: Color(0xFF0F52BA), fontWeight: FontWeight.bold)),
          ),
        ).animate().fadeIn(delay: 1200.ms, duration: 800.ms),
      ],
    );
  }

  Widget _buildOtpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          alignment: Alignment.center,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon, {TextEditingController? controller}) {
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
            controller: controller,
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
}
