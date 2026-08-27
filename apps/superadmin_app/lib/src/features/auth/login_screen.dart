import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.superAdmin,
      title: 'VortiQen SuperAdmin',
      subtitle: 'Platform Control Tower & Multi-Tenant Fleet Monitor',
      defaultEmail: 'superadmin@vortiqen.com',
    );
  }
}
