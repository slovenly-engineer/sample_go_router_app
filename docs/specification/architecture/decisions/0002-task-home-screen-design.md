# ADR-0002: タスク管理アプリのホーム画面設計

## ステータス

承認済み

## 作成日

2026-01-26

## 承認日

2026-01-26

## 概要

タスク管理アプリのホーム画面を設計するにあたり、徹底的なアイデア出しと評価を実施しました。Phase 1-4の4フェーズプロセスを通じて、初期アイデア5案とGemini brainstormによる拡張15案、合計20案から有望な10案に絞り込み、6つの評価基準（アーキテクチャ適合性、実装コスト、ユーザー価値、保守性、拡張性、技術的リスク）で総合評価しました。

その結果、**カテゴリ別タブ型ホーム画面（91点）**が最高評価を獲得し、第1推奨案として選定されました。TabBarで「すべて」「今日」「期限切れ」などのカテゴリを切り替える設計で、実装コストが低く、ユーザー価値と拡張性が高いバランスの取れたアプローチです。

## 背景

現在のホーム画面はデモ用のシンプルなボタンのみで、タスク管理アプリとしての実用的な機能が実装されていません。タスクリストの表示、検索・フィルター機能、タスクの追加・編集・完了といった基本的なタスク管理機能が必要です。

## ユーザー要件

- タスクリスト・一覧表示
- 検索・フィルター機能
- タスクの追加・編集・完了が簡単にできる
- 多数のタスク（100+）でもスムーズに動作
- 直感的なUI/UX

## アーキテクチャ判断

### 推奨アイデア Top 5

評価基準：アーキテクチャ適合性(20%), 実装コスト(15%), ユーザー価値(25%), 保守性(15%), 拡張性(15%), 技術的リスク(10%)

#### 1. カテゴリ別タブ型ホーム画面 (91/100点) ⭐ 最優先推奨

**選定理由**:
- 6つの評価基準で最もバランスが良く、総合91点を獲得
- 実装コストが低い（TabBar + フィルタリングロジック）
- ユーザー価値が高い（カテゴリ切り替えで柔軟な表示）
- 拡張性に優れる（タブ追加で容易に機能拡張）
- アーキテクチャ適合性が高い（既存パターンに完全に沿う）

**実装方針**:
- 配置場所: `features/home/`
- 主要コンポーネント:
  - `HomePage`: TabBar付きのメイン画面
  - `TaskListView`: タスクリストWidget（再利用可能）
  - `HomeViewModel`: タスクリストとフィルター状態を管理
  - `TaskRepository`: タスクデータの取得・更新
- データフロー:
  1. ViewModelがRepositoryからタスクリストを取得
  2. 選択されたタブに応じてタスクをフィルタリング
  3. フィルタリングされたリストをUIに表示
  4. タスクの追加・編集・完了はViewModelのメソッド経由

**タブの種類（初期実装）**:
- 「すべて」: 全タスクを表示
- 「今日」: 期限が今日のタスク
- 「期限切れ」: 期限を過ぎたタスク
- 「完了済み」: 完了したタスク

**技術的特徴**:
- Flutter標準の`TabBar`と`TabBarView`を使用
- Riverpodの`select`でタブごとの効率的なフィルタリング
- `ListView.builder`で100+タスクでも高パフォーマンス
- 実装難易度: Low
- 新規パッケージ: 不要

#### 2. 3つのホライゾン（Now, Next, Later） (88/100点)

**選定理由**:
- 戦略的なタスクプランニングを実現
- 実装がシンプルで保守性が高い
- ユニークな視点を提供（短期・中期・長期の俯瞰）

**実装方針**:
- 配置場所: `features/home/`
- 主要コンポーネント:
  - `HorizonView`: 3つの水平スクロール可能なリストを配置
  - `HorizonSection`: 各ホライゾンのセクション
  - `HorizonViewModel`: 3つのホライゾンの状態を管理
