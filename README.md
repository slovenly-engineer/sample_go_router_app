# サンプル GoRouter アプリ

**GoRouter** と **Riverpod** を使用した、堅牢で型安全な画面遷移アーキテクチャを示す Flutter アプリケーションです。

## 主な特徴

- **Feature-First アーキテクチャ**: コードはレイヤーごとではなく、機能ごと (`auth`, `home`, `items`, `search`, `mypage`) に整理されています。
- **型安全なナビゲーション**: `go_router_builder` (`TypedGoRoute`) を使用し、タイプセーフな遷移を実現しています。
- **統一されたナビゲーションロジック（AppNavigatorの役割）**:
  - **最大の特徴**: 全ての画面遷移は `AppNavigator` クラスに集約されています。
  - **メリット**: Presentation層（Widget）や Domain/Data層のロジック内から、**BuildContext に依存せず**に遷移を実行できます。
  - **テスト容易性**: `AppNavigator` をモック化することで、画面遷移のテストが容易になり、ロジックの単体テストの質が向上します。
- **遷移タイプの自動判別**:
  - **`HierarchyRoute`**: 主要画面や階層構造を持つ画面用。`AppNavigator` 内部で `GoRouter.go()` を呼び出して処理されます（履歴の置き換え/深いリンク）。
  - **`ModalRoute`**: ダイアログや詳細画面用。`AppNavigator` 内部で `GoRouter.push()` を呼び出して処理されます（画面スタックへの追加）。
  *補足: `AppNavigator` は `GoRouter` のインスタンスを直接保持しているため、`context` を介さずにこれらのメソッドを実行できます。*
- **ボトムナビゲーション**: `StatefulShellRoute` を実装し、タブ（Home, Search, MyPage）の状態を保持して切り替え可能です。
- **BuildContext への非依存**: ViewModel や Repository は `ref.read(appNavigatorProvider)` を使用して遷移を行うため、`BuildContext` を持ち回る必要がありません。

## アーキテクチャ構成

### Router 層 (`lib/core/router/`)
- **`router.dart`**: メインの GoRouter 設定。`StatefulShellRoute` のブランチ定義や、ルートレベルのルートを設定します。
- **`app_navigator.dart`**: ナビゲーション操作の窓口（Facade）。`navigateTo(route)` メソッドが渡されたルートの型（`ModalRoute` か `HierarchyRoute` か）を判定し、適切な遷移メソッドを実行します。
- **`route_types.dart`**: ルートの基底クラス (`HierarchyRoute`, `ModalRoute`) を定義しています。

### Feature 層 (`lib/features/`)
各機能モジュール（例: `home`, `search`）は以下を含みます：
- **`*_route.dart`**: ルート定義（例: `HomeRoute`）。
- **`presentation/`**: Widget (`Page`) とロジック (`ViewModel`)。
- **`data/`**: リポジトリなど（必要な場合）。

## ナビゲーションパターン

### 1. タブ切り替え
`StatefulShellRoute` と `ScaffoldWithNavBar` によって自動的に処理されます。状態は保持されます。

### 2. 階層遷移（タブ内遷移）
`HierarchyRoute` を継承し、`router.dart` 内でシェルのブランチ配下に定義されたルートへの遷移です。ボトムナビゲーションバーは**表示されたまま**になります。
*   **例**: MyPage -> Settings (`SettingsRoute`)

### 3. モーダル / 全画面詳細（タブを覆う遷移）
`ModalRoute` を継承し、`router.dart` 内でルートレベル（シェルと同列）に定義されたルートへの遷移です。ボトムナビゲーションバーは**隠れます（覆われます）**。
*   **例**: Search -> Filter (`FilterRoute`)
*   **例**: Item List -> Item Detail (`ItemDetailRoute`)

## 始め方

### 前提条件
- Flutter SDK
- Dart SDK

### セットアップ

1.  **依存関係のインストール**:
    ```bash
    flutter pub get
    ```

2.  **コード生成の実行**:
    Riverpod と GoRouter のために必要です。
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **テストの実行**:
    ```bash
    flutter test
    ```

4.  **アプリの実行**:
    ```bash
    flutter run
    ```
