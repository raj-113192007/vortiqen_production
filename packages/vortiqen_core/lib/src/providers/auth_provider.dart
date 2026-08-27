import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'auth_provider.g.dart';

class AuthState {
  final User? user;
  final String? token;
  const AuthState({this.user, this.token});
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  FutureOr<AuthState> build() {
    return const AuthState();
  }

  Future<bool> login(String email, String password) async {
    // Offline / Mock Standalone Mode: Instant login with role-specific mock user
    await Future.delayed(const Duration(milliseconds: 300));

    final normalized = email.toLowerCase();
    String role = 'SCHOOL_ADMIN';
    String name = 'Principal Sharma';

    if (normalized.contains('teacher')) {
      role = 'TEACHER';
      name = 'Dr. Priya Verma';
    } else if (normalized.contains('student') || normalized.contains('stu')) {
      role = 'STUDENT';
      name = 'Aarav Sharma';
    } else if (normalized.contains('parent')) {
      role = 'PARENT';
      name = 'Rajesh Sharma';
    } else if (normalized.contains('driver')) {
      role = 'DRIVER';
      name = 'Ramesh Kumar (Route 04)';
    } else if (normalized.contains('director')) {
      role = 'DIRECTOR';
      name = 'Director S. K. Gupta';
    } else if (normalized.contains('superadmin')) {
      role = 'SUPER_ADMIN';
      name = 'Platform SuperAdmin';
    }

    final mockUser = User(
      id: 'mock_user_101',
      username: email,
      email: email,
      name: name,
      role: role,
      status: 'ACTIVE',
      schoolId: 'school_delhi_01',
      phone: '+91 98765 43210',
    );

    state = AsyncData(AuthState(user: mockUser, token: 'mock_jwt_token_offline_mode'));
    return true;
  }

  void logout() {
    state = const AsyncData(AuthState());
  }
}
