# 新機能追加手順

## 手順概要

1. 機能ディレクトリの作成
2. ルート定義の作成
3. ページとViewModelの作成
4. ルーターへの登録
5. コード生成の実行
6. テストの作成

## 詳細手順

### 1. 機能ディレクトリの作成

`lib/features/` 配下に新しい機能ディレクトリを作成します。

```bash
mkdir -p lib/features/your_feature/presentation
mkdir -p lib/features/your_feature/data  # 必要に応じて
```

### 2. ルート定義の作成

`lib/features/your_feature/your_feature_route.dart` を作成します。

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_builder/go_router_builder.dart';
import '../../../core/router/route_types.dart';
import 'presentation/your_feature_page.dart';

// HierarchyRoute または ModalRoute を継承
@TypedGoRoute<YourFeatureRoute>(path: '/your-feature')
class YourFeatureRoute extends HierarchyRoute {
  const YourFeatureRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YourFeaturePage();
  }
}
```

**ルートタイプの選択**:
- **HierarchyRoute**: タブ内遷移、ボトムナビゲーション表示
- **ModalRoute**: タブを覆う遷移、ボトムナビゲーション非表示

### 3. ページの作成

`lib/features/your_feature/presentation/your_feature_page.dart` を作成します。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'your_feature_view_model.dart';

class YourFeaturePage extends ConsumerWidget {
  const YourFeaturePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(yourFeatureViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Feature'),
      ),
      body: Center(
        child: Text('Your Feature Content'),
      ),
    );
  }
}
```

### 4. ViewModelの作成

`lib/features/your_feature/presentation/your_feature_view_model.dart` を作成します。

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'your_feature_view_model.g.dart';

@riverpod
class YourFeatureViewModel extends _$YourFeatureViewModel {
  @override
  YourFeatureState build() {
    return const YourFeatureState();
  }

  // ビジネスロジックをここに実装
  void someAction() {
    // 処理
  }
}

class YourFeatureState {
  const YourFeatureState();
}
```

### 5. ルーターへの登録

`lib/core/router/router.dart` にルートを追加します。

#### HierarchyRouteの場合

`StatefulShellRoute` の `branches` 内に追加：

```dart
@TypedStatefulShellRoute<MainDataShellRoute>(
  branches: [
    // ... 既存のブランチ ...
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<YourFeatureRoute>(path: '/your-feature')],
    ),
  ],
)
```

#### ModalRouteの場合

`routes` 配列に追加：

```dart
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    routes: [
      // ... 既存のルート ...
      $yourFeatureRoute,  // 追加
    ],
  );
}
```

### 6. コード生成の実行

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

生成されるファイル:
- `your_feature_route.g.dart`
- `your_feature_view_model.g.dart`

### 7. テストの作成

`test/features/your_feature/your_feature_test.dart` を作成します。

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_app/features/your_feature/presentation/your_feature_view_model.dart';

void main() {
  group('YourFeatureViewModel', () {
    test('should initialize with default state', () {
      final container = ProviderContainer();
      final state = container.read(yourFeatureViewModelProvider);

      expect(state, isNotNull);
      // 初期状態のアサーション
    });
  });
}
```

## ベストプラクティス

### 1. 命名規則

- **ディレクトリ**: スネークケース（`your_feature`）
- **ファイル**: スネークケース（`your_feature_route.dart`）
- **クラス**: パスカルケース（`YourFeatureRoute`）

### 2. ルートタイプの選択

- **タブ内遷移**: `HierarchyRoute`
- **タブを覆う遷移**: `ModalRoute`

### 3. 状態管理

- ページレベルの状態: ViewModelで管理
- グローバルな状態: 必要に応じてRiverpod Providerで管理

## チェックリスト

新機能追加時に確認すべき項目：

- [ ] 機能ディレクトリが正しく作成されている
- [ ] ルート定義が正しく作成されている
- [ ] ページとViewModelが実装されている
- [ ] ルーターに正しく登録されている
- [ ] コード生成が実行されている
- [ ] テストが作成されている
- [ ] 静的解析エラーがない（`flutter analyze`）
- [ ] アプリが正常に動作する
