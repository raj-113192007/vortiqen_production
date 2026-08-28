import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'school_master_hub_screen.dart';

class FeesScreen extends ConsumerStatefulWidget {
  const FeesScreen({super.key});

  @override
  ConsumerState<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends ConsumerState<FeesScreen> {
  @override
  Widget build(BuildContext context) {
    return const SchoolMasterHubScreen();
  }
}