- データフロー:
  1. ViewModelがタスクリストを期限で分類
  2. 「今日」「今週」「それ以降」の3つのリストに分割
  3. 各リストを水平スクロールで表示

**技術的特徴**:
- 3つの`ListView.builder`を水平配置
- Riverpodで1つのタスクリストから3つのフィルタリング済みProviderを派生
- 実装難易度: Low
- 新規パッケージ: 不要

#### 3. シンプルリスト型ホーム画面 (87/100点)

**選定理由**:
- 最も基本的で確実なアプローチ
- MVP（最小限の製品）として最適
- 他のアイデアのベースとして機能
- アーキテクチャ適合性が満点（20/20）

**実装方針**:
- 配置場所: `features/home/`
- 主要コンポーネント:
  - `HomePage`: AppBar + SearchBar + ListView
  - `TaskListTile`: タスクアイテムWidget
  - `HomeViewModel`: タスクリストと検索・フィルター状態を管理
- データフロー:
  1. ViewModelがRepositoryからタスクリストを取得
  2. 検索クエリとフィルター条件に基づいてフィルタリング
  3. フィルタリング済みリストをListView.builderで表示

**技術的特徴**:
- Flutter標準のWidget構成
- 最もシンプルで理解しやすい
- 実装難易度: Low
- 新規パッケージ: 不要

#### 4. スリッパリー優先度リスト (86/100点)

**選定理由**:
- 直感的な優先順位付け（ドラッグ&ドロップで順序変更）
- 実装が容易で保守性が高い
- 明示的な優先度フラグ不要のシンプル設計

**実装方針**:
- 配置場所: `features/home/`
- 主要コンポーネント:
  - `ReorderableListView`を使用
  - `onReorder`コールバックでViewModelの状態を更新
  - リストの順序自体が優先度を表現
- データフロー:
  1. ViewModelがタスクリストを優先度順に管理
  2. ユーザーがドラッグ&ドロップで順序変更
  3. `onReorder`でViewModelが順序を更新
  4. 更新された順序をRepositoryに永続化

**技術的特徴**:
- Flutter標準の`ReorderableListView`
- リスト再描画はフレームワークが最適化
- 実装難易度: Low
- 新規パッケージ: 不要

#### 5. ダッシュボード型ホーム画面 (82/100点)

**選定理由**:
- 情報の俯瞰に優れる（進捗、統計、直近のタスク）
- 拡張性が高い（ウィジェット追加で機能拡張）
- ユーザーに全体像を提供

**実装方針**:
- 配置場所: `features/home/`
- 主要コンポーネント:
  - `DashboardView`: 複数のカードを配置
  - `ProgressSummaryCard`: 進捗サマリー
  - `RecentTasksCard`: 直近のタスク
  - `StatisticsCard`: 統計情報
  - `DashboardViewModel`: 集計データを管理
- データフロー:
  1. ViewModelがタスクリストから統計を計算
  2. 進捗率、完了数、残タスク数などを集計
  3. 各カードに集計データを渡して表示

**技術的特徴**:
- Riverpodの`select`や`Computed`で効率的な集計
- タスク数に応じた集計処理の負荷に配慮
- 実装難易度: Medium
- 新規パッケージ: `fl_chart`（グラフ表示用、オプション）

### 実装ファイル一覧

#### 新規作成（第1推奨案: カテゴリ別タブ型）

```
features/home/
├── data/
│   ├── task_model.dart - タスクデータモデル
│   └── task_repository.dart - タスクデータ操作
├── presentation/
│   ├── home_page.dart - TabBar付きメイン画面（既存を更新）
│   ├── home_view_model.dart - 状態管理（既存を更新）
│   ├── widgets/
│   │   ├── task_list_view.dart - タスクリストWidget
│   │   ├── task_list_tile.dart - タスクアイテムWidget
│   │   ├── task_filter_button.dart - フィルターボタン
│   │   └── add_task_fab.dart - タスク追加FAB
└── home_route.dart - ルート定義（既存）
```

#### 変更

