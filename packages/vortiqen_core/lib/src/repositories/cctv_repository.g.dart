// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cctv_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cctvRepository)
final cctvRepositoryProvider = CctvRepositoryProvider._();

final class CctvRepositoryProvider
    extends $FunctionalProvider<CctvRepository, CctvRepository, CctvRepository>
    with $Provider<CctvRepository> {
  CctvRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cctvRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cctvRepositoryHash();

  @$internal
  @override
  $ProviderElement<CctvRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CctvRepository create(Ref ref) {
    return cctvRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CctvRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CctvRepository>(value),
    );
  }
}

String _$cctvRepositoryHash() => r'c6d0e5bbeb577258dac5c5d1f0f4b81d2677c631';

@ProviderFor(cctvCameras)
final cctvCamerasProvider = CctvCamerasProvider._();

final class CctvCamerasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CctvCamera>>,
          List<CctvCamera>,
          FutureOr<List<CctvCamera>>
        >
    with $FutureModifier<List<CctvCamera>>, $FutureProvider<List<CctvCamera>> {
  CctvCamerasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cctvCamerasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cctvCamerasHash();

  @$internal
  @override
  $FutureProviderElement<List<CctvCamera>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CctvCamera>> create(Ref ref) {
    return cctvCameras(ref);
  }
}

String _$cctvCamerasHash() => r'2623fada5eb2eaecfe092279d6225776fe511823';
