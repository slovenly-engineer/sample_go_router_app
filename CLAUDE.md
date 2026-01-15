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

## Plan Mode時のドキュメント作成ルール

**必須**: Plan Modeで実装計画を作成する際は、必ず以下のルールに従うこと：

1. **プラン文書の作成場所**
   - `docs/specification/architecture/decisions/` 配下にADR（Architecture Decision Record）形式で保存
   - ファイル名形式: `XXXX-{feature-name}.md` (例: `0001-notification-feature.md`)
   - 連番は既存のADRファイルの次の番号を使用

2. **ADR文書の構成**
   - タイトル: `ADR-XXXX: {機能名}`
   - 作成日とステータス（提案中/承認済み/却下）を明記
   - 以下のセクションを含める：
     - 概要
     - ユーザー要件
     - アーキテクチャ判断（配置場所、実装方法など）
     - 実装ファイル一覧（新規/変更）
     - 詳細設計（コード例を含む）
     - プラットフォーム設定
     - 実装順序
     - 既存コードへの影響
     - テスト計画
     - 将来の拡張性
     - 代替案（検討したが却下した選択肢）
     - 参考資料

3. **プラン承認のタイミング**
   - ADR文書を作成してから ExitPlanMode を呼び出すこと
   - ユーザーはADR文書を確認してから実装を承認する
