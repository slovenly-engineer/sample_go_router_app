import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/home/presentation/home_view_model.dart';
import 'package:sample_go_router_app/features/items/item_route.dart';

// Mock定義
class MockAppNavigator extends Mock implements AppNavigator {
  @override
  void navigateTo(GoRouteData? route) => super.noSuchMethod(
        Invocation.method(#navigateTo, [route]),
        returnValueForMissingStub: null,
      );
}

void main() {
  group('HomeViewModel', () {
    late ProviderContainer container;
    late MockAppNavigator mockNavigator;

    setUp(() {
      mockNavigator = MockAppNavigator();
      container = ProviderContainer(
        overrides: [
          appNavigatorProvider.overrideWithValue(mockNavigator),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('onItemSelected should navigate to ItemDetailRoute with correct id', () {
      // Arrange
      const testId = 'test-item-123';
      final viewModel = container.read(homeViewModelProvider.notifier);

      // Act
      viewModel.onItemSelected(testId);

      // Assert
      verify(
        mockNavigator.navigateTo(
          argThat(
            predicate<GoRouteData>(
              (route) =>
                  route is ItemDetailRoute && route.id == testId,
            ),
          ),
        ),
      ).called(1);
    });

    test('onItemSelected should call navigateTo with ItemDetailRoute type', () {
      // Arrange
      const testId = 'another-id';
      final viewModel = container.read(homeViewModelProvider.notifier);

      // Act
      viewModel.onItemSelected(testId);

      // Assert
      verify(mockNavigator.navigateTo(argThat(isA<ItemDetailRoute>())))
          .called(1);
    });
  });
}
