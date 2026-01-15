import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/platform/platform_detector.dart';
import '../handlers/notification_navigation_handler.dart';

part 'notification_service.g.dart';

/// バックグラウンド通知タップ時のハンドラー
/// アプリがバックグラウンドまたは終了状態で通知をタップした場合に呼ばれる
/// 注意: この関数は別のisolateで実行されるため、Providerへのアクセスは不可
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  debugPrint('Background notification tapped: ${response.payload}');
}

@Riverpod(keepAlive: true)
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  return NotificationService(
    plugin: ref.watch(flutterLocalNotificationsPluginProvider),
    navigationHandler: ref.watch(notificationNavigationHandlerProvider),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationNavigationHandler _navigationHandler;

  NotificationService({
    required FlutterLocalNotificationsPlugin plugin,
    required NotificationNavigationHandler navigationHandler,
  }) : _plugin = plugin,
       _navigationHandler = navigationHandler;

  /// 初期化
  /// initSettingsは内部で定義（固定値）
  /// 通知タップ時の処理はNotificationNavigationHandlerに委譲
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // iOS権限リクエストは requestPermissions() で実施するため、ここでは無効化
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // 通知タップ時の処理はNotificationNavigationHandlerに委譲
    // バックグラウンド/終了状態での通知タップはnotificationTapBackgroundで処理
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse:
          _navigationHandler.handleNotificationTapped,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await requestPermissions();
  }

  /// 通知権限をリクエスト
  /// プラットフォームに応じて適切な権限リクエストを実行
  Future<void> requestPermissions() async {
    // Webでは通知権限リクエストは不要
    if (PlatformDetector.instance.isWeb) {
      return;
    }

    final platform = PlatformDetector.instance.current;

    if (platform == TargetPlatform.iOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (platform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  /// 即座に通知表示（基本メソッド）
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    required String path,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      channelDescription: 'Channel for instant notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, notificationDetails, payload: path);
  }
}
