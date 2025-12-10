import 'package:go_router/go_router.dart';

/// ルートの基底クラス
/// すべてのルート定義はこのクラス（またはサブクラス）を継承する
abstract class AppBaseRoute extends GoRouteData {
  const AppBaseRoute();
}

/// [階層構造を持つ画面] (主要画面)
/// ナビゲーションの階層的な移動（タブ切り替え、パンくずリスト移動など）を表す。
/// AppNavigatorはこれを [go] (履歴の置き換え/深いリンク) で処理する。
abstract class HierarchyRoute extends AppBaseRoute {
  const HierarchyRoute();
}

/// [一時的な画面/ダイアログ] (詳細画面、フォームなど)
/// 現在のコンテキストの上に一時的に積まれる画面を表す。
/// AppNavigatorはこれを [push] (スタックへの追加) で処理する。
abstract class ModalRoute extends AppBaseRoute {
  const ModalRoute();
}
