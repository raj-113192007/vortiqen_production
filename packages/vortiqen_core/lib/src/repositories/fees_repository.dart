import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fee.dart';

final feesRepositoryProvider = Provider<FeesRepository>((ref) {
  return FeesRepository();
});

final feeCategoriesProvider = FutureProvider<List<FeeCategory>>((ref) async {
  final repo = ref.read(feesRepositoryProvider);
  return repo.getCategories();
});

final feeLedgersProvider = FutureProvider.family<List<FeeLedger>, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(feesRepositoryProvider);
  return repo.getLedgers(classId: params['classId'] as String?);
});

class FeesRepository {
  FeesRepository();

  Future<List<FeeCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return [
      FeeCategory(id: 'fc_01', schoolId: 'sch_01', name: 'Tuition Fee (Q2)', amount: 15000),
      FeeCategory(id: 'fc_02', schoolId: 'sch_01', name: 'Transport Fee (Bus)', amount: 3500),
      FeeCategory(id: 'fc_03', schoolId: 'sch_01', name: 'Science & Lab Fund', amount: 2000),
    ];
  }

  Future<List<FeeLedger>> getLedgers({String? classId}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return [
      FeeLedger(
        id: 'fl_01',
        schoolId: 'sch_01',
        studentId: 'stu_01',
        categoryId: 'fc_01',
        amountDue: 15000,
        amountPaid: 15000,
        status: 'PAID',
        dueDate: DateTime.now().add(const Duration(days: 30)),
        category: FeeCategory(id: 'fc_01', schoolId: 'sch_01', name: 'Tuition Fee (Q2)', amount: 15000),
      ),
      FeeLedger(
        id: 'fl_02',
        schoolId: 'sch_01',
        studentId: 'stu_01',
        categoryId: 'fc_02',
        amountDue: 3500,
        amountPaid: 0,
        status: 'PENDING',
        dueDate: DateTime.now().add(const Duration(days: 15)),
        category: FeeCategory(id: 'fc_02', schoolId: 'sch_01', name: 'Transport Fee (Bus)', amount: 3500),
      ),
    ];
  }

  Future<void> createCategory(String name, double amount) async {}
  Future<void> generateLedgers(String categoryId, String dueDate, {String? classId}) async {}
  Future<void> recordPayment(String ledgerId, double amountPaid, String paymentMethod, {String? receiptNo}) async {}
}
