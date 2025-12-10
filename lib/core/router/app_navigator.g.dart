// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_navigator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appNavigator)
const appNavigatorProvider = AppNavigatorProvider._();

final class AppNavigatorProvider
    extends $FunctionalProvider<AppNavigator, AppNavigator, AppNavigator>
    with $Provider<AppNavigator> {
  const AppNavigatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNavigatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNavigatorHash();

  @$internal
  @override
  $ProviderElement<AppNavigator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppNavigator create(Ref ref) {
    return appNavigator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppNavigator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppNavigator>(value),
    );
  }
}

String _$appNavigatorHash() => r'721290aa5dec20e371f8ac87bac7f0ebe4526ea6';
