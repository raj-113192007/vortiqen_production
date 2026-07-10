import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/admissions/admissions_form_screen.dart';
import '../features/inventory/presentation/inventory_list_screen.dart';
import '../features/inventory/presentation/asset_form_screen.dart';
import '../features/analytics/presentation/analytics_dashboard_screen.dart';
import '../features/analytics/presentation/reports_list_screen.dart';
import '../features/cctv/presentation/cctv_player_screen.dart';
import '../features/exams/presentation/exams_list_screen.dart';
import '../features/exams/presentation/exam_details_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.value?.token != null;
      final isLoggingIn = state.uri.path == '/login';
      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/dashboard';
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
      GoRoute(
        path: '/admissions/new',
        builder: (context, state) => const AdmissionsFormScreen(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) => const InventoryListScreen(),
      ),
      GoRoute(
        path: '/inventory/new',
        builder: (context, state) => const AssetFormScreen(),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsDashboardScreen(),
      ),
      GoRoute(
        path: '/analytics/reports',
        builder: (context, state) => const ReportsListScreen(),
      ),
      GoRoute(
        path: '/cctv/player',
        builder: (context, state) => CctvPlayerScreen(camera: state.extra as CctvCamera),
      ),
      GoRoute(
        path: '/exams',
        builder: (context, state) => const ExamsListScreen(),
      ),
      GoRoute(
        path: '/exams/:id',
        builder: (context, state) => ExamDetailsScreen(exam: state.extra as Exam),
      ),
    ],
  );
});
