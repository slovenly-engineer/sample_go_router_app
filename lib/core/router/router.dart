import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Import Root Routes
import '../../features/auth/login_route.dart';
// Import Pages (moved from part files)
import '../../features/home/presentation/home_page.dart';
import '../../features/items/item_route.dart';
import '../../features/mypage/presentation/mypage_page.dart';
import '../../features/mypage/presentation/settings_page.dart';
import '../../features/search/filter_route.dart';
import '../../features/search/presentation/search_page.dart';
import 'route_types.dart'; // HierarchyRoute, ModalRoute
import 'scaffold_with_nav_bar.dart';

// Part files (Shell Routes)
part '../../features/home/home_route.dart';
part '../../features/mypage/mypage_route.dart';
part '../../features/mypage/settings_route.dart';
part '../../features/search/search_route.dart';
part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      // 1. StatefulShellRoute (Bottom Navigation)
      $mainDataShellRoute,

      // 2. Root Routes (Cover BottomNav)
      $loginRoute,
      $itemDetailRoute,
      $filterRoute,
    ],
  );
}

@TypedStatefulShellRoute<MainDataShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<SearchRoute>(path: '/search')],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<MyPageRoute>(
          path: '/mypage',
          routes: [TypedGoRoute<SettingsRoute>(path: 'settings')],
        ),
      ],
    ),
  ],
)
class MainDataShellRoute extends StatefulShellRouteData {
  const MainDataShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}
