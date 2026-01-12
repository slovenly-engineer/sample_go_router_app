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

### 仕様作成時の指示

- 仕様作成時は、docs/specification/templates/feature-spec.md のテンプレートに従うこと
- 既存の機能仕様（docs/specification/features/）を参考にすること
- アーキテクチャ原則（docs/common/architecture-principles.md）に従うこと

### レビュー時の指示

- レビュー時は、docs/review/criteria/ のすべての項目を確認すること
- レビューチェックリスト（docs/review/checklist.md）を使用すること
- 品質基準（docs/review/quality-standards.md）を満たしているか確認すること

### ドキュメント作成時の指示

- ドキュメント作成時は、docs/specification/templates/ のテンプレートを使用すること
- 既存のドキュメントと一貫性を保つこと
