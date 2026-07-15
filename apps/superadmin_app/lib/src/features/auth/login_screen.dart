import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      title: 'VortiQen Super Admin',
      subtitle: 'Platform Management Portal',
      primaryColor: Colors.deepPurple,
    );
  }
}
