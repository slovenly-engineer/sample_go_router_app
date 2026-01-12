# パターン適用の確認

## 確認項目

### AppNavigatorパターン

- [ ] 全ての画面遷移が `AppNavigator` を経由しているか
- [ ] `BuildContext` に依存せずに遷移を実行しているか
- [ ] ルートタイプ（`HierarchyRoute` / `ModalRoute`）が適切に選択されているか

### ViewModelパターン

- [ ] 各ページに対応するViewModelが存在するか
- [ ] ViewModelが `@riverpod` アノテーションを使用しているか
- [ ] 状態が不変（immutable）に保たれているか
- [ ] `copyWith` メソッドが適切に実装されているか

### エラーハンドリングパターン

- [ ] エラー状態が状態クラスに含まれているか
- [ ] エラーメッセージが適切に表示されているか
- [ ] 再試行機能が提供されているか（適切な場合）

## 確認方法

### AppNavigatorパターンの確認

```dart
// 良い例: AppNavigatorを使用
void navigateToItemDetail(String itemId) {
  final navigator = ref.read(appNavigatorProvider);
  navigator.navigateTo(ItemDetailRoute(itemId: itemId));
}

// 悪い例: BuildContextに依存
void navigateToItemDetail(BuildContext context, String itemId) {
  context.go('/items/$itemId');
}
```

### ViewModelパターンの確認

```dart
// 良い例: 不変な状態とcopyWith
class HomeState {
  final String title;
  final int count;

  const HomeState({required this.title, this.count = 0});

  HomeState copyWith({String? title, int? count}) {
    return HomeState(
      title: title ?? this.title,
      count: count ?? this.count,
    );
  }
}

// 悪い例: 可変な状態
class HomeState {
  String title;
  int count;
}
```

## ベストプラクティス

- 既存のパターンと一貫性があるか
- パターンが適切に適用されているか
- パターンの目的が理解されているか
