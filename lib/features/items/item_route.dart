import 'package:flutter/material.dart' hide ModalRoute;
import 'package:go_router/go_router.dart';

import '../../core/router/route_types.dart';
import 'presentation/item_detail_page.dart';

part 'item_route.g.dart';

@TypedGoRoute<ItemDetailRoute>(path: '/items/:id')
class ItemDetailRoute extends ModalRoute with $ItemDetailRoute {
  final String id;

  const ItemDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ItemDetailPage(id: id);
}
