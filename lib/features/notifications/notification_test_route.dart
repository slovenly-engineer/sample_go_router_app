import 'package:flutter/material.dart' hide ModalRoute;
import 'package:go_router/go_router.dart';
import 'package:sample_go_router_app/core/router/route_types.dart';
import 'package:sample_go_router_app/features/notifications/presentation/notification_test_page.dart';

part 'notification_test_route.g.dart';

@TypedGoRoute<NotificationTestRoute>(path: '/notification-test')
class NotificationTestRoute extends ModalRoute<void>
    with $NotificationTestRoute {
  const NotificationTestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationTestPage();
  }
}
