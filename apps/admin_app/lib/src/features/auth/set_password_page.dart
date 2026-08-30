import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

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
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF6B8EFF).withValues(alpha: 0.15)),
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
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFC784FF).withValues(alpha: 0.15)),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .moveX(begin: -20, end: 20, duration: 5.seconds, curve: Curves.easeInOut)
               .scale(begin: const Offset(1, 1), end: const Offset(0.9, 0.9), duration: 4.seconds),
            ),

            // Main Content
            SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                    child: _buildMainCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0346F2).withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0D1B3E)),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              const Text(
                'Back',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 16),
          
          const Text(
            'Set Your Password',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B3E),
              letterSpacing: -0.5,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 800.ms).slideY(begin: 0.1, curve: Curves.easeOutQuart),
          const SizedBox(height: 8),
          
          const Text(
            'Create a strong password to secure your VortiQen school administrative console.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.1, curve: Curves.easeOutQuart),
          const SizedBox(height: 32),

          _buildPasswordField('New Password', 'Enter strong password', _obscurePassword, (val) {
            setState(() {
              _obscurePassword = val;
            });
          }, onChanged: (val) {
            setState(() {
              _passwordText = val;
            });
          }).animate().fadeIn(delay: 300.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          
          const SizedBox(height: 16),
          _buildPasswordConditions(),
          const SizedBox(height: 24),
          
          _buildPasswordField('Confirm Password', 'Re-enter your password', _obscureConfirmPassword, (val) {
            setState(() {
              _obscureConfirmPassword = val;
            });
          }).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.go('/dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Complete Setup & Enter Dashboard',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 500.ms, duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, String hint, bool obscure, Function(bool) onToggle, {Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D1B3E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextField(
            obscureText: obscure,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF6B7280),
                  size: 20,
                ),
                onPressed: () => onToggle(!obscure),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordConditions() {
    bool hasMinLength = _passwordText.length >= 8;
    bool hasUppercase = _passwordText.contains(RegExp(r'[A-Z]'));
    bool hasNumber = _passwordText.contains(RegExp(r'[0-9]'));
    bool hasSpecial = _passwordText.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password must contain:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildConditionItem('At least 8 characters', hasMinLength),
              _buildConditionItem('One uppercase letter', hasUppercase),
              _buildConditionItem('One number', hasNumber),
              _buildConditionItem('One special character', hasSpecial),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionItem(String text, bool met) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: met ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: met ? const Color(0xFF10B981) : const Color(0xFF6B7280),
            fontWeight: met ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
