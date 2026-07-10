import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_models/vortiqen_models.dart';

final admissionsProvider = FutureProvider.autoDispose<List<AdmissionEnquiry>>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  final response = await apiClient.get('/admissions/enquiries');
  
  if (response.statusCode == 200) {
    final List data = response.data;
    return data.map((json) => AdmissionEnquiry.fromJson(json)).toList();
  }
  throw Exception('Failed to load admissions');
});

final updateEnquiryProvider = Provider((ref) => (String id, String status) async {
  final apiClient = ref.read(apiClientProvider);
  await apiClient.patch('/admissions/enquiry/$id', data: {'status': status});
  ref.invalidate(admissionsProvider);
});
