import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.driver,
      title: 'VortiQen Driver',
      subtitle: 'Sign in to access route stops, student boarding & live GPS',
      defaultEmail: 'driver@vortiqen.com',
    );
  }
}
