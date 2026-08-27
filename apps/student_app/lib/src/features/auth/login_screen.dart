import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      role: AppRole.student,
      title: 'VortiQen Student',
      subtitle: 'Sign in to access your timetable, assignments & exams',
      defaultEmail: 'student@vortiqen.com',
    );
  }
}
