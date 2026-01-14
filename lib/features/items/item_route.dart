import 'package:flutter/material.dart' hide ModalRoute;
import 'package:go_router/go_router.dart';

import 'package:sample_go_router_app/core/router/route_types.dart';
import 'package:sample_go_router_app/features/items/presentation/item_detail_page.dart';

part 'item_route.g.dart';

@TypedGoRoute<ItemDetailRoute>(path: '/items/:id')
class ItemDetailRoute extends ModalRoute with $ItemDetailRoute {
  const ItemDetailRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ItemDetailPage(id: id);
}
