// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$itemDetailRoute];

RouteBase get $itemDetailRoute => GoRouteData.$route(
  path: '/items/:id',
  factory: $ItemDetailRoute._fromState,
);

mixin $ItemDetailRoute on GoRouteData {
  static ItemDetailRoute _fromState(GoRouterState state) =>
      ItemDetailRoute(id: state.pathParameters['id']!);

  ItemDetailRoute get _self => this as ItemDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/items/${Uri.encodeComponent(_self.id)}');

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
