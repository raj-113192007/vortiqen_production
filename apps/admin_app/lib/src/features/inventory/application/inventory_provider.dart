import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

final inventoryProvider = AsyncNotifierProvider<InventoryNotifier, List<Asset>>(() {
  return InventoryNotifier();
});

class InventoryNotifier extends AsyncNotifier<List<Asset>> {
  @override
  Future<List<Asset>> build() async {
    return _fetchAssets();
  }

  Future<List<Asset>> _fetchAssets({String? categoryId, String? status}) async {
    final apiClient = ref.read(apiClientProvider);
    String url = '/inventory/assets';
    
    final queryParams = <String>[];
    if (categoryId != null) queryParams.add('categoryId=$categoryId');
    if (status != null) queryParams.add('status=$status');
    
    if (queryParams.isNotEmpty) {
      url += '?${queryParams.join('&')}';
    }

    final response = await apiClient.get(url);
    final List<Asset> assets = (response.data as List)
        .map((json) => Asset.fromJson(json))
        .toList();
    return assets;
  }

  Future<void> fetchAssets({String? categoryId, String? status}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAssets(categoryId: categoryId, status: status));
  }

  Future<void> createAsset(Map<String, dynamic> data) async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.post('/inventory/assets', data: data);
    await fetchAssets();
  }

  Future<void> assignAsset(String assetId, Map<String, dynamic> data) async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.post('/inventory/assets/$assetId/assign', data: data);
    await fetchAssets();
  }
}
