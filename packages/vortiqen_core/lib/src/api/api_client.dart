import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);
}
final apiClientProvider = Provider<ApiClient>((ref) {
  String baseUrl = 'http://localhost:3000';
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    baseUrl = 'http://10.0.2.2:3000';
  }
  
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: Attach Auth Token from secure storage
      return handler.next(options);
    },
  ));

  return ApiClient(dio);
});

/// Convenience provider for direct Dio access (used by older repositories)
final dioProvider = Provider<Dio>((ref) {
  return ref.watch(apiClientProvider).dio;
});
