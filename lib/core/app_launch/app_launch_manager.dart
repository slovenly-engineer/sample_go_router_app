import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_go_router_app/core/app_launch/app_launch_info.dart';

/// アプリ起動時の情報を収集・管理するマネージャー
///
/// 使用後は自動的に情報をクリアするため、二重使用を防止
class AppLaunchManager {
  AppLaunchManager({
    required FlutterLocalNotificationsPlugin notificationPlugin,
  }) : _notificationPlugin = notificationPlugin;

  final FlutterLocalNotificationsPlugin _notificationPlugin;

  AppLaunchInfo? _launchInfo;
  bool _consumed = false;

  /// アプリ起動情報を収集
  ///
  /// main()から一度だけ呼び出される
  /// 通知、ディープリンクなど、すべての起動ソースを確認
  Future<void> collectLaunchInfo() async {
    // 通知からの起動を確認
    final notificationDetails =
        await _notificationPlugin.getNotificationAppLaunchDetails();

    if (notificationDetails?.didNotificationLaunchApp ?? false) {
      final path = notificationDetails?.notificationResponse?.payload;
      if (path != null && path.isNotEmpty) {
        _launchInfo = AppLaunchInfo(
          source: AppLaunchSource.notification,
          path: path,
        );
        debugPrint('[INFO] App launched from notification: $path');
        return;
      }
    }

    // 将来の拡張: ディープリンクからの起動
    // final initialUri = await getInitialUri();
    // if (initialUri != null) {
    //   _launchInfo = AppLaunchInfo(
    //     source: AppLaunchSource.deepLink,
    //     path: initialUri.path,
    //     payload: {'uri': initialUri.toString()},
    //   );
    //   debugPrint('[INFO] App launched from deep link: $initialUri');
    //   return;
    // }

    // 通常起動
    _launchInfo = const AppLaunchInfo(source: AppLaunchSource.normal);
  }

  /// 起動情報を取得して消費（一度だけ取得可能）
  ///
  /// GoRouterのredirectから呼ばれる
  AppLaunchInfo? consumeLaunchInfo() {
    if (_consumed || _launchInfo == null) {
      return null;
    }
    _consumed = true;
    final info = _launchInfo;
    debugPrint('[INFO] Launch info consumed: ${info?.source}');
    return info;
  }

  /// 起動情報があるか確認（消費せずに確認のみ）
  @visibleForTesting
  bool hasLaunchInfo() => !_consumed && _launchInfo != null;
}
