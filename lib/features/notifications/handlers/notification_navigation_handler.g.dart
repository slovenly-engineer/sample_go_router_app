// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_navigation_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationNavigationHandler)
const notificationNavigationHandlerProvider =
    NotificationNavigationHandlerProvider._();

final class NotificationNavigationHandlerProvider
    extends
        $FunctionalProvider<
          NotificationNavigationHandler,
          NotificationNavigationHandler,
          NotificationNavigationHandler
        >
    with $Provider<NotificationNavigationHandler> {
  const NotificationNavigationHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationNavigationHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationNavigationHandlerHash();

  @$internal
  @override
  $ProviderElement<NotificationNavigationHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationNavigationHandler create(Ref ref) {
    return notificationNavigationHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationNavigationHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationNavigationHandler>(
        value,
      ),
    );
  }
}

String _$notificationNavigationHandlerHash() =>
    r'80b41bbc425e019a200b1d026ee02cab6ec397ce';
