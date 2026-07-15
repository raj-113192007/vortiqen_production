import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
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
    return const AuthState(); // Initially not logged in
  }

  Future<bool> login(String email, String password) async {
    try {
      final dio = ref.read(apiClientProvider);
      final response = await dio.dio.post('/api/v1/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = User.fromJson(response.data['user']);
        final token = response.data['access_token'] as String;
        state = AsyncData(AuthState(user: user, token: token));
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  void logout() {
    state = const AsyncData(AuthState());
  }
}
