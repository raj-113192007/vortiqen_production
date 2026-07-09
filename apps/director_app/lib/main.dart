import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'src/routing/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DirectorApp(),
    ),
  );
}

class DirectorApp extends ConsumerWidget {
  const DirectorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'VortiQen Director',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(AppRole.director),
      routerConfig: router,
    );
  }
}
