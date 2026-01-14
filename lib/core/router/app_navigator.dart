import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sample_go_router_app/core/router/route_types.dart';
import 'package:sample_go_router_app/core/router/router.dart';

part 'app_navigator.g.dart';

@riverpod
AppNavigator appNavigator(Ref ref) {
  // GoRouterの実体を取得してNavigatorに渡す
  return AppNavigator(ref.watch(goRouterProvider));
}

class AppNavigator {
  AppNavigator(this._router);
  final GoRouter _router;

  /// 画面遷移を実行
  /// ルートの型（階層かモーダルか）によって go/push を自動判別
  void navigateTo(AppBaseRoute route) {
    if (route is ModalRoute) {
      // モーダル/ダイアログ的な画面はスタックに積む
      _router.push(route.location);
    } else {
      // 階層/主要画面は go で遷移（デフォルト）
      // HierarchyRoute もこちらに含まれる
      _router.go(route.location);
    }
  }

  /// 戻る
  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }
}
