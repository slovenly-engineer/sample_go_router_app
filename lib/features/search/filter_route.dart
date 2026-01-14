import 'package:flutter/material.dart' hide ModalRoute;
import 'package:go_router/go_router.dart';

import 'package:sample_go_router_app/core/router/route_types.dart';
import 'package:sample_go_router_app/features/search/presentation/filter_page.dart';

part 'filter_route.g.dart';

@TypedGoRoute<FilterRoute>(path: '/filter')
class FilterRoute extends ModalRoute with $FilterRoute {
  const FilterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FilterPage();
}
