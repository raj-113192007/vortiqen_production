import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.admin,
      title: 'VortiQen Admin',
      subtitle: 'Sign in to manage your school ecosystem & staff',
      defaultEmail: 'schooladmin@vortiqen.com',
    );
  }
}
