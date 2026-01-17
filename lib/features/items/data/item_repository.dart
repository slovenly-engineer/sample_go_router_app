import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/auth/login_route.dart';

part 'item_repository.g.dart';

@riverpod
ItemRepository itemRepository(Ref ref) {
  return ItemRepository(ref);
}

class ItemRepository {
  // Refのみ保持

  ItemRepository(this._ref);
  final Ref _ref;

  Future<void> fetchItems() async {
    try {
      // ... API Request ...
      // Simulating an error for demo purposes
      await Future<void>.delayed(const Duration(seconds: 1));
      throw Exception('401 Unauthorized');
    } on Exception catch (e) {
      if (e.toString().contains('401')) {
        // 【重要】ここで初めてNavigatorを取得する
        // これにより初期化時の循環参照を防ぐ
        // navigateTo は Future を返すが、ここでは結果を待たない（fire-and-forget）
        unawaited(
          _ref.read(appNavigatorProvider).navigateTo(const LoginRoute()),
        );
      }
    }
  }
}