- `features/home/presentation/home_page.dart` - TabBar実装に更新
- `features/home/presentation/home_view_model.dart` - タスクリストとフィルター状態管理を追加

## アーキテクチャ設計

### データモデル

#### TaskModel

```dart
class TaskModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
}
```

#### HomeState

```dart
class HomeState {
  final List<TaskModel> tasks;
  final TaskFilter selectedFilter;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const HomeState({
    required this.tasks,
    required this.selectedFilter,
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });
}

enum TaskFilter {
  all,
  today,
  overdue,
  completed,
}
```

### 主要インターフェース

#### TaskRepository

```dart
@riverpod
class TaskRepository {
  Future<List<TaskModel>> fetchTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<void> toggleTaskCompletion(String taskId);
}
```

#### HomeViewModel

```dart
@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build();

  Future<void> loadTasks();
  Future<void> addTask(String title, {String? description, DateTime? dueDate});
  Future<void> toggleTaskCompletion(String taskId);
  Future<void> deleteTask(String taskId);
  void setFilter(TaskFilter filter);
  void setSearchQuery(String query);
}
```

**実装の詳細は別途、実装フェーズで検討します。**

## プラットフォーム設定

### 新規パッケージ

第1推奨案（カテゴリ別タブ型）では新規パッケージは不要です。
将来的な拡張（ダッシュボード型など）では以下のパッケージを検討：

```yaml
dependencies:
  # グラフ表示（ダッシュボード型で使用）
  fl_chart: ^0.69.0  # オプション

  # 日付処理（タイムライン型で使用）
  intl: ^0.20.2  # オプション

  # ドラッグ&ドロップ（カンバン型で使用）
  drag_and_drop_lists: ^0.4.1  # オプション
```

### 設定変更

現時点で設定変更は不要です。

## 実装順序

### フェーズ1: データ層の構築 (見積もり期間: 2-3日)

1. **タスクデータモデルの定義** (0.5日)
   - `TaskModel`クラスの実装
   - JSON変換メソッド（将来的なAPI連携用）
   - イミュータブル設計

2. **タスクリポジトリの実装** (1.5日)
   - `TaskRepository`の実装
   - ローカルストレージ（SharedPreferencesまたはHive）での永続化
   - CRUD操作の実装
   - モックデータの準備（開発用）

3. **Riverpod Provider設定** (0.5日)
   - `@riverpod`アノテーションでRepository Provider定義
   - コード生成実行

### フェーズ2: ViewModel層の構築 (見積もり期間: 2-3日)

1. **HomeViewModel基本実装** (1日)
   - `HomeState`の定義
   - タスクリスト取得ロジック
   - エラーハンドリング

2. **フィルタリングロジック** (1日)
   - `TaskFilter`列挙型の定義
   - 各フィルター（すべて、今日、期限切れ、完了済み）のロジック
   - 検索機能の実装

3. **タスク操作メソッド** (0.5日)
   - タスク追加
   - タスク完了トグル
   - タスク削除

### フェーズ3: UI層の実装 (見積もり期間: 3-4日)

1. **基本Widget構築** (1日)
   - `TaskListTile`の実装
   - `TaskListView`の実装
   - `AddTaskFab`の実装

2. **HomePage更新** (1.5日)
   - TabBarの実装
   - TabBarViewの設定
   - AppBarとSearchBarの統合
   - FloatingActionButtonの配置

3. **UI/UXの改善** (1日)
   - ローディング状態の表示
   - エラー状態の表示
   - 空状態の表示（タスクが0件のとき）
   - アニメーション（タスク完了時など）

### フェーズ4: テストと改善 (見積もり期間: 2-3日)

1. **ユニットテスト** (1日)
   - ViewModelのテスト
   - Repositoryのテスト
   - フィルタリングロジックのテスト

2. **統合テスト** (1日)
   - タスク追加→表示のフロー
   - タスク完了→フィルタリングのフロー
   - 検索機能のテスト

3. **パフォーマンステスト** (0.5日)
   - 100+タスクでのスクロール性能
   - フィルター切り替えの応答性

