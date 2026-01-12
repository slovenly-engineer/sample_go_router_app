# ViewModelパターン

## 概要

ViewModelパターンは、ページのビジネスロジックを管理し、UIとロジックを分離するためのパターンです。Riverpodを使用して実装します。

## 実装方法

### ViewModelの定義

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return const HomeState();
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }
}

class HomeState {
  final String title;
  final int count;

  const HomeState({
    required this.title,
    this.count = 0,
  });

  HomeState copyWith({
    String? title,
    int? count,
  }) {
    return HomeState(
      title: title ?? this.title,
      count: count ?? this.count,
    );
  }
}
```

### ページでの使用

```dart
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.watch(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Count: ${state.count}'),
            ElevatedButton(
              onPressed: () => viewModel.updateTitle('New Title'),
              child: Text('Update Title'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 状態管理

### 不変性の原則

状態は不変（immutable）に保ちます。状態を変更する際は、`copyWith` メソッドを使用して新しいインスタンスを作成します。

### 状態の分離

- ページレベルの状態: ViewModelで管理
- グローバルな状態: 必要に応じてRiverpod Providerで管理

## 依存性注入

`ref` を通じて依存関係を注入します。

```dart
@riverpod
class ItemViewModel extends _$ItemViewModel {
  @override
  ItemState build() {
    final repository = ref.watch(itemRepositoryProvider);
    // repositoryを使用
    return ItemState();
  }
}
```

## エラーハンドリング

エラー状態も適切に管理します。

```dart
class ItemState {
  final List<Item>? items;
  final String? error;
  final bool isLoading;

  const ItemState({
    this.items,
    this.error,
    this.isLoading = false,
  });
}
```

## ベストプラクティス

1. **状態の不変性**: 状態は不変に保つ
2. **copyWithメソッド**: 状態変更時は `copyWith` を使用
3. **エラーハンドリング**: エラー状態も適切に管理
4. **依存性注入**: `ref` を通じて依存関係を注入
