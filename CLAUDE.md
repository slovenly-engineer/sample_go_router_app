# Claude Code 開発ガイド

## 重要原則

- 共通情報は記載しない。すべて docs/common/ を参照すること
- このファイルには差分のみを記載する

## 警告

このファイルには差分のみを記載しています。
実装時は必ず docs/implementation/index.md を参照してください。
参照を忘れた場合、実装が不完全になる可能性があります。

## 実装支援時の参照先

実装支援時は、以下の順序で情報を参照してください：

1. docs/implementation/index.md（実装支援の入口）
2. docs/common/architecture-principles.md（アーキテクチャ原則）
3. docs/common/coding-conventions.md（コーディング規約）

## Claude Code固有の指示

- コード生成時は必ず `flutter analyze` を実行して確認すること
- 新しいファイルを作成する際は、既存の命名規則に従うこと（docs/common/coding-conventions.md 参照）
- ルート定義やRiverpod Providerを変更した場合は、コード生成を実行すること：
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- 新機能追加時は、docs/implementation/how-to/add-feature.md の手順に従うこと
- 画面遷移追加時は、docs/implementation/how-to/add-navigation.md の手順に従うこと
