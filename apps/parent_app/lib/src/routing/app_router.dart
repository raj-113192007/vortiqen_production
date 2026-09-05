import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/child/child_detail_screen.dart';
import '../features/transport/parent_bus_radar_screen.dart';
import '../features/homework/parent_homework_screen.dart';
import '../features/attendance/parent_attendance_leave_screen.dart';
import '../features/fees/parent_fee_payment_screen.dart';
import '../features/ptm/parent_ptm_booking_screen.dart';
import '../features/reports/parent_report_card_screen.dart';
import '../features/notices/parent_notices_screen.dart';

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
          role: AppRole.parent,
          appTitle: 'VortiQen Parent',
          appSubtitle: 'Child Safety, Academics & Engagement',
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
        path: '/child/:id',
        builder: (context, state) => ChildDetailScreen(studentId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/bus-radar',
        builder: (context, state) => const ParentBusRadarScreen(),
      ),
      GoRoute(
        path: '/homework',
        builder: (context, state) => const ParentHomeworkScreen(),
      ),
      GoRoute(
        path: '/attendance-leave',
        builder: (context, state) => const ParentAttendanceLeaveScreen(),
      ),
      GoRoute(
        path: '/fees',
        builder: (context, state) => const ParentFeePaymentScreen(),
      ),
      GoRoute(
        path: '/ptm',
        builder: (context, state) => const ParentPtmBookingScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ParentReportCardScreen(),
      ),
      GoRoute(
        path: '/notices',
        builder: (context, state) => const ParentNoticesScreen(),
      ),
    ],
  );
});
