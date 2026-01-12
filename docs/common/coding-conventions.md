# コーディング規約

## ファイル命名規則

### ルート定義

- **ファイル名**: `{feature}_route.dart` (例: `home_route.dart`)
- **クラス名**: `{Feature}Route` (例: `HomeRoute`)

### ページWidget

- **ファイル名**: `{feature}_page.dart` (例: `home_page.dart`)
- **クラス名**: `{Feature}Page` (例: `HomePage`)

### ViewModel

- **ファイル名**: `{feature}_view_model.dart` (例: `home_view_model.dart`)
- **クラス名**: `{Feature}ViewModel` (例: `HomeViewModel`)

### Repository

- **ファイル名**: `{feature}_repository.dart` (例: `item_repository.dart`)
- **クラス名**: `{Feature}Repository` (例: `ItemRepository`)

## ディレクトリ構造

### 機能モジュールの構造

```
features/{feature_name}/
├── {feature}_route.dart      # ルート定義
├── presentation/             # UI層
│   ├── {feature}_page.dart   # ページWidget
│   └── {feature}_view_model.dart  # ViewModel
└── data/                     # データ層（必要に応じて）
    └── {feature}_repository.dart
```

## コードスタイル

### Dart公式スタイルガイドに準拠

- `dart format` でフォーマットを統一
- `flutter analyze` で静的解析を実施

### 命名規則

- **ファイル名**: スネークケース（`home_page.dart`）
- **クラス名**: パスカルケース（`HomePage`）
- **変数名・関数名**: キャメルケース（`homeViewModel`）
- **定数**: ローワーキャメルケース（`defaultCount`）

## コード生成

### 実行タイミング

以下の変更を行った場合は、必ずコード生成を実行：

- ルート定義（`TypedGoRoute`）を追加・変更した場合
- Riverpod Providerを追加・変更した場合

### 実行コマンド

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 生成されるファイル

- `*.g.dart` - RiverpodとGoRouterの生成コード

## 状態管理

### Riverpod使用パターン

- **Provider定義**: `@riverpod` アノテーションを使用
- **ViewModel**: `@riverpod` で定義し、`ref` を使用して依存関係を注入
- **Repository**: 必要に応じて `@riverpod` で定義

### 状態の不変性

状態は不変（immutable）に保ちます。

```dart
class HomeState {
  final String title;
  final int count;

  const HomeState({
    required this.title,
    required this.count,
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

## エラーハンドリング

ViewModel内でエラーを適切に処理し、UIに反映します。

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