## 既存コードへの影響

### 変更が必要なファイル

1. `features/home/presentation/home_page.dart`
   - 既存のシンプルなボタンUI → TabBar + TaskListViewに全面的に書き換え
   - ConsumerWidgetとしての構造は維持

2. `features/home/presentation/home_view_model.dart`
   - 既存のデモ用ViewModelロジック → タスクリストとフィルター状態管理に更新
   - `@riverpod`アノテーションは維持

3. `features/home/home_route.dart`
   - ルート定義は変更なし（HomePageのUIが変わるだけ）

### 破壊的変更

なし。ホーム画面のUI実装を全面的に更新しますが、ルーティングやナビゲーション構造には影響しません。

## テスト計画

### ユニットテスト

- `TaskRepository`:
  - タスクの追加・取得・更新・削除
  - 永続化の動作確認
- `HomeViewModel`:
  - タスクリストの読み込み
  - フィルタリングロジック（all, today, overdue, completed）
  - 検索クエリのフィルタリング
  - タスク操作（追加、完了トグル、削除）
- `TaskModel`:
  - データモデルのバリデーション

### 統合テスト

- タスク追加フロー:
  1. FABタップ → ダイアログ表示
  2. タスク情報入力 → 保存
  3. タスクリストに表示される
- タスク完了フロー:
  1. タスクのチェックボックスタップ
  2. タスクが完了状態になる
  3. 「完了済み」タブに移動する
- フィルタリングフロー:
  1. タブ切り替え
  2. 適切なタスクのみが表示される

### 手動テスト

- 100+タスクでのスクロール性能
- タブ切り替えの応答性
- 検索機能の使いやすさ
- UI/UXの直感性
- iOS/Androidでの動作確認

## 将来の拡張性

### 考慮されている拡張

1. **追加のタブ/フィルター** - タブ追加で容易に実装可能
   - 「優先度高」タブ
   - 「今週」タブ
   - カスタムフィルター

2. **タスク詳細画面** - ModalRoute経由で詳細画面に遷移
   - タスクの詳細情報表示
   - サブタスク機能
   - 添付ファイル

3. **カテゴリ/プロジェクト機能** - タスクモデルにカテゴリフィールドを追加
   - プロジェクトごとのタブ
   - カテゴリフィルター

4. **タスクの並び替え** - ReorderableListViewへの移行が容易
   - 優先度順、期限順、作成日順
   - カスタム順序（スリッパリー優先度リスト）

5. **統計・ダッシュボード** - ダッシュボード型への拡張
   - 進捗サマリーカード
   - グラフ表示

6. **リマインダー・通知** - 既存のflutter_local_notificationsを活用
   - 期限前通知
   - 定期的なリマインダー

### 拡張のための設計配慮

- **TaskModel**: 将来的なフィールド追加を考慮した柔軟な設計
- **TaskFilter**: 列挙型で拡張可能
- **TaskRepository**: インターフェースとして設計し、実装を差し替え可能（ローカル→API）
- **HomeViewModel**: フィルタリングロジックを分離し、新しいフィルターの追加が容易
- **TaskListView**: 再利用可能なWidgetとして設計し、他の画面でも利用可能

## 代替案

### 検討したが却下した案

#### 1. カンバンボード型 (80点)
- **理由**: 実装コストが高い（Medium）、ドラッグ&ドロップの実装難易度、保守性がやや低い
- **将来的な実装の可能性**: あり（タブの一つとして「カンバンビュー」を追加する形で実装可能）
- **条件**: ユーザーからの要望が強い場合、またはMVP後の機能拡張として検討

#### 2. タイムライン型 (81点)
- **理由**: 実装コスト（Medium）、日付グルーピング処理の複雑さ
- **将来的な実装の可能性**: あり（カレンダー機能の追加時に検討）
- **条件**: カレンダー統合機能の需要が明確になった場合

