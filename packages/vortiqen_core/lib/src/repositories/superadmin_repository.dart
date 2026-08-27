import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/platform_stats.dart';
import '../models/school.dart';

class SuperadminRepository {
  SuperadminRepository();

  Future<PlatformStats> getStats() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const PlatformStats(
      totalSchools: 18,
      totalUsers: 4320,
      totalStudents: 3850,
      totalRevenue: 1151150,
    );
  }

  Future<List<School>> getSchools() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      School(
        id: 'sch_01',
        name: 'Delhi Public International School',
        code: 'DPIS01',
        city: 'New Delhi',
        status: 'ACTIVE',
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now(),
      ),
      School(
        id: 'sch_02',
        name: 'St. Xavier Global Academy',
        code: 'SXGA02',
        city: 'Bengaluru',
        status: 'ACTIVE',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
        updatedAt: DateTime.now(),
      ),
      School(
        id: 'sch_03',
        name: 'Greenwood World School',
        code: 'GWWS03',
        city: 'Pune',
        status: 'TRIAL',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now(),
      ),
      School(
        id: 'sch_04',
        name: 'Heritage Valley Convent',
        code: 'HVC04',
        city: 'Jaipur',
        status: 'ACTIVE',
        createdAt: DateTime.now().subtract(const Duration(days: 120)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  Future<School> updateSchoolStatus(String id, String status) async {
    return School(
      id: id,
      name: 'Updated School',
      code: 'SCH01',
      city: 'Delhi',
      status: status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

final superadminRepositoryProvider = Provider<SuperadminRepository>((ref) {
  return SuperadminRepository();
});

final platformStatsProvider = FutureProvider<PlatformStats>((ref) {
  return ref.watch(superadminRepositoryProvider).getStats();
});

final allSchoolsProvider = FutureProvider<List<School>>((ref) {
  return ref.watch(superadminRepositoryProvider).getSchools();
});
