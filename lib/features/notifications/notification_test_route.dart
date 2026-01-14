import 'package:flutter/material.dart' hide ModalRoute;
import 'package:go_router/go_router.dart';
import '../../core/router/route_types.dart';
import 'presentation/notification_test_page.dart';

part 'notification_test_route.g.dart';

@TypedGoRoute<NotificationTestRoute>(
  path: '/notification-test',
)
class NotificationTestRoute extends ModalRoute with $NotificationTestRoute {
  const NotificationTestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationTestPage();
  }
}
