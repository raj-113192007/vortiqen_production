// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superadmin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(superadminRepository)
final superadminRepositoryProvider = SuperadminRepositoryProvider._();

final class SuperadminRepositoryProvider
    extends
        $FunctionalProvider<
          SuperadminRepository,
          SuperadminRepository,
          SuperadminRepository
        >
    with $Provider<SuperadminRepository> {
  SuperadminRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'superadminRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$superadminRepositoryHash();

  @$internal
  @override
  $ProviderElement<SuperadminRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SuperadminRepository create(Ref ref) {
    return superadminRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SuperadminRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SuperadminRepository>(value),
    );
  }
}

String _$superadminRepositoryHash() =>
    r'81ca2e306567b69af715b7d2e7d4b352645bd17c';

@ProviderFor(platformStats)
final platformStatsProvider = PlatformStatsProvider._();

final class PlatformStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlatformStats>,
          PlatformStats,
          FutureOr<PlatformStats>
        >
    with $FutureModifier<PlatformStats>, $FutureProvider<PlatformStats> {
  PlatformStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$platformStatsHash();

  @$internal
  @override
  $FutureProviderElement<PlatformStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlatformStats> create(Ref ref) {
    return platformStats(ref);
  }
}

String _$platformStatsHash() => r'276121525eba4da3cb5549fcce5a3c18b22e26b6';

@ProviderFor(allSchools)
final allSchoolsProvider = AllSchoolsProvider._();

final class AllSchoolsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<School>>,
          List<School>,
          FutureOr<List<School>>
        >
    with $FutureModifier<List<School>>, $FutureProvider<List<School>> {
  AllSchoolsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSchoolsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSchoolsHash();

  @$internal
  @override
  $FutureProviderElement<List<School>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<School>> create(Ref ref) {
    return allSchools(ref);
  }
}

String _$allSchoolsHash() => r'16321e263e6d27008a9a2e69bcb773fb223f460b';
