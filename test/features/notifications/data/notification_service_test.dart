import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_go_router_app/features/notifications/data/notification_service.dart';
import 'package:sample_go_router_app/features/notifications/handlers/notification_navigation_handler.dart';

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockIOSFlutterLocalNotificationsPlugin extends Mock
    implements IOSFlutterLocalNotificationsPlugin {}

class MockNotificationNavigationHandler extends Mock
    implements NotificationNavigationHandler {}

// Mocktail用のFake（anyの引数マッチング用）
class FakeInitializationSettings extends Fake implements InitializationSettings {}

class FakeNotificationDetails extends Fake implements NotificationDetails {}

void main() {
  // setUpAll でFakeを登録
  setUpAll(() {
    registerFallbackValue(FakeInitializationSettings());
    registerFallbackValue(FakeNotificationDetails());
  });

  group('NotificationService', () {
    late MockFlutterLocalNotificationsPlugin mockPlugin;
    late MockNotificationNavigationHandler mockHandler;
    late NotificationService service;

    setUp(() {
      mockPlugin = MockFlutterLocalNotificationsPlugin();
      mockHandler = MockNotificationNavigationHandler();
      service = NotificationService(
        plugin: mockPlugin,
        navigationHandler: mockHandler,
      );

      // デフォルトのスタブ設定
      when(() => mockPlugin.initialize(
            any(),
            onDidReceiveNotificationResponse:
                any(named: 'onDidReceiveNotificationResponse'),
            onDidReceiveBackgroundNotificationResponse:
                any(named: 'onDidReceiveBackgroundNotificationResponse'),
          )).thenAnswer((_) async => true);

      when(() => mockPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>())
          .thenReturn(null);

      when(() => mockPlugin.show(
            any(),
            any(),
            any(),
            any(),
            payload: any(named: 'payload'),
          )).thenAnswer((_) async {});
    });

    test('initializeが正しく初期化すること', () async {
      // 実行
      await service.initialize();

      // 検証
      verify(() => mockPlugin.initialize(
            any(),
            onDidReceiveNotificationResponse:
                any(named: 'onDidReceiveNotificationResponse'),
            onDidReceiveBackgroundNotificationResponse:
                any(named: 'onDidReceiveBackgroundNotificationResponse'),
          )).called(1);
    });

    test('showInstantNotificationが通知を表示しペイロードにパスが設定されること', () async {
      // 実行
      await service.showInstantNotification(
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
        path: '/home',
      );

      // 検証
      verify(() => mockPlugin.show(
            1,
            'Test Title',
            'Test Body',
            any(),
            payload: '/home',
          )).called(1);
    });

    test('異なるIDで複数の通知を表示できること', () async {
      // 実行
      await service.showInstantNotification(
        id: 1,
        title: 'First',
        body: 'First notification',
        path: '/first',
      );
      await service.showInstantNotification(
        id: 2,
        title: 'Second',
        body: 'Second notification',
        path: '/second',
      );

      // 検証
      verify(() => mockPlugin.show(1, 'First', 'First notification', any(), payload: '/first')).called(1);
      verify(() => mockPlugin.show(2, 'Second', 'Second notification', any(), payload: '/second')).called(1);
    });

    group('requestIOSPermissions', () {
      test('iOS実装が存在する場合に権限リクエストが呼ばれること', () async {
        // 準備
        final mockIOSPlugin = MockIOSFlutterLocalNotificationsPlugin();
        when(() => mockPlugin
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>())
            .thenReturn(mockIOSPlugin);
        when(() => mockIOSPlugin.requestPermissions(
              alert: any(named: 'alert'),
              badge: any(named: 'badge'),
              sound: any(named: 'sound'),
            )).thenAnswer((_) async => true);

        // 実行
        await service.requestIOSPermissions();

        // 検証
        verify(() => mockIOSPlugin.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            )).called(1);
      });

      test('iOS実装が存在しない場合はエラーなく完了すること', () async {
        // 準備（setUpでnullを返すように設定済み）

        // 実行・検証（例外が発生しないこと）
        await expectLater(
          service.requestIOSPermissions(),
          completes,
        );
      });
    });
  });
}
