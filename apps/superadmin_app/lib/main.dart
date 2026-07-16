import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/routing/app_router.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://630cd9e6e0b644c4e7345aa7fa0b61d0@o4511742567841792.ingest.de.sentry.io/4511742574329936';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );,
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'VortiQen - SUPER_ADMIN',
      theme: AppTheme.getTheme(AppRole.admin),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
