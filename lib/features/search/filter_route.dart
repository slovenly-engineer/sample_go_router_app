part of '../../core/router/router.dart';

// SearchRouteの下にネストするため、トップレベル定義はしないが、
// GoRouterのBuilderで親子関係を作るため、クラス自体はHierarchyRouteを継承する。
class FilterRoute extends HierarchyRoute with $FilterRoute {
  const FilterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FilterPage();
}
