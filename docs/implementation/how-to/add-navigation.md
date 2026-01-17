# 画面遷移追加手順

## 概要

このドキュメントでは、既存の機能に画面遷移を追加する手順を説明します。

## 手順

### 1. 遷移先のルート定義を確認

遷移先のルートが既に存在するか確認します。

- 存在する場合: ステップ2へ
- 存在しない場合: [新機能追加手順](add-feature.md) を参照してルートを作成

### 2. ルートタイプの確認

遷移先のルートが `HierarchyRoute` か `ModalRoute` かを確認します。

- **HierarchyRoute**: タブ内遷移、ボトムナビゲーション表示
- **ModalRoute**: タブを覆う遷移、ボトムナビゲーション非表示

### 3. ViewModel内での遷移実装

ViewModel内で `AppNavigator` を使用して画面遷移を実装します。

```dart
import 'package:your_app/core/router/app_navigator.dart';
import 'package:your_app/features/items/item_route.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  void navigateToItemDetail(String itemId) {
    final navigator = ref.read(appNavigatorProvider);
    navigator.navigateTo(ItemDetailRoute(itemId: itemId));
  }
}
```

### 4. UIからの呼び出し

ページWidgetからViewModelのメソッドを呼び出します。

```dart
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider.notifier);

    return ElevatedButton(
      onPressed: () => viewModel.navigateToItemDetail('123'),
      child: Text('アイテム詳細へ'),
    );
  }
}
```

## 5. 結果を受け取る遷移の実装

画面遷移の結果を受け取る必要がある場合（例：フィルター選択、設定変更など）の実装手順です。

### 前提条件

- 遷移先のルートが `ModalRoute<T>` として定義されていること
- `T` は返す結果の型（例：`String`, `bool`, カスタムクラスなど）

### 手順

**1. ルート定義の確認**

遷移先のルートがModalRouteとして定義されていることを確認します。

```dart
// ModalRoute<String> として定義（String型の結果を返す）
@TypedGoRoute<FilterRoute>(path: '/filter')
class FilterRoute extends ModalRoute<String> with $FilterRoute {
  const FilterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FilterPage();
  }
}
```

**2. ViewModel内での遷移実装**

`await` を使用して結果を受け取ります。

```dart
import 'package:your_app/core/router/app_navigator.dart';
import 'package:your_app/features/search/filter_route.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  Future<void> openFilter() async {
    final navigator = ref.read(appNavigatorProvider);

    // 結果を受け取る
    final selectedFilter = await navigator.navigateTo(FilterRoute());

    if (selectedFilter != null) {
      // ユーザーがフィルターを選択した場合
      print('Selected filter: $selectedFilter');
      // 状態を更新する処理など
    } else {
      // ユーザーがキャンセルした場合（popに引数を渡さなかった）
      print('Filter selection cancelled');
    }
  }
}
```

**3. 遷移先での結果返却**

遷移先のViewModelで `navigator.pop()` を使用して結果を返します。

```dart
@riverpod
class FilterViewModel extends _$FilterViewModel {
  void applyFilter(String filter) {
    final navigator = ref.read(appNavigatorProvider);

    // 結果を返して画面を閉じる
    navigator.pop(filter);
  }

  void cancel() {
    final navigator = ref.read(appNavigatorProvider);

    // 結果なしで画面を閉じる
    navigator.pop();
  }
}
```

**4. UIからの呼び出し**

```dart
class SearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(searchViewModelProvider.notifier);

    return ElevatedButton(
      onPressed: () => viewModel.openFilter(),
      child: Text('フィルター選択'),
    );
  }
}
```

## 6. パス文字列を使用した遷移

通知タップなど、BuildContextやルートオブジェクトが利用できない場合に、パス文字列を使用して画面遷移を実装します。

### 使用場面

- 通知タップ時の画面遷移
- ディープリンク処理
- 外部からのURL遷移

### 実装方法

```dart
import 'package:your_app/core/router/app_navigator.dart';

class NotificationNavigationHandler {
  NotificationNavigationHandler({required AppNavigator navigator})
      : _navigator = navigator;
  final AppNavigator _navigator;

  void handleNotificationTapped(String payload) {
    if (payload.isEmpty) return;

    try {
      // パス文字列から直接遷移
      unawaited(_navigator.navigateToPath<void>(payload));
    } on Exception catch (e) {
      print('Failed to navigate: $e');
    }
  }
}
```

### isModalパラメータの使用

モーダル遷移として結果を受け取りたい場合：

```dart
final result = await navigator.navigateToPath<String>(
  '/filter',
  isModal: true,
);
```

### 注意事項

- **型安全性の喪失**: パス文字列は型チェックされないため、可能な限り `navigateTo` を使用してください
- **パス検証**: GoRouterが無効なパスに対してエラーをスローします
- **推奨される使用**: BuildContextが利用できない環境でのみ使用

### 実装例

詳細な実装例は [ADR-0001: 通知機能](../../specification/architecture/decisions/0001-notification-feature.md) を参照してください。

## 7. 実装例

### 階層遷移（HierarchyRoute）の例

```dart
// MyPageからSettingsへの遷移（結果を受け取らない）
void navigateToSettings() {
  final navigator = ref.read(appNavigatorProvider);
  navigator.navigateTo(const SettingsRoute());
}
```

### モーダル遷移（ModalRoute）の例

#### 結果を受け取らない場合

```dart
// SearchからFilterへの遷移（結果を受け取らない）
void navigateToFilter() {
  final navigator = ref.read(appNavigatorProvider);
  navigator.navigateTo(const FilterRoute());
}
```

#### 結果を受け取る場合

```dart
// SearchからFilterへの遷移（フィルター結果を受け取る）
Future<void> navigateToFilterWithResult() async {
  final navigator = ref.read(appNavigatorProvider);

  final selectedFilter = await navigator.navigateTo(FilterRoute());

  if (selectedFilter != null) {
    // フィルター結果を処理
    updateFilter(selectedFilter);
  }
}
```

### パス文字列を使用した遷移の例

```dart
// 通知タップ時の遷移
void handleNotificationTap(String path) {
  final navigator = ref.read(appNavigatorProvider);
  unawaited(navigator.navigateToPath<void>(path));
}
```

## ベストプラクティス

1. **BuildContext非依存**: ViewModel内で `AppNavigator` を使用し、`BuildContext` に依存しない
2. **型安全性**: `TypedGoRoute` を使用して型安全な遷移を実現
3. **パラメータの明示**: 遷移先に必要なパラメータを明示的に渡す

## チェックリスト

画面遷移追加時に確認すべき項目：

- [ ] 遷移先のルートが正しく定義されている
- [ ] ルートタイプ（HierarchyRoute/ModalRoute）が適切に選択されている
- [ ] 結果を返す必要がある場合、ModalRoute<T>として定義されている
- [ ] ViewModel内で `AppNavigator` を使用している
- [ ] `BuildContext` に依存していない
- [ ] 結果を受け取る場合、`await` を使用している
- [ ] 結果を返す場合、`pop()` に引数を渡している
- [ ] 遷移が正常に動作する
- [ ] コード生成が実行されている（`*.g.dart`が最新）
