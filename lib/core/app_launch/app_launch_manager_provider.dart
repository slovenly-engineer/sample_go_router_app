import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sample_go_router_app/core/app_launch/app_launch_manager.dart';
import 'package:sample_go_router_app/features/notifications/data/notification_service.dart';

part 'app_launch_manager_provider.g.dart';

@Riverpod(keepAlive: true)
AppLaunchManager appLaunchManager(Ref ref) {
  return AppLaunchManager(
    notificationPlugin: ref.watch(flutterLocalNotificationsPluginProvider),
  );
}
