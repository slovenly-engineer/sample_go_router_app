# AppNavigatorパターン

## 概要

`AppNavigator` パターンは、全ての画面遷移を一箇所に集約し、`BuildContext` に依存せずに画面遷移を実行するためのパターンです。

## 設計思想

### 問題点

従来のFlutterアプリでは、画面遷移に `BuildContext` が必要でした。これにより：

- ViewModelやRepositoryから直接遷移できない
- テスト時に `BuildContext` のモックが必要
- ビジネスロジックとUIが密結合になる

### 解決策

`AppNavigator` クラスに全ての画面遷移を集約し、`GoRouter` のインスタンスを直接保持することで、`BuildContext` に依存せずに遷移を実行できます。

## 実装方法

### AppNavigatorの定義

```dart
@riverpod
AppNavigator appNavigator(AppNavigatorRef ref) {
  final router = ref.watch(goRouterProvider);
  return AppNavigator(router);
}

class AppNavigator {
  final GoRouter _router;

  AppNavigator(this._router);

  void navigateTo(RouteData route) {
    if (route is HierarchyRoute) {
      _router.go(route.path);
    } else if (route is ModalRoute) {
      _router.push(route.path);
    }
  }
}
```

### 使用方法

ViewModel内で使用：

```dart
@riverpod
class HomeViewModel extends _$HomeViewModel {
  void navigateToItemDetail(String itemId) {
    final navigator = ref.read(appNavigatorProvider);
    navigator.navigateTo(ItemDetailRoute(itemId: itemId));
  }
}
```

## ルートタイプの自動判別

`AppNavigator` は、渡されたルートの型（`ModalRoute` か `HierarchyRoute` か）を判定し、適切な遷移メソッドを実行します。

- **HierarchyRoute**: `GoRouter.go()` を使用（履歴の置き換え/深いリンク）
- **ModalRoute**: `GoRouter.push()` を使用（画面スタックへの追加）

## メリット

1. **BuildContext非依存**: ViewModelやRepositoryから直接遷移可能
2. **テスト容易性**: `AppNavigator` をモック化してテスト可能
3. **統一された遷移**: 全ての遷移が一箇所で管理される
4. **型安全性**: `TypedGoRoute` を使用した型安全な遷移

## ベストプラクティス

1. **全ての遷移はAppNavigator経由**: `BuildContext` を直接使用しない
2. **型安全な遷移**: `TypedGoRoute` を使用
3. **テスト時のモック化**: `AppNavigator` をモック化してテスト
