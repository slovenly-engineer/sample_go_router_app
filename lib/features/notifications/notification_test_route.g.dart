// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_test_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$notificationTestRoute];

RouteBase get $notificationTestRoute => GoRouteData.$route(
  path: '/notification-test',
  factory: $NotificationTestRoute._fromState,
);

mixin $NotificationTestRoute on GoRouteData {
  static NotificationTestRoute _fromState(GoRouterState state) =>
      const NotificationTestRoute();

  @override
  String get location => GoRouteData.$location('/notification-test');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
