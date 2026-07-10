import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
abstract class Asset with _$Asset {
  const factory Asset({
    required String id,
    required String schoolId,
    required String categoryId,
    required String name,
    String? sku,
    DateTime? purchaseDate,
    double? depreciationRate,
    @Default('AVAILABLE') String status,
    @Default('GOOD') String condition,
    String? assignedToUser,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? assignedTo,
    @Default([]) List<AssetLog> logs,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}

@freezed
abstract class AssetLog with _$AssetLog {
  const factory AssetLog({
    required String id,
    required String assetId,
    required String action,
    String? userId,
    String? adminId,
    String? notes,
    DateTime? createdAt,
  }) = _AssetLog;

  factory AssetLog.fromJson(Map<String, dynamic> json) => _$AssetLogFromJson(json);
}
