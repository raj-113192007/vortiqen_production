import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
                              'Terms of Service',
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
                                _buildSectionTitle('1. Acceptance of Terms'),
                                _buildSectionText(
                                    'By accessing and using the Vortiqen ERP Admin Ecosystem, you accept and agree to be bound by the terms and provision of this agreement. Registration is mandatory to use our school management services.'),
                                _buildSectionTitle('2. User License'),
                                _buildSectionText(
                                    'Permission is granted to temporarily download one copy of the materials (information or software) on Vortiqen\'s website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.'),
                                _buildSectionTitle('3. Disclaimer'),
                                _buildSectionText(
                                    'The materials on Vortiqen\'s web ecosystem are provided on an \'as is\' basis. Vortiqen makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.'),
                                _buildSectionTitle('4. Limitations'),
                                _buildSectionText(
                                    'In no event shall Vortiqen or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Vortiqen\'s ecosystem.'),
                                _buildSectionTitle('5. Revisions and Errata'),
                                _buildSectionText(
                                    'The materials appearing on Vortiqen could include technical, typographical, or photographic errors. Vortiqen does not warrant that any of the materials on its ecosystem are accurate, complete, or current.'),
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
