import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fee.dart';
import 'api_client.dart';

final feesRepositoryProvider = Provider<FeesRepository>((ref) {
  return FeesRepository(ref.read(apiClientProvider));
});

final feeCategoriesProvider = FutureProvider<List<FeeCategory>>((ref) async {
  final repo = ref.read(feesRepositoryProvider);
  return repo.getCategories();
});

final feeLedgersProvider = FutureProvider.family<List<FeeLedger>, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(feesRepositoryProvider);
  return repo.getLedgers(classId: params['classId']);
});

class FeesRepository {
  final ApiClient _apiClient;

  FeesRepository(this._apiClient);

  Future<List<FeeCategory>> getCategories() async {
    try {
      final response = await _apiClient.dio.get('/api/v1/fees/categories');
      return (response.data as List).map((x) => FeeCategory.fromJson(x)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch fee categories');
    }
  }

  Future<List<FeeLedger>> getLedgers({String? classId}) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/v1/fees/ledgers',
        queryParameters: {
          if (classId != null) 'classId': classId,
        },
      );
      return (response.data as List).map((x) => FeeLedger.fromJson(x)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch fee ledgers');
    }
  }

  Future<void> createCategory(String name, double amount) async {
    try {
      await _apiClient.dio.post(
        '/api/v1/fees/categories',
        data: {'name': name, 'amount': amount},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to create category');
    }
  }

  Future<void> generateLedgers(String categoryId, String dueDate, {String? classId}) async {
    try {
      await _apiClient.dio.post(
        '/api/v1/fees/ledgers/generate',
        data: {
          'categoryId': categoryId,
          'dueDate': dueDate,
          if (classId != null) 'classId': classId,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to generate ledgers');
    }
  }

  Future<void> recordPayment(String ledgerId, double amountPaid, String paymentMethod, {String? receiptNo}) async {
    try {
      await _apiClient.dio.post(
        '/api/v1/fees/pay',
        data: {
          'ledgerId': ledgerId,
          'amountPaid': amountPaid,
          'paymentMethod': paymentMethod,
          if (receiptNo != null) 'receiptNo': receiptNo,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to record payment');
    }
  }
}
