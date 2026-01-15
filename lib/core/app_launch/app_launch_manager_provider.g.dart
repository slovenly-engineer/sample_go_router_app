// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_launch_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appLaunchManager)
final appLaunchManagerProvider = AppLaunchManagerProvider._();

final class AppLaunchManagerProvider
    extends
        $FunctionalProvider<
          AppLaunchManager,
          AppLaunchManager,
          AppLaunchManager
        >
    with $Provider<AppLaunchManager> {
  AppLaunchManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLaunchManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLaunchManagerHash();

  @$internal
  @override
  $ProviderElement<AppLaunchManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLaunchManager create(Ref ref) {
    return appLaunchManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLaunchManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLaunchManager>(value),
    );
  }
}

String _$appLaunchManagerHash() => r'0a508bdf6bd4ec56ae83154a11f0f5ba3f86cd33';
