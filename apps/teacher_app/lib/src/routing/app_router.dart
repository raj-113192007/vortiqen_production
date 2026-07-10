import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_layout.dart';
import '../features/dashboard/home_screen.dart';
import '../features/assignments/assignments_screen.dart';
import '../features/assignments/create_assignment_screen.dart';
import '../features/attendance/mark_attendance_screen.dart';
import '../features/exams/exams_screen.dart';
import '../features/exams/create_exam_screen.dart';
import '../features/exams/enter_marks_screen.dart';
import '../features/hr/payslips_screen.dart';
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
      ShellRoute(
        builder: (context, state, child) {
          return DashboardLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: 'assignments',
            builder: (context, state) => const AssignmentsScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateAssignmentScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'mark-attendance',
            builder: (context, state) => const MarkAttendanceScreen(),
          ),
          GoRoute(
            path: 'exams',
            builder: (context, state) => const ExamsScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateExamScreen(),
              ),
              GoRoute(
                path: 'subjects/:id/marks',
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>;
                  return EnterMarksScreen(
                    subject: extra['subject'] as ExamSubject,
                    classId: extra['classId'] as String,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'payslips',
            builder: (context, state) => const PayslipsScreen(),
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
