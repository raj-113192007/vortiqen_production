// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsRepository)
final analyticsRepositoryProvider = AnalyticsRepositoryProvider._();

final class AnalyticsRepositoryProvider
    extends
        $FunctionalProvider<
          AnalyticsRepository,
          AnalyticsRepository,
          AnalyticsRepository
        >
    with $Provider<AnalyticsRepository> {
  AnalyticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnalyticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyticsRepository create(Ref ref) {
    return analyticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsRepository>(value),
    );
  }
}

String _$analyticsRepositoryHash() =>
    r'03bfefbc9baf213810f9921ac7bb4fa800cd19b3';

@ProviderFor(dashboardMetrics)
final dashboardMetricsProvider = DashboardMetricsProvider._();

final class DashboardMetricsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardMetrics>,
          DashboardMetrics,
          FutureOr<DashboardMetrics>
        >
    with $FutureModifier<DashboardMetrics>, $FutureProvider<DashboardMetrics> {
  DashboardMetricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardMetricsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardMetricsHash();

  @$internal
  @override
  $FutureProviderElement<DashboardMetrics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardMetrics> create(Ref ref) {
    return dashboardMetrics(ref);
  }
}

String _$dashboardMetricsHash() => r'90cb2eaf8430f3e82a623f97aa7c003274720142';

@ProviderFor(savedReports)
final savedReportsProvider = SavedReportsProvider._();

final class SavedReportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SavedReport>>,
          List<SavedReport>,
          FutureOr<List<SavedReport>>
        >
    with
        $FutureModifier<List<SavedReport>>,
        $FutureProvider<List<SavedReport>> {
  SavedReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedReportsHash();

  @$internal
  @override
  $FutureProviderElement<List<SavedReport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SavedReport>> create(Ref ref) {
    return savedReports(ref);
  }
}

String _$savedReportsHash() => r'4e37f4deed8141edaaa4f10c3fbf2705dd3d5069';
