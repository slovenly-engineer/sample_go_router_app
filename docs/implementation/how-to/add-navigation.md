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

## 実装例

### 階層遷移（HierarchyRoute）の例

```dart
// MyPageからSettingsへの遷移
void navigateToSettings() {
  final navigator = ref.read(appNavigatorProvider);
  navigator.navigateTo(SettingsRoute());
}
```

### モーダル遷移（ModalRoute）の例

```dart
// SearchからFilterへの遷移
void navigateToFilter() {
  final navigator = ref.read(appNavigatorProvider);
  navigator.navigateTo(FilterRoute());
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
- [ ] ViewModel内で `AppNavigator` を使用している
- [ ] `BuildContext` に依存していない
- [ ] 遷移が正常に動作する
