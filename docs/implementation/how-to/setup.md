# セットアップ手順

## 前提条件

- Flutter SDK がインストールされていること
- Dart SDK ^3.10.3 以上
- エディタ（VS Code または Android Studio）がインストールされていること

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd sample_go_router_app
```

### 2. 依存関係のインストール

```bash
flutter pub get
```

### 3. コード生成の実行

Riverpod と GoRouter のコード生成を実行します。

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. アプリの実行

```bash
flutter run
```

## 開発環境の確認

### 動作確認

以下のコマンドで、プロジェクトが正しくセットアップされているか確認できます。

```bash
# 依存関係の確認
flutter pub get

# コード生成の確認
flutter pub run build_runner build --delete-conflicting-outputs

# テストの実行
flutter test

# 静的解析
flutter analyze
```

## よく使うコマンド

### 開発中

```bash
# ホットリロード（実行中）
r キーを押す

# ホットリスタート（実行中）
R キーを押す

# デバッグ情報の表示
flutter run --verbose
```

### コード生成

```bash
# 一度だけ実行
flutter pub run build_runner build --delete-conflicting-outputs

# ウォッチモード（変更を監視）
flutter pub run build_runner watch --delete-conflicting-outputs
```

### テスト

```bash
# 全テスト実行
flutter test

# 特定のテストファイル実行
flutter test test/features/items/item_test.dart

# カバレッジ付きテスト
flutter test --coverage
```

### ビルド

```bash
# Android APK
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

## トラブルシューティング

### コード生成エラー

```bash
# 生成ファイルを削除して再生成
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### 依存関係エラー

```bash
# pubspec.lockを削除して再取得
rm pubspec.lock
flutter pub get
```

### キャッシュクリア

```bash
# Flutterキャッシュのクリア
flutter clean
flutter pub get
```
