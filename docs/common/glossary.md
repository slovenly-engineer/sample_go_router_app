# 用語集

## アーキテクチャ関連

### Feature-First アーキテクチャ

コードを技術的なレイヤーではなく、機能ごとに整理するアーキテクチャパターン。

### HierarchyRoute

階層構造を持つ画面用のルートタイプ。タブ内遷移で使用され、ボトムナビゲーションバーは表示されたまま。

### ModalRoute

モーダルや全画面詳細用のルートタイプ。タブを覆う遷移で使用され、ボトムナビゲーションバーは隠れる。

### AppNavigator

全ての画面遷移を集約するクラス。BuildContextに依存せずに画面遷移を実行可能。

## 状態管理関連

### Riverpod

Flutter向けの状態管理ライブラリ。型安全性とテスト容易性を提供。

### Provider

Riverpodで状態を提供する仕組み。`@riverpod` アノテーションで定義。

### ViewModel

ページのビジネスロジックを管理するクラス。Riverpod Providerとして実装。

## ルーティング関連

### TypedGoRoute

型安全なルート定義。`go_router_builder` で生成される。

### StatefulShellRoute

ボトムナビゲーションを実現するためのルートタイプ。タブの状態を保持。

### GoRouter

Flutterのルーティングライブラリ。宣言的なルート定義を提供。

## 開発関連

### コード生成

`build_runner` を使用して、Riverpod ProviderやGoRouterのルート定義を自動生成する仕組み。

### ホットリロード

Flutterの開発機能。コード変更を即座に反映。

### ホットリスタート

Flutterの開発機能。アプリの状態をリセットして再起動。
