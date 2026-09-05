import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/hud/director_command_hud_screen.dart';
import '../features/finance/director_cash_flow_screen.dart';
import '../features/academics/director_academic_matrix_screen.dart';
import '../features/admissions/director_admissions_funnel_screen.dart';
import '../features/approvals/director_approvals_screen.dart';

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
          role: AppRole.director,
          appTitle: 'VortiQen Director',
          appSubtitle: 'Executive Governance & Institutional Growth',
          nextRoute: '/login',
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DirectorDashboardScreen(),
      ),
      GoRoute(
        path: '/command-hud',
        builder: (context, state) => const DirectorCommandHudScreen(),
      ),
      GoRoute(
        path: '/cash-flow',
        builder: (context, state) => const DirectorCashFlowScreen(),
      ),
      GoRoute(
        path: '/academic-matrix',
        builder: (context, state) => const DirectorAcademicMatrixScreen(),
      ),
      GoRoute(
        path: '/admissions-funnel',
        builder: (context, state) => const DirectorAdmissionsFunnelScreen(),
      ),
      GoRoute(
        path: '/approvals',
        builder: (context, state) => const DirectorApprovalsScreen(),
      ),
    ],
  );
});
