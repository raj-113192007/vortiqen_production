import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'approval_waiting_page.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _passwordText = '';

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
        const Text('Final Step\n', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 1.1, color: Color(0xFF1E293B)))
            .animate().fadeIn(delay: 200.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const Text('Set Password', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, height: 0.5, color: Color(0xFF0F52BA)))
            .animate().fadeIn(delay: 400.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        const SizedBox(height: 24),
        Text('Create a strong password to protect your admin\naccount. You will use this to sign in later.',
             style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700))
            .animate().fadeIn(delay: 600.ms, duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
        
        const SizedBox(height: 48),
        _buildFeatureCard(
          icon: Icons.lock_outline,
          iconColor: const Color(0xFF10B981),
          title: 'Strong Password',
          description: 'Use a mix of uppercase, lowercase, numbers,\nand special characters for maximum security.',
        ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
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
                      const Text('ALMOST DONE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: Color(0xFF3B82F6))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Set Password', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Step 3 of 3', style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(width: 24, height: 4, decoration: BoxDecoration(color: const Color(0xFF0F52BA), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 4),
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
          
          _buildPasswordField('New Password', 'Enter your password', _obscurePassword, (val) {
            setState(() {
              _obscurePassword = val;
            });
          }, onChanged: (val) {
            setState(() {
              _passwordText = val;
            });
          }).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 16),
          _buildPasswordConditions().animate().fadeIn(delay: 900.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          const SizedBox(height: 24),
          
          _buildPasswordField('Confirm Password', 'Re-enter your password', _obscureConfirmPassword, (val) {
            setState(() {
              _obscureConfirmPassword = val;
            });
          }).animate().fadeIn(delay: 1000.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          const SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const ApprovalWaitingPage()),
                  (route) => false,
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
                  Text('Complete Registration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle, size: 20),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 1200.ms, duration: 800.ms).scale(delay: 1200.ms, curve: Curves.easeOutBack, duration: 800.ms),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.02, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildPasswordConditions() {
    return Column(
      children: [
        _buildConditionRow('At least 8 characters', _passwordText.length >= 8),
        _buildConditionRow('Contains uppercase letter', _passwordText.contains(RegExp(r'[A-Z]'))),
        _buildConditionRow('Contains lowercase letter', _passwordText.contains(RegExp(r'[a-z]'))),
        _buildConditionRow('Contains number', _passwordText.contains(RegExp(r'[0-9]'))),
        _buildConditionRow('Contains special character', _passwordText.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))),
      ],
    );
  }

  Widget _buildConditionRow(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isMet ? const Color(0xFF10B981) : Colors.transparent,
              border: Border.all(color: isMet ? const Color(0xFF10B981) : Colors.grey.shade400, width: 2),
              shape: BoxShape.circle,
            ),
            child: isMet ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isMet ? const Color(0xFF1E293B) : Colors.grey.shade500,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, String hint, bool isObscure, ValueChanged<bool> onObscureToggle, {ValueChanged<String>? onChanged}) {
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
            obscureText: isObscure,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 20),
              suffixIcon: IconButton(
                icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey.shade400, size: 20),
                onPressed: () => onObscureToggle(!isObscure),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
