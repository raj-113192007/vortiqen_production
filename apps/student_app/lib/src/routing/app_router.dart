import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/assignments/submit_assignment_screen.dart';
import '../features/chat/presentation/chat_list_screen.dart';
import '../features/chat/presentation/chat_room_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.value?.token != null;
      final isLoggingIn = state.uri.path == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'assignments/:id/submit',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return SubmitAssignmentScreen(assignmentId: id);
            },
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => const ChatListScreen(),
            routes: [
              GoRoute(
                path: 'group/:id',
                builder: (context, state) {
                  final group = state.extra as ChatGroup;
                  return ChatRoomScreen(group: group);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
