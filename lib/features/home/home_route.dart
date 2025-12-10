part of '../../core/router/router.dart';

class HomeRoute extends HierarchyRoute with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
