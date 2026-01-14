import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/auth/login_route.dart';
import 'package:sample_go_router_app/features/items/data/item_repository.dart';

// 1. Mock定義
class MockAppNavigator extends Mock implements AppNavigator {
  @override
  void navigateTo(GoRouteData? route) => super.noSuchMethod(
    Invocation.method(#navigateTo, [route]),
    returnValueForMissingStub: null,
  );
}

void main() {
  test('401エラー時にログイン画面へ遷移すること', () async {
    // Arrange
    final mockNavigator = MockAppNavigator();

    // 2. ProviderContainerでモックを差し込み (Override)
    final container =
        ProviderContainer(
            overrides: [appNavigatorProvider.overrideWithValue(mockNavigator)],
          )
          // Keep the provider alive
          ..listen(itemRepositoryProvider, (_, __) {});

    final repository = container.read(itemRepositoryProvider);

    // Act
    await repository.fetchItems(); // 内部で例外発生 -> navigateTo呼び出し

    // Assert
    // 正しいRoute型が渡されたか検証
    verify(mockNavigator.navigateTo(argThat(isA<LoginRoute>()))).called(1);
  });
}
