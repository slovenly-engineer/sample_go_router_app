# プロジェクト概要

## プロジェクト名

sample_go_router_app

## 目的

GoRouterとRiverpodを使用した、堅牢で型安全な画面遷移アーキテクチャを示すFlutterアプリケーションです。

## 主な特徴

- **Feature-First アーキテクチャ**: コードはレイヤーごとではなく、機能ごとに整理されています
- **型安全なナビゲーション**: `go_router_builder` (`TypedGoRoute`) を使用し、タイプセーフな遷移を実現
- **統一されたナビゲーションロジック**: 全ての画面遷移は `AppNavigator` クラスに集約
- **BuildContext非依存**: ViewModelやRepositoryから `BuildContext` に依存せずに遷移を実行可能

## 技術スタック

- **フレームワーク**: Flutter
- **言語**: Dart (SDK ^3.10.3)
- **主要パッケージ**:
  - `go_router: ^17.0.0` - ルーティング
  - `riverpod: ^3.0.3` - 状態管理
  - `go_router_builder: ^4.1.3` - 型安全なルーティング生成
  - `riverpod_generator: ^3.0.3` - Riverpodコード生成
  - `flutter_local_notifications: ^17.2.3` - ローカル通知

## ディレクトリ構造

```
lib/
├── core/           # 共通機能（ルーター、ナビゲーターなど）
│   └── router/
└── features/       # 機能別モジュール
    ├── auth/
    ├── home/
    ├── items/
    ├── mypage/
    ├── notifications/
    └── search/
```
