# エラーハンドリングパターン

## 概要

このドキュメントでは、Flutterアプリでのエラーハンドリングのベストプラクティスを説明します。

## 状態でのエラー管理

### エラー状態の定義

ViewModelの状態にエラー情報を含めます。

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

  ItemState copyWith({
    List<Item>? items,
    String? error,
    bool? isLoading,
  }) {
    return ItemState(
      items: items ?? this.items,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
```

### エラーハンドリングの実装

```dart
@riverpod
class ItemViewModel extends _$ItemViewModel {
  @override
  ItemState build() {
    return const ItemState();
  }

  Future<void> fetchItems() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(itemRepositoryProvider);
      final items = await repository.fetchItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}
```

## UIでのエラー表示

### エラーメッセージの表示

```dart
class ItemPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemViewModelProvider);

    if (state.error != null) {
      return Center(
        child: Column(
          children: [
            Text('エラーが発生しました: ${state.error}'),
            ElevatedButton(
              onPressed: () => ref.read(itemViewModelProvider.notifier).fetchItems(),
              child: Text('再試行'),
            ),
          ],
        ),
      );
    }

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: state.items?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(state.items![index].name),
        );
      },
    );
  }
}
```

## 非同期処理のエラーハンドリング

### FutureProviderでのエラーハンドリング

```dart
@riverpod
Future<List<Item>> items(ItemsRef ref) async {
  try {
    final repository = ref.watch(itemRepositoryProvider);
    return await repository.fetchItems();
  } catch (e) {
    // エラーを適切に処理
    throw Exception('アイテムの取得に失敗しました: $e');
  }
}
```

### UIでのエラー処理

```dart
class ItemListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsProvider);

    return itemsAsync.when(
      data: (items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index].name));
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          children: [
            Text('エラー: $error'),
            ElevatedButton(
              onPressed: () => ref.invalidate(itemsProvider),
              child: Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## ベストプラクティス

1. **エラー状態の明示**: 状態にエラー情報を含める
2. **ユーザーフレンドリーなメッセージ**: 技術的なエラーメッセージではなく、ユーザーが理解できるメッセージを表示
3. **再試行機能**: エラー発生時に再試行できる機能を提供
4. **ログ記録**: エラーの詳細はログに記録し、ユーザーには簡潔なメッセージを表示
