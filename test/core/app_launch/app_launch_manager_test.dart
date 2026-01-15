import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_go_router_app/core/app_launch/app_launch_info.dart';
import 'package:sample_go_router_app/core/app_launch/app_launch_manager.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  late MockFlutterLocalNotificationsPlugin mockPlugin;
  late AppLaunchManager manager;

  setUp(() {
    mockPlugin = MockFlutterLocalNotificationsPlugin();
    manager = AppLaunchManager(notificationPlugin: mockPlugin);
  });

  group('AppLaunchManager', () {
    test('通知から起動した場合、正しい起動情報を収集する', () async {
      // Arrange
      const payload = '/home/items/42';
      when(() => mockPlugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => NotificationAppLaunchDetails(
          true,
          notificationResponse: NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: payload,
          ),
        ),
      );

      // Act
      await manager.collectLaunchInfo();

      // Assert
      expect(manager.hasLaunchInfo(), isTrue);
      final info = manager.consumeLaunchInfo();
      expect(info, isNotNull);
      expect(info!.source, equals(AppLaunchSource.notification));
      expect(info.path, equals(payload));
      expect(info.hasPath, isTrue);
    });

    test('通常起動の場合、normal sourceを設定する', () async {
      // Arrange
      when(() => mockPlugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => const NotificationAppLaunchDetails(false),
      );

      // Act
      await manager.collectLaunchInfo();

      // Assert
      expect(manager.hasLaunchInfo(), isTrue);
      final info = manager.consumeLaunchInfo();
      expect(info, isNotNull);
      expect(info!.source, equals(AppLaunchSource.normal));
      expect(info.hasPath, isFalse);
    });

    test('consumeLaunchInfoは一度だけ情報を返す', () async {
      // Arrange
      when(() => mockPlugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => const NotificationAppLaunchDetails(false),
      );
      await manager.collectLaunchInfo();

      // Act & Assert
      final first = manager.consumeLaunchInfo();
      expect(first, isNotNull);

      final second = manager.consumeLaunchInfo();
      expect(second, isNull); // 2回目はnull
    });

    test('payloadが空の通知は通常起動として扱う', () async {
      // Arrange
      when(() => mockPlugin.getNotificationAppLaunchDetails()).thenAnswer(
        (_) async => NotificationAppLaunchDetails(
          true,
          notificationResponse: const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '',
          ),
        ),
      );

      // Act
      await manager.collectLaunchInfo();

      // Assert - 空のpayloadは通常起動扱い
      final info = manager.consumeLaunchInfo();
      expect(info, isNotNull);
      expect(info!.source, equals(AppLaunchSource.normal));
    });
  });
}
