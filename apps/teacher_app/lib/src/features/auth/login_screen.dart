import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.teacher,
      title: 'VortiQen Teacher',
      subtitle: 'Sign in to manage classes, attendance & exams',
      defaultEmail: 'teacher@vortiqen.com',
    );
  }
}
