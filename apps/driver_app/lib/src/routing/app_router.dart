import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/shift/driver_shift_route_screen.dart';
import '../features/scanner/driver_qr_scanner_screen.dart';
import '../features/navigation/driver_navigation_screen.dart';
import '../features/sos/driver_sos_screen.dart';
import '../features/logs/driver_vehicle_log_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.uri.path == '/splash';
      if (isSplash) return null;

      final isLoggedIn = authState.value?.token != null;
      final isLoggingIn = state.uri.path == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const VortiqenSplashScreen(
          role: AppRole.driver,
          appTitle: 'VortiQen Driver',
          appSubtitle: 'Fleet Telemetry & Student Transit Command',
          nextRoute: '/login',
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/shift-route',
        builder: (context, state) => const DriverShiftRouteScreen(),
      ),
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const DriverQrScannerScreen(),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) => const DriverNavigationScreen(),
      ),
      GoRoute(
        path: '/sos',
        builder: (context, state) => const DriverSosScreen(),
      ),
      GoRoute(
        path: '/vehicle-log',
        builder: (context, state) => const DriverVehicleLogScreen(),
      ),
    ],
  );
});
