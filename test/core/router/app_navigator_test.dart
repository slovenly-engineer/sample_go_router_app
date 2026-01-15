import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/core/router/route_types.dart';

// Mock用のテストルート
class TestHierarchyRoute extends HierarchyRoute {
  const TestHierarchyRoute();

  @override
  String get location => '/test-hierarchy';
}

class TestModalRoute extends ModalRoute {
  const TestModalRoute();

  @override
  String get location => '/test-modal';
}

// Mock定義（@GeneratesMocksを使わない方法）
class MockGoRouter extends Mock implements GoRouter {
  @override
  void go(String location, {Object? extra}) => super.noSuchMethod(
        Invocation.method(#go, [location], {#extra: extra}),
        returnValueForMissingStub: null,
      );

  @override
  Future<T?> push<T extends Object?>(String location, {Object? extra}) =>
      super.noSuchMethod(
        Invocation.method(#push, [location], {#extra: extra}),
        returnValue: Future<T?>.value(),
        returnValueForMissingStub: Future<T?>.value(),
      ) as Future<T?>;

  @override
  void pop<T extends Object?>([T? result]) => super.noSuchMethod(
        Invocation.method(#pop, [result]),
        returnValueForMissingStub: null,
      );
}

void main() {
  group('AppNavigator', () {
    late MockGoRouter mockRouter;
    late AppNavigator navigator;

    setUp(() {
      mockRouter = MockGoRouter();
      navigator = AppNavigator(mockRouter);
    });

    group('navigateTo', () {
      test('should call go() for HierarchyRoute', () {
        // Arrange
        const route = TestHierarchyRoute();

        // Act
        navigator.navigateTo(route);

        // Assert
        verify(mockRouter.go('/test-hierarchy')).called(1);
        verifyNever(mockRouter.push<Object?>(any));
      });

      test('should call push() for ModalRoute', () {
        // Arrange
        const route = TestModalRoute();

        // Act
        navigator.navigateTo(route);

        // Assert
        verify(mockRouter.push<Object?>('/test-modal')).called(1);
        verifyNever(mockRouter.go(any));
      });

      test('should handle multiple navigations correctly', () {
        // Arrange
        const hierarchyRoute = TestHierarchyRoute();
        const modalRoute = TestModalRoute();

        // Act
        navigator
          ..navigateTo(hierarchyRoute)
          ..navigateTo(modalRoute);

        // Assert
        verify(mockRouter.go('/test-hierarchy')).called(1);
        verify(mockRouter.push<Object?>('/test-modal')).called(1);
      });
    });

    group('pop', () {
      test('should call router.pop() without result', () {
        // Act
        navigator.pop();

        // Assert
        verify(mockRouter.pop<Object?>()).called(1);
      });

      test('should call router.pop() with result', () {
        // Arrange
        const result = 'test-result';

        // Act
        navigator.pop(result);

        // Assert
        verify(mockRouter.pop<String>(result)).called(1);
      });

      test('should handle different result types', () {
        // Act & Assert
        navigator.pop(42);
        verify(mockRouter.pop<int>(42)).called(1);

        navigator.pop(true);
        verify(mockRouter.pop<bool>(true)).called(1);

        navigator.pop({'key': 'value'});
        verify(mockRouter.pop<Map<String, String>>({'key': 'value'})).called(1);
      });
    });
  });
}
