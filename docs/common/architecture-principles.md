# アーキテクチャ原則

## Feature-First アーキテクチャ

このプロジェクトは、**Feature-First アーキテクチャ**を採用しています。コードは技術的なレイヤー（presentation, domain, data）ではなく、**機能（feature）ごとに整理**されています。

## 設計原則

### 1. 機能の独立性

各機能は独立したモジュールとして管理され、以下の利点があります：

- **機能の独立性**: 各機能が独立しており、他の機能への影響を最小化
- **スケーラビリティ**: 新機能の追加が容易
- **保守性**: 機能単位での理解と修正が容易

### 2. 型安全なナビゲーション

`go_router_builder` と `TypedGoRoute` を使用することで、コンパイル時にルーティングエラーを検出できます。

### 3. BuildContext非依存のナビゲーション

`AppNavigator` パターンにより、ViewModelやRepositoryから `BuildContext` に依存せずに画面遷移が可能です。

## 各レイヤーの役割

### Core層 (`lib/core/`)

プロジェクト全体で共有される機能を提供します。

- **Router**: ルーティング設定とナビゲーション管理
- 将来的には、共通Widget、ユーティリティなども配置

### Feature層 (`lib/features/`)

各機能は独立したモジュールとして実装されます。

各機能モジュールの構造：

```
features/{feature_name}/
├── {feature}_route.dart      # ルート定義
├── presentation/             # UI層
│   ├── {feature}_page.dart   # ページWidget
│   └── {feature}_view_model.dart  # ViewModel
└── data/                     # データ層（必要に応じて）
    └── {feature}_repository.dart
```

## 状態管理

### Riverpod

- **Provider定義**: `@riverpod` アノテーションを使用
- **コード生成**: `riverpod_generator` で自動生成
- **依存性注入**: `ref` を通じて依存関係を注入

### ViewModelパターン

各ページには対応するViewModelがあり、ビジネスロジックを管理します。

## ナビゲーション設計

### ルートタイプ

- **HierarchyRoute**: 階層構造を持つ画面（タブ内遷移、ボトムナビゲーション表示）
- **ModalRoute**: モーダル/全画面詳細（タブを覆う遷移、ボトムナビゲーション非表示）

### ナビゲーション方法

全ての画面遷移は `AppNavigator` を経由します。

```dart
final navigator = ref.read(appNavigatorProvider);
navigator.navigateTo(ItemDetailRoute(itemId: '123'));
```
