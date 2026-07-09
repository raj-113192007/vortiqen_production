import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  bool build() {
    return false; // Initially not logged in
  }

  Future<bool> login(String email, String password) async {
    try {
      final dio = ref.read(apiClientProvider);
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = true;
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  void logout() {
    state = false;
  }
}
