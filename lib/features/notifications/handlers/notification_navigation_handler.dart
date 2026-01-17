import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';

part 'notification_navigation_handler.g.dart';

@Riverpod(keepAlive: true)
NotificationNavigationHandler notificationNavigationHandler(Ref ref) {
  return NotificationNavigationHandler(
    navigator: ref.watch(appNavigatorProvider),
  );
}

class NotificationNavigationHandler {
  NotificationNavigationHandler({required AppNavigator navigator})
    : _navigator = navigator;
  final AppNavigator _navigator;

  /// 通知タップ時の処理
  /// NotificationServiceのinitializeでコールバックとして使用
  void handleNotificationTapped(NotificationResponse response) {
    final path = response.payload;
    if (path == null || path.isEmpty) {
      debugPrint('[WARNING] Empty payload in notification tap');
      return;
    }

    try {
      // パス文字列から直接遷移（GoRouterが有効なパスか検証）
      // navigateTo は Future を返すが、ここでは結果を待たない（fire-and-forget）
      unawaited(_navigator.navigateToPath<void>(path));
    } on Exception catch (e) {
      debugPrint(
        '[ERROR] Failed to navigate from notification tap: path=$path, error=$e',
      );
      // エラーをre-throwせず、ログ出力のみで継続
    }
  }
}
