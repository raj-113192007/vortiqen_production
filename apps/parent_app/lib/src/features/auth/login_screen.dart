import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.parent,
      title: 'VortiQen Parent',
      subtitle: 'Track your child\'s academics, fees & live bus location',
      defaultEmail: 'parent@vortiqen.com',
    );
  }
}
