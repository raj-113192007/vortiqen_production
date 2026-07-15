import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VortiqenLoginScreen(
      title: 'Driver Portal',
      subtitle: 'Manage your routes and vehicles',
      primaryColor: Colors.amber,
    );
  }
}
