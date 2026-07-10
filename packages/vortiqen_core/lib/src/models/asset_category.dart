import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_category.freezed.dart';
part 'asset_category.g.dart';

@freezed
class AssetCategory with _$AssetCategory {
  const factory AssetCategory({
    required String id,
    required String schoolId,
    required String name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AssetCategory;

  factory AssetCategory.fromJson(Map<String, dynamic> json) => _$AssetCategoryFromJson(json);
}
