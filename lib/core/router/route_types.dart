import 'package:go_router/go_router.dart';

/// ルートの基底クラス
/// すべてのルート定義はこのクラス（またはサブクラス）を継承する
/// Tは画面を閉じた時の結果型
abstract class AppBaseRoute<T> extends GoRouteData {
  const AppBaseRoute();
}

/// [階層構造を持つ画面] (主要画面)
/// ナビゲーションの階層的な移動（タブ切り替え、パンくずリスト移動など）を表す。
/// AppNavigatorはこれを [go] (履歴の置き換え/深いリンク) で処理する。
/// 結果は返さない（void）。
abstract class HierarchyRoute extends AppBaseRoute<void> {
  const HierarchyRoute();
}

/// [一時的な画面/ダイアログ] (詳細画面、フォームなど)
/// 現在のコンテキストの上に一時的に積まれる画面を表す。
/// AppNavigatorはこれを [push] (スタックへの追加) で処理する。
/// Tは画面を閉じた時の結果型（結果が不要な場合は void）。
abstract class ModalRoute<T> extends AppBaseRoute<T> {
  const ModalRoute();
}