#### 3. フォーカスタイマー・モード (81点)
- **理由**: やや特殊なアプローチ、通知権限の必要性、他機能との統合が課題
- **将来的な実装の可能性**: あり（独立した機能として追加）
- **条件**: ポモドーロテクニック機能の需要が確認できた場合

#### 4. アイゼンハワー・マトリクス・ボード (72点)
- **理由**: 実装コストが最も高い（High）、複雑なD&Dロジック、保守性が低い
- **将来的な実装の可能性**: 低い（UXの複雑さと実装コストが見合わない）
- **条件**: 特定のパワーユーザー層からの強い要望がある場合のみ

#### 5. プロジェクト中心サマリー (80点)
- **理由**: プロジェクト機能が未実装のため、前提条件が揃っていない
- **将来的な実装の可能性**: あり（プロジェクト機能実装後）
- **条件**: プロジェクト管理機能が必要になった場合

#### 6. その他（AIおすすめリスト、ゲーミフィケーション等）
- **理由**: 実装コストが高い、技術的制約（AI/NLP）、本質的な機能ではない
- **将来的な実装の可能性**: 低い
- **条件**: 基本機能が完成し、差別化要素として必要になった場合

## 参考資料

- [Flutter TabBar公式ドキュメント](https://api.flutter.dev/flutter/material/TabBar-class.html)
- [Riverpod公式ドキュメント](https://riverpod.dev/)
- [Flutter ListView.builder パフォーマンスガイド](https://docs.flutter.dev/perf/best-practices)
- [Material Design - Lists](https://m3.material.io/components/lists/overview)
- プロジェクト内ドキュメント:
  - `docs/common/architecture-principles.md`
  - `docs/common/coding-conventions.md`
  - `docs/implementation/how-to/add-feature.md`

## 決定事項

### 実装順序の確定

**第1優先: カテゴリ別タブ型ホーム画面**
- 理由: 最高評価（91点）、実装コストが低く、ユーザー価値と拡張性が高い
- 実装期間: 9-13日（データ層→ViewModel層→UI層→テスト）
- MVP（最小限の製品）として最適

**第2優先以降（将来的な拡張として検討）**:
1. **3つのホライゾン型** - 戦略的プランニング機能として追加
2. **スリッパリー優先度リスト** - タブの一つとして「カスタム順序」ビューを追加
3. **ダッシュボード型** - 統計情報表示機能として追加
4. **カンバンボード型** - ユーザー要望が強い場合にビューオプションとして追加

### 技術選定

- **状態管理**: Riverpod 3.1.0（`@riverpod`アノテーション）
- **データ永続化**: SharedPreferences または Hive（軽量なローカルストレージ）
  - 初期実装: SharedPreferences（シンプル）
  - 将来的な拡張: Hive（パフォーマンス重視）またはAPI連携
- **UI Framework**: Flutter標準Widget（TabBar, TabBarView, ListView.builder）
- **新規パッケージ**: 不要（既存パッケージで実装可能）

### アーキテクチャ方針

- **Feature-First Architecture**: `features/home/`配下に実装
- **レイヤー分離**: data / presentation の明確な分離
- **Immutable State**: `copyWith()`パターンで状態管理
- **Type-Safe Navigation**: 既存のgo_router_builder活用（ルート変更なし）
- **再利用可能なWidget**: `TaskListView`, `TaskListTile`など独立したWidgetとして設計

## 次のアクション

- [x] Plan Modeで作成したこのADRをレビュー
- [x] 実装の承認を得る
- [x] ドキュメント作成（Step 0）
  - [x] 機能仕様書作成（`docs/specification/features/task-management-home.md`）
  - [x] 画面設計書作成（`docs/specification/ui-design/task-home-screen-design.md`）
  - [x] Pencilでのデザイン作成（`designs/task-home-screen.pen`）
- [ ] フェーズ1（データ層）の実装開始
- [ ] タスクモデルの詳細設計（フィールドの最終決定）
- [ ] ローカルストレージの選定（SharedPreferences vs Hive）
- [ ] モックデータの準備
