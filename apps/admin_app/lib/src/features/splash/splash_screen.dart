import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final authState = ref.read(authProvider);
        final isLoggedIn = authState.value?.token != null;
        if (isLoggedIn) {
          context.go('/dashboard');
        } else {
          context.go('/login');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC), // Light grey-blue background
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The main card containing the logo
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 120, // Adjust size as needed based on the image proportions
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'VORTIQEN',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          color: Color(0xFF322A7D),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutQuart),
              const SizedBox(height: 40),
              
              // App Title
              const Text(
                'Vortiqen',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C4FE5), // Purple-indigo color
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2, curve: Curves.easeOutQuart),
              const SizedBox(height: 8),
              
              // Subtitle
              const Text(
                'SCHOOL ADMINISTRATION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.0,
                  color: Color(0xFF8C93A1),
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: 0.2, curve: Curves.easeOutQuart),
              
              const SizedBox(height: 80),
              
              // Custom Loading Indicator (Moving Pill)
              _buildLoadingIndicator().animate().fadeIn(delay: 600.ms, duration: 800.ms),
              
              const SizedBox(height: 16),
              
              // Loading Text
              const Text(
                'Initializing Admin Panel...',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA0A5B1),
                ),
              ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.2, curve: Curves.easeOutQuart),
              
              const SizedBox(height: 60),
              
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 16,
                    color: Color(0xFFA0A5B1),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Powered by Krypzen',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA0A5B1),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms, duration: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    const double trackWidth = 60.0;
    const double trackHeight = 12.0;
    const double pillWidth = 24.0;
    
    return Container(
      width: trackWidth,
      height: trackHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(trackHeight / 2),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final maxOffset = trackWidth - pillWidth;
          final currentOffset = maxOffset * _animation.value;
          
          return Stack(
            children: [
              Positioned(
                left: currentOffset,
                top: 0,
                bottom: 0,
                child: Container(
                  width: pillWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C4FE5),
                    borderRadius: BorderRadius.circular(trackHeight / 2),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
