# AGENTS.md

## 重要原則

- 共通情報は記載しない。すべて docs/common/ を参照すること
- このファイルには差分のみを記載する

## 警告

このファイルには差分のみを記載しています。
仕様作成時やレビュー時は、必ず該当するindex.mdを参照してください。
参照を忘れた場合、作業が不完全になる可能性があります。

## 役割別参照先

### 仕様作成時

仕様作成時は、以下の順序で情報を参照してください：

1. docs/specification/index.md（仕様作成の入口）
2. docs/common/architecture-principles.md（アーキテクチャ原則）
3. docs/specification/templates/（仕様テンプレート）

### レビュー時

レビュー時は、以下の順序で情報を参照してください：

1. docs/review/index.md（レビューの入口）
2. docs/review/criteria/（レビュー基準）
3. docs/review/checklist.md（レビューチェックリスト）

### ドキュメント作成時

ドキュメント作成時は、以下を参照してください：

- docs/specification/templates/（ドキュメントテンプレート）

## Codex固有の指示

### Codex Cloud PRレビュー機能について

Codex CloudはGitHub上でPRを作成した際に、PRのコメントに`@codex review`と記述することでコードレビューを依頼できる機能です。この`AGENTS.md`の内容は、Codex Cloudのレビュー時に自動的に適用されます。

- PR上で`@codex review`とコメントすることでレビューを依頼可能
- 自動レビュー機能も利用可能（設定により有効化）
- レビュー以外のタスク（PRのdescription作成など）も`@codex`で依頼可能

### 仕様作成時の指示

- 仕様作成時は、docs/specification/templates/feature-spec.md のテンプレートに従うこと
- 既存の機能仕様（docs/specification/features/）を参考にすること
- アーキテクチャ原則（docs/common/architecture-principles.md）に従うこと

### レビュー時の指示

**重要: すべてのレビューコメントとレビュー結果は日本語で記述すること**

Codex CloudのPRレビュー機能を使用する際は、以下の手順と基準に従ってください：

1. **参照先の確認**
   - 最初に`docs/review/index.md`（レビューの入口）を参照すること
   - `docs/common/architecture-principles.md`（アーキテクチャ原則）を確認すること
   - `docs/common/coding-conventions.md`（コーディング規約）を確認すること

2. **レビュー基準の適用**
   - `docs/review/criteria/`のすべての項目を確認すること
     - アーキテクチャ準拠の確認（criteria/architecture.md）
     - コード品質の確認（criteria/code-quality.md）
     - パターン適用の確認（criteria/patterns.md）

3. **チェックリストの使用**
   - `docs/review/checklist.md`（レビューチェックリスト）を使用すること
   - 該当する項目にチェックを入れる形で確認すること

4. **品質基準の確認**
   - `docs/review/quality-standards.md`（品質基準）を満たしているか確認すること
   - 必須項目はすべて満たされていること
   - 推奨項目も可能な限り満たされていること

5. **レビューコメントの記述**
   - レビューコメントは建設的で具体的な改善提案を含めること
   - 問題点だけでなく、改善方法も提示すること
   - コードの良い点も指摘すること（ポジティブフィードバック）

### ドキュメント作成時の指示

- ドキュメント作成時は、docs/specification/templates/ のテンプレートを使用すること
- 既存のドキュメントと一貫性を保つこと
