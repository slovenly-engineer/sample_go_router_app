import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sample_go_router_app/core/router/route_types.dart';
import 'package:sample_go_router_app/core/router/scaffold_with_nav_bar.dart';
import 'package:sample_go_router_app/features/auth/login_route.dart';
import 'package:sample_go_router_app/features/home/presentation/home_page.dart';
import 'package:sample_go_router_app/features/items/presentation/item_detail_page.dart';
import 'package:sample_go_router_app/features/mypage/presentation/mypage_page.dart';
import 'package:sample_go_router_app/features/mypage/presentation/settings_page.dart';
import 'package:sample_go_router_app/features/notifications/notification_test_route.dart';
import 'package:sample_go_router_app/features/search/presentation/filter_page.dart';
import 'package:sample_go_router_app/features/search/presentation/search_page.dart';

// Part files (Shell Routes)
part '../../features/home/home_route.dart';
part '../../features/mypage/mypage_route.dart';
part '../../features/mypage/settings_route.dart';
part '../../features/search/search_route.dart';
part '../../features/search/filter_route.dart';
part '../../features/items/item_route.dart';
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
      $notificationTestRoute,
    ],
  );
}

@TypedStatefulShellRoute<MainDataShellRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/home',
          routes: [TypedGoRoute<ItemDetailRoute>(path: 'items/:id')],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<SearchRoute>(
          path: '/search',
          routes: [TypedGoRoute<FilterRoute>(path: 'filter')],
        ),
      ],
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
