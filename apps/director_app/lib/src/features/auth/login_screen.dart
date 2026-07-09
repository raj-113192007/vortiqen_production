import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorLoginScreen extends StatelessWidget {
  const DirectorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return VortiqenLoginScreen(
      title: 'VortiQen Director',
      subtitle: 'Manage your school at a glance',
      primaryColor: Theme.of(context).colorScheme.primary, // Gold
    );
  }
}
