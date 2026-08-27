import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.director,
      title: 'VortiQen Director',
      subtitle: 'Executive Institutional Oversight, Finances & Growth',
      defaultEmail: 'director@vortiqen.com',
    );
  }
}
