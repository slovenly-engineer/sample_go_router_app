import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/notifications/handlers/notification_navigation_handler.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  setUpAll(() {
    // Mocktailのany()マッチャー用にFallbackValueを登録
    registerFallbackValue('');
  });

  group('NotificationNavigationHandler', () {
    late MockAppNavigator mockNavigator;
    late NotificationNavigationHandler handler;

    setUp(() {
      mockNavigator = MockAppNavigator();
      handler = NotificationNavigationHandler(navigator: mockNavigator);
    });

    test('有効なパスで画面遷移が実行されること', () {
      // 準備
      const response = NotificationResponse(
        id: 1,
        payload: '/home',
        notificationResponseType: NotificationResponseType.selectedNotification,
      );

      // 実行
      handler.handleNotificationTapped(response);

      // 検証
      verify(() => mockNavigator.navigateToPath('/home')).called(1);
    });

    test('空のペイロードでは遷移しないこと', () {
      // 準備
      const response = NotificationResponse(
        id: 1,
        payload: '',
        notificationResponseType: NotificationResponseType.selectedNotification,
      );

      // 実行
      handler.handleNotificationTapped(response);

      // 検証
      verifyNever(() => mockNavigator.navigateToPath(any()));
    });

    test('nullのペイロードでは遷移しないこと', () {
      // 準備
      const response = NotificationResponse(
        id: 1,
        notificationResponseType: NotificationResponseType.selectedNotification,
      );

      // 実行
      handler.handleNotificationTapped(response);

      // 検証
      verifyNever(() => mockNavigator.navigateToPath(any()));
    });

    test('パラメータ付きパスで遷移が実行されること', () {
      // 準備
      const response = NotificationResponse(
        id: 1,
        payload: '/items/42',
        notificationResponseType: NotificationResponseType.selectedNotification,
      );

      // 実行
      handler.handleNotificationTapped(response);

      // 検証
      verify(() => mockNavigator.navigateToPath('/items/42')).called(1);
    });
  });
}
