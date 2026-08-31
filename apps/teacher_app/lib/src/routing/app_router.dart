import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_layout.dart';
import '../features/dashboard/home_screen.dart';
import '../features/assignments/assignments_screen.dart';
import '../features/assignments/create_assignment_screen.dart';
import '../features/attendance/mark_attendance_screen.dart';
import '../features/academics/timetable_screen.dart';
import '../features/academics/class_diary_screen.dart';
import '../features/academics/teaching_units_screen.dart';
import '../features/academics/daily_lesson_planner_screen.dart';
import '../features/calendar/teacher_calendar_screen.dart';
import '../features/profile/teacher_profile_screen.dart';
import '../features/complaints/parent_complaints_screen.dart';
import '../features/exams/exams_screen.dart';
import '../features/exams/create_exam_screen.dart';
import '../features/exams/enter_marks_screen.dart';
import '../features/students/student_roster_screen.dart';
import '../features/hr/payslips_screen.dart';
import '../features/hr/leave_application_screen.dart';
import '../features/chat/presentation/chat_list_screen.dart';
import '../features/chat/presentation/chat_room_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const VortiqenSplashScreen(
          role: AppRole.teacher,
          appTitle: 'VortiQen Teacher',
          appSubtitle: 'Academic Management & Attendance',
          nextRoute: '/login',
        ),
      ),
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
            path: '/mark-attendance',
            builder: (context, state) => const MarkAttendanceScreen(),
          ),
          GoRoute(
            path: '/academics/timetable',
            builder: (context, state) => const TimetableScreen(),
          ),
          GoRoute(
            path: '/academics/diary',
            builder: (context, state) => const ClassDiaryScreen(),
          ),
          GoRoute(
            path: '/teaching-units',
            builder: (context, state) => const TeachingUnitsScreen(),
          ),
          GoRoute(
            path: '/daily-lesson-planner',
            builder: (context, state) => const DailyLessonPlannerScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const TeacherCalendarScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const TeacherProfileScreen(),
          ),
          GoRoute(
            path: '/complaints',
            builder: (context, state) => const ParentComplaintsScreen(),
          ),
          GoRoute(
            path: '/assignments',
            builder: (context, state) => const AssignmentsScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateAssignmentScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/exams',
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
            path: '/students',
            builder: (context, state) => const StudentRosterScreen(),
          ),
          GoRoute(
            path: '/payslips',
            builder: (context, state) => const PayslipsScreen(),
          ),
          GoRoute(
            path: '/hr/leaves',
            builder: (context, state) => const LeaveApplicationScreen(),
          ),
          GoRoute(
            path: '/chat',
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
    errorBuilder: (context, state) => const DashboardLayout(child: HomeScreen()),
  );
});
