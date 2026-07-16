import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'src/routing/app_router.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://630cd9e6e0b644c4e7345aa7fa0b61d0@o4511742567841792.ingest.de.sentry.io/4511742574329936';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
    const ProviderScope(
      child: StudentApp(),
    ),
  );,
  );
}

class StudentApp extends ConsumerWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'VortiQen Student',
      theme: AppTheme.getTheme(AppRole.student),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
