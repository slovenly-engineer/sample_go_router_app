part of '../../core/router/router.dart';

class MyPageRoute extends HierarchyRoute with $MyPageRoute {
  const MyPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MyPagePage();
}
