const fs = require('fs');
const path = require('path');

const apps = [
  { name: 'parent_app', role: 'PARENT', color: 'Colors.purple' },
  { name: 'driver_app', role: 'DRIVER', color: 'Colors.amber' },
  { name: 'superadmin_app', role: 'SUPER_ADMIN', color: 'Colors.redAccent' }
];

const basePath = path.join(__dirname);

apps.forEach(app => {
  const appPath = path.join(basePath, app.name);
  
  // 1. pubspec.yaml
  const pubspec = `name: ${app.name}
description: "A new Flutter project."
publish_to: 'none'
version: 1.0.0+1
environment:
  sdk: ^3.12.1
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_riverpod: ^3.3.2
  go_router: ^17.3.0
  vortiqen_core:
    path: ../../packages/vortiqen_core
  vortiqen_ui:
    path: ../../packages/vortiqen_ui
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
flutter:
  uses-material-design: true
`;
  fs.writeFileSync(path.join(appPath, 'pubspec.yaml'), pubspec);

  // Clean lib
  const libPath = path.join(appPath, 'lib');
  if (fs.existsSync(libPath)) {
    fs.rmSync(libPath, { recursive: true, force: true });
  }
  fs.mkdirSync(libPath);
  fs.mkdirSync(path.join(libPath, 'src/routing'), { recursive: true });
  fs.mkdirSync(path.join(libPath, 'src/features/auth'), { recursive: true });
  fs.mkdirSync(path.join(libPath, 'src/features/dashboard'), { recursive: true });

  // 2. main.dart
  const mainDart = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/routing/app_router.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'VortiQen - ${app.role}',
      theme: AppTheme.darkTheme.copyWith(
        colorScheme: AppTheme.darkTheme.colorScheme.copyWith(
          primary: ${app.color},
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
`;
  fs.writeFileSync(path.join(libPath, 'main.dart'), mainDart);

  // 3. app_router.dart
  const routerDart = `import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.uri.path == '/login';
      if (!authState && !isLoggingIn) return '/login';
      if (authState && isLoggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});
`;
  fs.writeFileSync(path.join(libPath, 'src/routing/app_router.dart'), routerDart);

  // 4. login_screen.dart
  const loginDart = `import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VortiqenLoginScreen(
      appRole: Role.${app.role},
    );
  }
}
`;
  fs.writeFileSync(path.join(libPath, 'src/features/auth/login_screen.dart'), loginDart);

  // 5. dashboard_screen.dart
  const dashboardDart = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('${app.role} Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.dashboard, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'Welcome to the ${app.role} App!',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              const Text('Your customized dashboard will appear here.'),
            ],
          ),
        ),
      ),
    );
  }
}
`;
  fs.writeFileSync(path.join(libPath, 'src/features/dashboard/dashboard_screen.dart'), dashboardDart);

});
console.log('Apps scaffolded successfully!');
