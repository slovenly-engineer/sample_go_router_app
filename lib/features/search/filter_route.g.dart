// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$filterRoute];

RouteBase get $filterRoute =>
    GoRouteData.$route(path: '/filter', factory: $FilterRoute._fromState);

mixin $FilterRoute on GoRouteData {
  static FilterRoute _fromState(GoRouterState state) => const FilterRoute();

  @override
  String get location => GoRouteData.$location('/filter');

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
