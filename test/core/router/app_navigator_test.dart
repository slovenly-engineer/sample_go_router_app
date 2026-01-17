import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/core/router/route_types.dart'
    as route_types;

class MockGoRouter extends Mock implements GoRouter {
  /// popの呼び出しを記録するためのリスト
  ///
  /// GoRouter.pop はジェネリクスメソッドのため、Mocktail の when/verify で
  /// 直接スタブ化できない。そのため手動でオーバーライドし、呼び出しを記録する。
  final List<Object?> popCalls = [];

  @override
  void pop<T extends Object?>([T? result]) {
    popCalls.add(result);
  }
}

// テスト用のHierarchyRoute
class TestHierarchyRoute extends route_types.HierarchyRoute {
  const TestHierarchyRoute();

  @override
  String get location => '/test-hierarchy';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SizedBox.shrink();
}

// テスト用のModalRoute
class TestModalRoute extends route_types.ModalRoute {
  const TestModalRoute();

  @override
  String get location => '/test-modal';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SizedBox.shrink();
}

void main() {
  group('AppNavigator', () {
    late MockGoRouter mockRouter;
    late AppNavigator navigator;

    setUp(() {
      mockRouter = MockGoRouter();
      navigator = AppNavigator(mockRouter);

      // デフォルトのスタブ設定
      when(() => mockRouter.push<Object?>(any())).thenAnswer((_) async => null);
    });

    group('navigateTo', () {
      test('HierarchyRouteの場合はgo()が呼ばれること', () async {
        // 準備
        const route = TestHierarchyRoute();

        // 実行
        await navigator.navigateTo(route);

        // 検証
        verify(() => mockRouter.go('/test-hierarchy')).called(1);
        verifyNever(() => mockRouter.push<Object?>(any()));
      });

      test('ModalRouteの場合はpush()が呼ばれること', () async {
        // 準備
        const route = TestModalRoute();

        // 実行
        await navigator.navigateTo(route);

        // 検証
        verify(() => mockRouter.push<Object?>('/test-modal')).called(1);
        verifyNever(() => mockRouter.go(any()));
      });
    });

    group('navigateToPath', () {
      test('isModal=falseの場合はgo()が呼ばれること', () async {
        // 実行
        await navigator.navigateToPath('/home');

        // 検証
        verify(() => mockRouter.go('/home')).called(1);
        verifyNever(() => mockRouter.push<Object?>(any()));
      });

      test('isModal=trueの場合はpush()が呼ばれること', () async {
        // 実行
        await navigator.navigateToPath('/detail', isModal: true);

        // 検証
        verify(() => mockRouter.push<Object?>('/detail')).called(1);
        verifyNever(() => mockRouter.go(any()));
      });

      test('パラメータ付きパスでgo()が呼ばれること', () async {
        // 実行
        await navigator.navigateToPath('/items/42');

        // 検証
        verify(() => mockRouter.go('/items/42')).called(1);
      });
    });

    group('pop', () {
      test('引数なしでpop()が呼ばれること', () {
        // 実行
        navigator.pop();

        // 検証
        expect(mockRouter.popCalls, hasLength(1));
        expect(mockRouter.popCalls.single, isNull);
      });

      test('結果付きでpop()が呼ばれること', () {
        // 実行
        navigator.pop('result');

        // 検証
        expect(mockRouter.popCalls, hasLength(1));
        expect(mockRouter.popCalls.single, equals('result'));
      });
    });
  });
}
