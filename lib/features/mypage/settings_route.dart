part of '../../core/router/router.dart';

// MyPageRouteの下にネストするため、トップレベル定義はしないが、
// GoRouterのBuilderで親子関係を作るため、クラス自体はHierarchyRouteを継承する。
class SettingsRoute extends HierarchyRoute with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}
