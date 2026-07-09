import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/login';
      
      if (!isAuthenticated && !isGoingToLogin) {
        return '/login';
      }
      
      if (isAuthenticated && isGoingToLogin) {
        return '/dashboard';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const DirectorLoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DirectorDashboardScreen(),
      ),
    ],
  );
});
