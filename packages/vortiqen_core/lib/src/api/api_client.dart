import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000', // TODO: Update from .env
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Example: Attach Auth Token
      return handler.next(options);
    },
  ));

  return ApiClient(dio);
}
