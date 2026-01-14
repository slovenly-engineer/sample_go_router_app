import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/router/app_navigator.dart';

part 'notification_navigation_handler.g.dart';

@Riverpod(keepAlive: true)
NotificationNavigationHandler notificationNavigationHandler(Ref ref) {
  return NotificationNavigationHandler(
    navigator: ref.watch(appNavigatorProvider),
  );
}

class NotificationNavigationHandler {
  final AppNavigator _navigator;

  NotificationNavigationHandler({
    required AppNavigator navigator,
  }) : _navigator = navigator;

  /// 通知タップ時の処理
  /// NotificationServiceのinitializeでコールバックとして使用
  void handleNotificationTapped(NotificationResponse response) {
    final path = response.payload;
    if (path == null || path.isEmpty) return;

    // パス文字列から直接遷移（GoRouterが有効なパスか検証）
    _navigator.navigateToPath(path);
  }
}
