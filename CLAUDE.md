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
4. docs/common/ui-design-guidelines.md（UI/UXデザインガイドライン）

## Claude Code固有の指示

- コード生成時は必ず `flutter analyze` を実行して確認すること
- 新しいファイルを作成する際は、既存の命名規則に従うこと（docs/common/coding-conventions.md 参照）
- ルート定義やRiverpod Providerを変更した場合は、コード生成を実行すること：
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- 新機能追加時は、docs/implementation/how-to/add-feature.md の手順に従うこと
- 画面遷移追加時は、docs/implementation/how-to/add-navigation.md の手順に従うこと
- UI実装時は、docs/common/ui-design-guidelines.md に従い、Material Design 3 コンポーネントを使用すること

## 新機能のアイデア出しワークフロー

**重要**: 新機能のアイデアを検討する際は、必ずbrainstormサブエージェントを使用してください。

### 使い方

#### パターン1: 自動委譲（推奨）
ユーザーが新機能のアイデアや改善案を求めた場合、自動的にbrainstormサブエージェントに委譲します。

```
ユーザー: 通知機能を改善するアイデアを出したい
→ Claude Codeが自動的にbrainstormサブエージェントに委譲
→ Phase 1-4のプロセスを実行
→ 結果をADRとして文書化
```

#### パターン2: 明示的指定
必要に応じて明示的にbrainstormサブエージェントを呼び出すこともできます。

```
Use the brainstorm subagent to generate ideas for [feature]
```

### よくある呼び出しフレーズ

**自動委譲されるフレーズ例**（これらを検出したらbrainstormサブエージェントに委譲）：

**日本語**:
- "○○機能のアイデアを出したい"
- "○○を改善したい"
- "○○の改善案を検討したい"
- "新機能を考えたい"
- "○○のbrainstormをしたい"
- "○○について発想を広げたい"

**英語**:
- "Generate ideas for [feature]"
- "Improve [feature]"
- "Brainstorm [feature] improvements"
- "Think of new features for [feature]"
- "Explore improvement opportunities for [feature]"

**明示的指定**:
- "Use the brainstorm subagent for [feature]"
- "brainstormエージェントを使って○○のアイデアを出して"

### brainstormサブエージェントの実行プロセス

1. **Phase 1: 文脈理解と初期アイデア生成**
   - 既存コードベースを分析
   - 制約条件を洗い出し
   - 初期アイデア3-5案を生成

2. **Phase 2: アイデア拡張（Gemini brainstorm利用）**
   - Gemini brainstormツールで多様なアイデアを生成
   - 10-15個のアイデアに拡張

3. **Phase 3: 技術検証（必要時）**
   - Gemini/Codexで技術的実現可能性を検証
   - リスクと対策を明確化

4. **Phase 4: 統合・評価・決定**
   - 6つの評価基準で総合評価
   - 上位3-5案を選定
   - 推奨順位を決定

### 評価基準（Phase 4）

各アイデアを以下の6つの観点で評価（100点満点）：

1. **アーキテクチャ適合性** (20%) - 既存設計との整合性
2. **実装コスト** (15%) - 開発工数と複雑度
3. **ユーザー価値** (25%) - 課題解決の効果
4. **保守性** (15%) - 長期的な維持のしやすさ
5. **拡張性** (15%) - 将来的な発展の余地
6. **技術的リスク** (10%) - 実現可能性と不確実性

### 次のステップ

brainstormサブエージェントの実行後：

1. **結果の確認**: 生成されたアイデアとスコアを確認
2. **ADRの作成**: 選定されたアイデアをADRとして文書化（`docs/specification/architecture/decisions/`）
3. **Plan Modeへ**: 詳細設計が必要な場合はPlan Modeに移行

### 詳細ドキュメント

- [アイデア出しガイド](docs/implementation/how-to/brainstorm-ideas.md) - 詳細な手順
- [brainstormサブエージェント定義](.claude/agents/brainstorm.md) - エージェントの仕様

## 新機能開発ワークフロー全体

新機能を開発する際は、以下のワークフローに従ってください：

### ステップ1: アイデア出し（brainstorm）

**エージェント**: `brainstorm`

**入力**: 機能のアイデア・要望

**処理**:
- Phase 1: 既存コードベース分析、制約条件洗い出し
- Phase 2: Gemini brainstormで多様なアイデア生成（12-15個）
- Phase 3: 技術検証（必要に応じてCodex/Gemini使用）
- Phase 4: 6つの観点で評価、Top 3-5案を選定

**出力**: ADR提案（複数案、評価付き）

**成果物**: `docs/specification/architecture/decisions/XXXX-{feature-name}.md`

**次のステップ**: ユーザーがADR案を1つ選択

---

### ステップ2: ユーザー選択

**アクション**:
- 提案から1つ選択
- または、別視点での再検討依頼

**所要時間**: 数分〜

**次のステップ**: designerエージェントに進む

---

### ステップ3: 実装設計（designer）

**エージェント**: `designer`

**入力**: 選択されたADR

**処理**:
- Phase 1: コンテキスト収集（ADR、共通ドキュメント、既存コード）
- Phase 2: 既存実装パターン分析
- Phase 3: 実装設計書作成（ハイブリッド形式、500-800行）
- Phase 4: Codexによる自動レビュー
- Phase 5: レビュー結果反映、最終出力

**出力**: 実装設計書

