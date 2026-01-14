part of '../../core/router/router.dart';

// HomeRouteの下にネストするため、トップレベル定義はしないが、
// GoRouterのBuilderで親子関係を作るため、クラス自体はHierarchyRouteを継承する。
class ItemDetailRoute extends HierarchyRoute with $ItemDetailRoute {
  final String id;

  const ItemDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ItemDetailPage(id: id);
}
