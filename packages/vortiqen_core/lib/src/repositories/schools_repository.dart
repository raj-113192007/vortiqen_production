import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/school.dart';

class SchoolsRepository {
  SchoolsRepository();

  Future<List<School>> getSchools() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      School(
        id: 'sch_01',
        name: 'Delhi Public International School',
        code: 'DPIS01',
        address: 'Sector 14, Mathura Road',
        city: 'New Delhi',
        state: 'Delhi',
        status: 'ACTIVE',
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  Future<School> createSchool(Map<String, dynamic> schoolData) async {
    return School(
      id: 'sch_new',
      name: schoolData['name'] ?? 'New School',
      code: schoolData['code'] ?? 'SCH01',
      city: schoolData['city'] ?? 'City',
      status: 'ACTIVE',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

final schoolsRepositoryProvider = Provider<SchoolsRepository>((ref) {
  return SchoolsRepository();
});

final schoolsProvider = FutureProvider<List<School>>((ref) {
  return ref.watch(schoolsRepositoryProvider).getSchools();
});
