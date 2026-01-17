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
  AppNavigator(this._router);
  final GoRouter _router;

  /// 画面遷移を実行
  /// ルートの型（階層かモーダルか）によって go/push を自動判別
  /// Tは画面を閉じた時の結果型。HierarchyRouteの場合はnullを返す。
  Future<T?> navigateTo<T>(AppBaseRoute<T> route) {
    if (route is ModalRoute<T>) {
      return _router.push<T>(route.location);
    } else {
      _router.go(route.location);
      return Future<T?>.value();
    }
  }

  /// パス文字列を使用して画面遷移を実行
  /// 通知タップなど、BuildContextが利用できない場合に使用
  /// isModal=trueの場合は結果を受け取れる
  Future<T?> navigateToPath<T>(String path, {bool isModal = false}) {
    if (isModal) {
      return _router.push<T>(path);
    } else {
      _router.go(path);
      return Future<T?>.value();
    }
  }

  /// 戻る
  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
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

## APIリファレンス

### navigateTo<T>(AppBaseRoute<T> route)

型安全なルートオブジェクトを使用して画面遷移を実行します。

**パラメータ:**
- `route`: 遷移先のルートオブジェクト（HierarchyRouteまたはModalRoute）

**戻り値:**
- `Future<T?>`:
  - ModalRoute: 画面を閉じた時の結果（pushの戻り値）
  - HierarchyRoute: 常にnull（goは結果を返さない）

**使用例:**
```dart
// 結果を受け取らない場合
await navigator.navigateTo(ItemDetailRoute(id: '123'));

// 結果を受け取る場合（ModalRoute）
final result = await navigator.navigateTo(FilterRoute());
if (result != null) {
  // 結果を処理
}
```

### navigateToPath<T>(String path, {bool isModal = false})

パス文字列を使用して画面遷移を実行します。通知タップなど、BuildContextやルートオブジェクトが利用できない場合に使用します。

**パラメータ:**
- `path`: 遷移先のパス文字列（例: `/home`, `/item/42`）
- `isModal`: モーダル遷移として扱うか（デフォルト: false）

**戻り値:**
- `Future<T?>`: isModal=trueの場合のみ結果を受け取れる

**使用例:**
```dart
// 通知ハンドラー内で使用
await navigator.navigateToPath<void>('/home');

// モーダル遷移として結果を受け取る
final result = await navigator.navigateToPath<String>('/filter', isModal: true);
```

**注意事項:**
- 型安全性が失われるため、可能な限り`navigateTo`を使用してください
- パスが無効な場合、GoRouterがエラーをスローします

### pop<T extends Object?>([T? result])

現在の画面を閉じて前の画面に戻ります。

**パラメータ:**
- `result`: 前の画面に返す結果（オプション）

**使用例:**
```dart
// 結果なしで戻る
navigator.pop();

// 結果を返して戻る
navigator.pop('選択された値');
```

## 結果の受け取り

### ModalRouteでの結果受け取り

ModalRouteを使用した遷移では、画面を閉じた時に結果を受け取ることができます。

**遷移元（呼び出し側）:**
```dart
@riverpod
class SearchViewModel extends _$SearchViewModel {
  Future<void> openFilter() async {
    final navigator = ref.read(appNavigatorProvider);

    // FilterRouteはModalRoute<String>として定義
    final selectedFilter = await navigator.navigateTo(FilterRoute());

    if (selectedFilter != null) {
      // フィルター結果を処理
      print('Selected filter: $selectedFilter');
    }
  }
}
```

**遷移先（結果を返す側）:**
```dart
@riverpod
class FilterViewModel extends _$FilterViewModel {
  void applyFilter(String filter) {
    final navigator = ref.read(appNavigatorProvider);

    // 結果を返して画面を閉じる
    navigator.pop(filter);
  }
}
```

### HierarchyRouteの制約

HierarchyRouteは`go()`メソッドを使用するため、結果を返すことができません。

```dart
// HierarchyRouteの定義（結果型はvoid）
class SettingsRoute extends HierarchyRoute {
  const SettingsRoute();
  // ...
}

// 呼び出し側
final result = await navigator.navigateTo(const SettingsRoute());
// result は常に null
```

**結果を返す必要がある場合は、ModalRouteとして定義してください。**

## メリット

1. **BuildContext非依存**: ViewModelやRepositoryから直接遷移可能
2. **テスト容易性**: `AppNavigator` をモック化してテスト可能
3. **統一された遷移**: 全ての遷移が一箇所で管理される
4. **型安全性**: `TypedGoRoute` を使用した型安全な遷移

## ベストプラクティス

1. **全ての遷移はAppNavigator経由**: `BuildContext` を直接使用しない
2. **型安全な遷移**: `TypedGoRoute` を使用
3. **テスト時のモック化**: `AppNavigator` をモック化してテスト
