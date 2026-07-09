import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/schools_repository.dart';
import '../models/school.dart';
import '../api/api_client.dart';

final schoolsRepositoryProvider = Provider<SchoolsRepository>((ref) {
  return SchoolsRepository(ref.watch(apiClientProvider));
});

final schoolsProvider = FutureProvider<List<School>>((ref) async {
  final repo = ref.watch(schoolsRepositoryProvider);
  return repo.getSchools();
});
