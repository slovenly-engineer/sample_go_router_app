part of '../../core/router/router.dart';

class SearchRoute extends HierarchyRoute with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SearchPage();
}
