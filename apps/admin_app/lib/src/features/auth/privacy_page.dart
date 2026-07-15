import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
            
            // Content
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.05, curve: Curves.easeOutQuart),
                        const SizedBox(height: 32),
                        
                        // Scrollable Text
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('1. Information Collection'),
                                _buildSectionText(
                                    'Vortiqen collects information from you when you register your school on our platform, fill out a form, or interact with our ERP system. The collected data may include your name, school name, email address, and demographic information.'),
                                _buildSectionTitle('2. Use of Information'),
                                _buildSectionText(
                                    'Any of the information we collect from you may be used in one of the following ways: to personalize your experience, to improve our platform, to improve customer service, or to process transactions.'),
                                _buildSectionTitle('3. Data Protection'),
                                _buildSectionText(
                                    'We implement a variety of security measures to maintain the safety of your personal and institutional information when you enter, submit, or access your information within the Vortiqen ecosystem.'),
                                _buildSectionTitle('4. Information Disclosure'),
                                _buildSectionText(
                                    'We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our website, conducting our business, or servicing you, so long as those parties agree to keep this information confidential.'),
                                _buildSectionTitle('5. Consent'),
                                _buildSectionText(
                                    'By using our site and registering your school, you consent to our privacy policy.'),
                                const SizedBox(height: 40),
                                Center(
                                  child: Text(
                                    'Last updated: June 2026',
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05, curve: Curves.easeOutQuart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F52BA), // Brand Blue
        ),
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        height: 1.6,
        color: Colors.grey.shade700,
      ),
    );
  }
}