**成果物**: `docs/specification/implementation-designs/XXXX-{feature-name}.md`

**ハイブリッド形式**:
- ✅ ビジネスロジック（完全実装）
- ✅ データモデル構造（完全実装）
- ✅ ルート定義（完全実装）
- ✅ テストケース（完全実装）
- ⚡ ボイラープレート（概要のみ）

**次のステップ**: ユーザーが実装設計書をレビュー

---

### ステップ4: ユーザーレビュー

**アクション**:
- 実装設計書の承認
- または、修正指示

**所要時間**: 数分〜

**次のステップ**: spec-updaterエージェントに進む

---

### ステップ5: 仕様書作成/更新（spec-updater）

**エージェント**: `spec-updater`

**入力**: 承認された実装設計書

**処理**:
- Phase 1: コンテキスト収集（実装設計書、ADR、既存仕様書）
- Phase 2: 影響範囲分析（新規作成 or 更新を判断）
- Phase 3: 機能仕様書の作成/更新
- Phase 4: UI設計書の作成/更新
- Phase 5: Geminiによる自動レビュー
- Phase 6: レビュー結果反映と修正
- Phase 7: 最終確認とユーザー報告

**出力**: 機能仕様書・UI設計書

**成果物**:
- `docs/specification/features/{feature-name}.md`（新規 or 更新）
- `docs/specification/ui-design/{screen-name}-design.md`（新規 or 更新）

**レビュー観点**（Gemini）:
- ドキュメント構造の完全性
- ユーザーストーリーの妥当性
- Material Design 3への準拠
- テストシナリオの網羅性
- アクセシビリティ要件

**次のステップ**: ユーザーが最終承認

---

### ステップ6: ユーザー承認

**アクション**: 仕様書の最終確認

**所要時間**: 数分〜

**次のステップ**: 実装フェーズへ

---

### ステップ7: 実装

**エージェント**: `implementer`（または手動実装）

**入力**: 承認された設計書・仕様書

**処理**:
- 実装設計書の「実装手順」セクションに従う
- コード実装、テスト作成
- コード生成実行
- 静的解析、フォーマット

**成果物**: 動作する機能

---

### ワークフロー図

```
┌──────────────┐
│  brainstorm  │ ADR提案（複数案）
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ ユーザー選択  │ 1案を選択
└──────┬───────┘
       │
       ▼
┌──────────────┐
│   designer   │ 実装設計書作成 + Codexレビュー
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ユーザーレビュー│ 承認 or 修正指示
└──────┬───────┘
       │
       ▼
┌──────────────┐
│spec-updater  │ 機能仕様書・UI設計書作成/更新 + Geminiレビュー
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ ユーザー承認  │ 最終確認
└──────┬───────┘
       │
       ▼
┌──────────────┐
│     実装     │ コード実装
└──────────────┘
```

### エージェント定義ファイル

- `.claude/agents/brainstorm.md` - アイデア出しエージェント
- `.claude/agents/designer.md` - 実装設計エージェント
- `.claude/agents/spec-updater.md` - 仕様書作成/更新エージェント

### ドキュメント体系

```
docs/specification/
├── architecture/
│   └── decisions/              ← ADR（提案書、1対1）
│       └── XXXX-feature.md
├── implementation-designs/     ← 実装設計書（ADRと1対1）
│   └── XXXX-feature.md
├── features/                   ← 機能仕様書（多対多）
│   └── feature-name.md
└── ui-design/                  ← UI設計書（多対多）
    └── screen-name-design.md
```

**重要**: ADRと実装設計書は必ず1対1の関係。機能仕様書・UI設計書は複数のADRから参照・更新される可能性がある。

## Plan Mode時のドキュメント作成ルール

**必須**: Plan Modeで実装計画を作成する際は、必ず以下のルールに従うこと：

1. **プラン文書の作成場所**
   - `docs/specification/architecture/decisions/` 配下にADR（Architecture Decision Record）形式で保存
   - ファイル名形式: `XXXX-{feature-name}.md` (例: `0001-notification-feature.md`)
   - 連番は既存のADRファイルの次の番号を使用

2. **ADR文書の構成**
   - タイトル: `ADR-XXXX: {機能名}`
   - 作成日とステータス（提案中/承認済み/却下）を明記
   - **ADRはコンパクトに（目標: 300-500行）**
   - 以下のセクションを含める：
     - 概要
     - 背景
     - ユーザー要件
     - アーキテクチャ判断（配置場所、実装方法など）
     - 実装ファイル一覧（新規/変更）
     - アーキテクチャ設計（**コード例は最小限**：型定義とインターフェースのみ）
     - プラットフォーム設定
     - 実装順序
     - 既存コードへの影響
     - テスト計画
     - 将来の拡張性
     - 代替案（検討したが却下した選択肢）
     - 決定事項
     - 次のアクション
     - 参考資料

   **コード例のガイドライン**:
   - ❌ 完全な実装コードを含めない
   - ❌ エラーハンドリングやJSON変換の詳細を書かない
   - ✅ データモデルの構造（型定義のみ）
   - ✅ 主要なインターフェース（メソッドシグネチャのみ）
   - ✅ アーキテクチャ判断の理由を明確に記載

3. **プラン承認のタイミング**
   - ADR文書を作成してから ExitPlanMode を呼び出すこと
   - ユーザーはADR文書を確認してから実装を承認する
