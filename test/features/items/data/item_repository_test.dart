import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/auth/login_route.dart';
import 'package:sample_go_router_app/features/items/data/item_repository.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

void main() {
  setUpAll(() {
    // Mocktailのany()マッチャー用にFallbackValueを登録
    registerFallbackValue(const LoginRoute());
  });

  test('401エラー時にログイン画面へ遷移すること', () async {
    // 準備
    final mockNavigator = MockAppNavigator();

    final container = ProviderContainer(
      overrides: [appNavigatorProvider.overrideWithValue(mockNavigator)],
    )..listen(itemRepositoryProvider, (_, _) {});

    final repository = container.read(itemRepositoryProvider);

    // 実行
    await repository.fetchItems();

    // 検証
    verify(
      () => mockNavigator.navigateTo(any(that: isA<LoginRoute>())),
    ).called(1);
  });
}
