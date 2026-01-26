# UI/UXデザインガイドライン

## ドキュメント情報

- **作成日**: 2026-01-26
- **最終更新**: 2026-01-26
- **ステータス**: 承認済み

## 概要

このプロジェクトは**Material Design 3 (MD3)** を正式に採用します。すべてのUI実装はMD3の仕様とコンポーネントに準拠してください。

## 1. デザインシステム

### 1.1 Material Design 3の採用

**重要**: 新規画面やコンポーネントを作成する際は、必ずMD3の標準コンポーネントを使用してください。

- **公式リファレンス**: [Material Design 3](https://m3.material.io/)
- **Flutter実装**: [Material Components for Flutter](https://docs.flutter.dev/ui/widgets/material)

### 1.2 カスタムコンポーネントの制限

MD3コンポーネントで要件を満たせない場合のみ、カスタムWidgetの作成を検討してください。その際は以下を遵守：

1. MD3のデザイントークン（色、タイポグラフィ、スペーシング）を使用
2. アクセシビリティガイドラインに準拠
3. 実装前にチームレビューを受ける

## 2. カラーシステム

### 2.1 MD3カラートークン

Material Design 3のカラーシステムを使用します。テーマ設定は`ThemeData`で一元管理してください。

#### 主要カラー

| トークン | 用途 | ライトモード例 | ダークモード例 |
|---------|------|---------------|---------------|
| **Primary** | 主要なアクション、強調表示 | `#6750A4` | `#D0BCFF` |
| **Secondary** | 補助的なアクション | `#625B71` | `#CCC2DC` |
| **Tertiary** | アクセント、特別な強調 | `#7D5260` | `#EFB8C8` |
| **Error** | エラー状態、警告 | `#BA1A1A` | `#F2B8B5` |
| **Surface** | カード、ダイアログなどの背景 | `#FFFBFE` | `#1C1B1F` |

#### セマンティックカラー

特定の状態を表す色の使用ガイドライン：

| 状態 | 色 | 使用例 |
|------|-----|--------|
| **成功** | Green 500 (`#4CAF50`) | 完了タスク、成功メッセージ |
| **警告** | Orange 700 (`#F57C00`) | 今日期限、注意喚起 |
| **エラー** | MD3 Error | 期限切れ、エラーメッセージ |
| **情報** | Blue 700 (`#1976D2`) | 情報表示、ヒント |

#### コード例

```dart
// ✅ 推奨: ThemeDataのカラートークンを使用
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'テキスト',
    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
  ),
)

// ❌ 非推奨: ハードコードされた色
Container(
  color: Color(0xFF6750A4),
  child: Text('テキスト', style: TextStyle(color: Colors.white)),
)
```

### 2.2 ダークモード対応

すべての画面はライトモード・ダークモードの両方に対応する必要があります。

- `ThemeData.light()` と `ThemeData.dark()` で設定
- ハードコードされた色は使用禁止
- 常に `Theme.of(context).colorScheme.*` を使用

## 3. タイポグラフィシステム

### 3.1 MD3 Type Scale

Material Design 3のタイプスケールを使用します。

| スタイル | サイズ | ウェイト | 用途 |
|---------|-------|---------|------|
| **Display Large** | 57pt | Regular (400) | 最大の見出し |
| **Display Medium** | 45pt | Regular (400) | 大きな見出し |
| **Display Small** | 36pt | Regular (400) | 小さな見出し |
| **Headline Large** | 32pt | Regular (400) | セクション見出し |
| **Headline Medium** | 28pt | Regular (400) | サブセクション見出し |
| **Headline Small** | 24pt | Regular (400) | カード見出し |
| **Title Large** | 22pt | Regular (400) | AppBarタイトル |
| **Title Medium** | 16pt | Medium (500) | リストタイトル |
| **Title Small** | 14pt | Medium (500) | セクションラベル |
| **Body Large** | 16pt | Regular (400) | 本文（大） |
| **Body Medium** | 14pt | Regular (400) | 本文（標準） |
| **Body Small** | 12pt | Regular (400) | 補足テキスト |
| **Label Large** | 14pt | Medium (500) | ボタンテキスト |
| **Label Medium** | 12pt | Medium (500) | タブラベル |
| **Label Small** | 11pt | Medium (500) | 小さなラベル |

### 3.2 コード例

```dart
// ✅ 推奨: ThemeDataのテキストスタイルを使用
Text(
  'タイトル',
  style: Theme.of(context).textTheme.titleLarge,
)

Text(
  '本文テキスト',
  style: Theme.of(context).textTheme.bodyMedium,
)

// ❌ 非推奨: ハードコードされたスタイル
Text(
  'タイトル',
  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
)
```

## 4. スペーシングシステム

### 4.1 8dpグリッドベース

すべてのスペーシングは**8dpの倍数**を基準とします。細かい調整が必要な場合は4dpの倍数を使用できます。

| 用途 | 値 (pt) |
|------|---------|
| **最小スペース** | 4 |
| **小スペース** | 8 |
| **標準スペース** | 16 |
| **中スペース** | 24 |
| **大スペース** | 32 |
| **特大スペース** | 48 |

### 4.2 パディング・マージンのガイドライン

```dart
// ✅ 推奨: 8dpの倍数
Padding(
  padding: EdgeInsets.all(16.0), // 標準パディング
  child: ...,
)

Container(
  margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  child: ...,
)

// ❌ 非推奨: 不規則な値
Padding(
  padding: EdgeInsets.all(13.0), // 8dpの倍数ではない
  child: ...,
)
```

## 5. MD3コンポーネント

### 5.1 標準使用コンポーネント

以下のMD3コンポーネントを積極的に使用してください：

#### ナビゲーション
- `AppBar` - アプリケーションバー
- `NavigationBar` - ボトムナビゲーション
- `NavigationRail` - サイドナビゲーション（タブレット/デスクトップ）
- `TabBar` / `TabBarView` - タブナビゲーション

#### アクション
- `ElevatedButton` - 主要アクション
- `FilledButton` - 強調アクション
- `OutlinedButton` - 副次的アクション
- `TextButton` - 低優先度アクション
- `FloatingActionButton` - FAB

#### コンテナ
- `Card` - カードコンテナ
- `ListTile` - リストアイテム
- `Chip` - タグ、フィルター

#### 入力
- `TextField` - テキスト入力
- `Checkbox` - チェックボックス
- `Switch` - スイッチ
- `Radio` - ラジオボタン
- `Slider` - スライダー

#### フィードバック
- `CircularProgressIndicator` - ローディング
- `LinearProgressIndicator` - プログレスバー
- `SnackBar` - 一時的な通知
- `Dialog` - ダイアログ

### 5.2 コンポーネント選択のガイドライン

#### ボタンの使い分け

```dart
// 主要アクション（最も強調）
FilledButton(
  onPressed: () {},
  child: Text('保存'),
)

// 標準アクション
ElevatedButton(
  onPressed: () {},
  child: Text('送信'),
)

// 副次的アクション
OutlinedButton(
  onPressed: () {},
  child: Text('キャンセル'),
)

// 低優先度アクション
TextButton(
  onPressed: () {},
  child: Text('スキップ'),
)
```

#### リストの実装

```dart
// ✅ 推奨: ListTileを使用
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: Icon(Icons.task_alt),
      title: Text(items[index].title),
      subtitle: Text(items[index].description),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  },
)
```

## 6. アイコンシステム

### 6.1 Material Symbols

Material Symbols（Material Design 3のアイコンセット）を標準使用します。

- **公式**: [Material Symbols](https://fonts.google.com/icons)
- **Flutter**: `Icons`クラス（Material Icons）を使用

### 6.2 アイコンサイズ

| 用途 | サイズ (pt) |
|------|-----------|
| **小アイコン** | 16 |
| **標準アイコン** | 24 |
| **大アイコン** | 32 |
| **特大アイコン** | 48 |

### 6.3 コード例

```dart
// ✅ 推奨: Material Iconsを使用
Icon(Icons.add, size: 24)
Icon(Icons.search, size: 24)

// タップ可能なアイコン
IconButton(
  icon: Icon(Icons.more_vert),
  iconSize: 24,
  onPressed: () {},
)
```

## 7. レスポンシブデザイン

### 7.1 ブレークポイント

| デバイス | 幅 | レイアウト調整 |
|---------|-----|--------------|
| **Compact** | 〜600pt | モバイル標準レイアウト |
| **Medium** | 600〜840pt | タブレット縦向き、左右マージン追加 |
| **Expanded** | 840pt〜 | タブレット横向き、デスクトップ |

### 7.2 実装ガイドライン

```dart
// MediaQueryでブレークポイント判定
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width < 600) {
    // Compact: モバイルレイアウト
    return MobileLayout();
  } else if (width < 840) {
    // Medium: タブレット縦向き
    return TabletLayout();
  } else {
    // Expanded: タブレット横向き、デスクトップ
    return DesktopLayout();
  }
}
```

## 8. アクセシビリティ

### 8.1 コントラスト比

すべてのテキストとアイコンは**WCAG 2.1 AAレベル**を満たす必要があります。

| 要素 | 最小コントラスト比 |
|------|------------------|
| **通常テキスト** | 4.5:1 |
| **大きなテキスト** (18pt以上または14pt Bold以上) | 3:1 |
| **アイコン・グラフィック** | 3:1 |

### 8.2 タップ領域

すべてのインタラクティブ要素は**最小44x44pt**のタップ領域を確保してください。

```dart
// ✅ 推奨: 十分なタップ領域
IconButton(
  icon: Icon(Icons.close),
  iconSize: 24,
  padding: EdgeInsets.all(10), // タップ領域: 44x44pt
  onPressed: () {},
)

// ❌ 非推奨: タップ領域が小さすぎる
GestureDetector(
  onTap: () {},
  child: Icon(Icons.close, size: 16), // タップ領域: 16x16pt
)
```

### 8.3 セマンティクスラベル

スクリーンリーダー対応のため、視覚的な要素には必ずセマンティクスラベルを設定してください。

```dart
// ✅ 推奨: セマンティクスラベル付き
IconButton(
  icon: Icon(Icons.search),
  tooltip: 'タスクを検索',
  onPressed: () {},
)

Semantics(
  label: 'タスクを完了としてマーク',
  child: Checkbox(
    value: isCompleted,
    onChanged: (value) {},
  ),
)
```

## 9. アニメーション

### 9.1 標準アニメーション設定

Material Design 3の推奨値を使用します。

| 用途 | Duration | Curve |
|------|----------|-------|
| **画面遷移** | 300ms | `easeInOut` |
| **要素の出現** | 200ms | `easeIn` |
| **要素の消失** | 250ms | `easeOut` |
| **小さな変化** | 150ms | `easeInOut` |
| **フィードバック** | 100ms | `easeOut` |

### 9.2 コード例

```dart
// ページ遷移
PageRouteBuilder(
  transitionDuration: Duration(milliseconds: 300),
  pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
)

// 要素のアニメーション
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 200),
  curve: Curves.easeIn,
  child: Widget(),
)
```

## 10. レイアウトシステム

### 10.1 Flutterレイアウトの基礎

Flutter のレイアウトは **Constraints go down, Sizes go up, Parent sets position** の原則に従います。

#### Box Constraints

すべてのWidgetは親から制約（BoxConstraints）を受け取り、その範囲内でサイズを決定します。

```dart
// 制約の種類
BoxConstraints(
  minWidth: 0,    // 最小幅
  maxWidth: 400,  // 最大幅
  minHeight: 0,   // 最小高さ
  maxHeight: 600, // 最大高さ
)

// タイトな制約（固定サイズ）
BoxConstraints.tight(Size(200, 100))

// 緩い制約（最大サイズのみ指定）
BoxConstraints.loose(Size(400, 600))
```

#### 制約の種類

| 制約タイプ | 説明 | 例 |
|----------|------|-----|
| **Tight Constraints** | 固定サイズ（min == max） | `Container(width: 100, height: 100)` |
| **Loose Constraints** | 最大サイズのみ指定 | `Container(maxWidth: 400)` |
| **Unbounded Constraints** | 無制限（ListView内など） | `ListView`の子要素 |

### 10.2 レイアウトWidgetの使い分け

#### Column / Row

縦横の線形レイアウトを実装します。

```dart
// ✅ 推奨: Column/Rowの基本構成
Column(
  mainAxisAlignment: MainAxisAlignment.start,    // 主軸（縦）の配置
  crossAxisAlignment: CrossAxisAlignment.center, // 交差軸（横）の配置
  mainAxisSize: MainAxisSize.min,               // 主軸のサイズ
  children: [
    Text('タイトル'),
    SizedBox(height: 16), // スペーサーとして使用
    Text('本文'),
  ],
)

// Row（横方向）
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Icon(Icons.star),
    Text('評価'),
    Text('4.5'),
  ],
)
```

**主要プロパティ**:

| プロパティ | 説明 | 値 |
|-----------|------|-----|
| `mainAxisAlignment` | 主軸の配置 | `start`, `center`, `end`, `spaceBetween`, `spaceAround`, `spaceEvenly` |
| `crossAxisAlignment` | 交差軸の配置 | `start`, `center`, `end`, `stretch`, `baseline` |
| `mainAxisSize` | 主軸のサイズ | `min`（子要素に合わせる）, `max`（可能な限り広げる） |

#### Expanded / Flexible / Spacer

Column/Row内で空きスペースを分配します。

```dart
// ✅ 推奨: Expandedで残りスペースを埋める
Row(
  children: [
    Icon(Icons.person),
    SizedBox(width: 8),
    Expanded(
      child: Text('長いテキストが省略される...', overflow: TextOverflow.ellipsis),
    ),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
)

// Flexibleで柔軟な比率を設定
Row(
  children: [
    Flexible(
      flex: 2, // 2/3のスペースを使用
      child: Container(color: Colors.blue),
    ),
    Flexible(
      flex: 1, // 1/3のスペースを使用
      child: Container(color: Colors.red),
    ),
  ],
)

// Spacerで空白を作る
Row(
  children: [
    Text('左'),
    Spacer(), // 残りスペースを埋める
    Text('右'),
  ],
)
```

**使い分け**:

| Widget | 用途 | 振る舞い |
|--------|------|---------|
| `Expanded` | 残りスペースを全て使う | 必ず親の制約いっぱいに広がる（`fit: FlexFit.tight`） |
| `Flexible` | 柔軟にサイズ調整 | 子のサイズを尊重しつつ、必要に応じて縮む（`fit: FlexFit.loose`） |
| `Spacer` | 空白を作る | `Expanded(child: SizedBox())`と同じ |

#### Stack / Positioned

Widgetを重ねて配置します。

```dart
// ✅ 推奨: Stackで要素を重ねる
Stack(
  children: [
    // 背景画像
    Container(
      width: 200,
      height: 200,
      color: Colors.grey[300],
    ),
    // オーバーレイテキスト
    Positioned(
      bottom: 16,
      left: 16,
      child: Text(
        'タイトル',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    // 右上のバッジ
    Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    ),
  ],
)

// Alignで相対位置指定
Stack(
  children: [
    Container(color: Colors.blue, width: 200, height: 200),
    Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ),
  ],
)
```

**Stackのalignment**:

| Alignment | 位置 |
|-----------|------|
| `Alignment.topLeft` | 左上 |
| `Alignment.topCenter` | 上中央 |
| `Alignment.topRight` | 右上 |
| `Alignment.centerLeft` | 左中央 |
| `Alignment.center` | 中央 |
| `Alignment.centerRight` | 右中央 |
| `Alignment.bottomLeft` | 左下 |
| `Alignment.bottomCenter` | 下中央 |
| `Alignment.bottomRight` | 右下 |

### 10.3 レイアウトのベストプラクティス

#### 1. ConstrainedBoxで最大・最小サイズを制御

```dart
// ✅ 推奨: ConstrainedBoxで範囲を制限
ConstrainedBox(
  constraints: BoxConstraints(
    maxWidth: 600,  // デスクトップで広がりすぎないように
    minHeight: 44,  // タップ領域を確保
  ),
  child: ElevatedButton(
    onPressed: () {},
    child: Text('ボタン'),
  ),
)
```

#### 2. AspectRatioでアスペクト比を保つ

```dart
// ✅ 推奨: AspectRatioで16:9の画像を表示
AspectRatio(
  aspectRatio: 16 / 9,
  child: Image.network(
    'https://example.com/image.jpg',
    fit: BoxFit.cover,
  ),
)
```

#### 3. FractionallySizedBoxで親のサイズに対する比率を指定

```dart
// ✅ 推奨: 親の80%の幅を使用
FractionallySizedBox(
  widthFactor: 0.8,
  child: Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('カード'),
    ),
  ),
)
```

#### 4. IntrinsicHeight / IntrinsicWidthで子要素の最大サイズに合わせる

```dart
// ✅ 推奨: Row内の要素の高さを揃える
IntrinsicHeight(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(color: Colors.blue, width: 50),
      VerticalDivider(thickness: 1),
      Expanded(
        child: Container(color: Colors.red),
      ),
    ],
  ),
)
```

**注意**: `IntrinsicHeight` / `IntrinsicWidth` はパフォーマンスコストが高いため、必要な場合のみ使用してください。

## 11. Elevationとレイヤー構造

### 11.1 MD3 Elevation System

Material Design 3では、Elevationを使って要素の階層関係を表現します。

#### Elevationレベル

| レベル | 用途 | 影の高さ |
|-------|------|---------|
| **0** | 背景、Surface | なし |
| **1** | Card、リストアイテム | 1dp |
| **2** | FAB（通常状態） | 3dp |
| **3** | AppBar、BottomNavigationBar | 4dp |
| **4** | NavigationDrawer | 8dp |
| **5** | ModalBottomSheet、Dialog | 16dp |

#### コンポーネントのElevation

```dart
// ✅ 推奨: CardのElevation
Card(
  elevation: 1, // MD3推奨値
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('カード'),
  ),
)

// AppBar
AppBar(
  elevation: 0, // MD3ではスクロール時のみ影を表示
  title: Text('タイトル'),
)

// FloatingActionButton
FloatingActionButton(
  elevation: 6,       // 通常状態
  highlightElevation: 12, // タップ時
  onPressed: () {},
  child: Icon(Icons.add),
)

// Dialog
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    elevation: 24, // MD3推奨値
    title: Text('タイトル'),
    content: Text('本文'),
  ),
)
```

### 11.2 Stackによる階層構造

Stackを使って複数のレイヤーを重ねる際のガイドラインです。

#### レイヤーの順序

```dart
// ✅ 推奨: 下から上へのレイヤー構造
Stack(
  children: [
    // Layer 1: 背景
    Container(color: Colors.grey[100]),

    // Layer 2: コンテンツ
    Positioned.fill(
      child: SingleChildScrollView(
        child: Column(
          children: [...],
        ),
      ),
    ),

    // Layer 3: AppBar（スクロール時に固定）
    Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(title: Text('タイトル')),
    ),

    // Layer 4: FAB（最前面）
    Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ),
  ],
)
```

### 11.3 オーバーレイの階層設計

#### Zインデックスの管理

Flutterでは、Stackの子要素の順序がそのままZインデックスになります。

| レイヤー | Zインデックス | 用途 |
|---------|-------------|------|
| **Background** | 0 | 背景画像、背景色 |
| **Content** | 1 | メインコンテンツ |
| **AppBar / BottomBar** | 2 | ナビゲーション要素 |
| **FAB** | 3 | フローティングアクション |
| **SnackBar** | 4 | 一時的な通知 |
| **Dialog / BottomSheet** | 5 | モーダルダイアログ |
| **Tooltip / Menu** | 6 | コンテキストメニュー |

#### オーバーレイの実装

```dart
// ✅ 推奨: SnackBarの表示
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('保存しました'),
    behavior: SnackBarBehavior.floating,
    elevation: 6, // MD3推奨値
  ),
)

// BottomSheet
showModalBottomSheet(
  context: context,
  elevation: 16, // MD3推奨値
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (context) => Container(
    padding: EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [...],
    ),
  ),
)
```

### 11.4 影とElevationのカスタマイズ

```dart
// ✅ 推奨: カスタム影を追加
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,   // ぼかし
        offset: Offset(0, 4), // 影の位置
        spreadRadius: 0, // 拡散
      ),
    ],
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('カスタムカード'),
  ),
)
```

**MD3推奨の影の設定**:

| Elevation | Color | Blur Radius | Offset Y |
|-----------|-------|-------------|----------|
| **1** | `Colors.black.withOpacity(0.05)` | 4dp | 2dp |
| **2** | `Colors.black.withOpacity(0.08)` | 8dp | 4dp |
| **3** | `Colors.black.withOpacity(0.10)` | 12dp | 6dp |
| **4** | `Colors.black.withOpacity(0.12)` | 16dp | 8dp |

## 12. 再利用可能コンポーネントの設計

### 12.1 カスタムWidgetの作成ガイドライン

MD3コンポーネントで要件を満たせない場合、カスタムWidgetを作成します。

#### StatelessWidget vs StatefulWidget

| Widget | 使い分け | 例 |
|--------|---------|-----|
| `StatelessWidget` | 状態を持たない、入力パラメータのみで描画が決まる | ロゴ、アイコン、静的なカード |
| `StatefulWidget` | 状態を持つ、ユーザー操作で変化する | チェックボックス、テキスト入力、アニメーション |

#### StatelessWidgetの例

```dart
// ✅ 推奨: StatelessWidgetの実装
class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// 使用例
CustomCard(
  title: 'タイトル',
  subtitle: '説明文',
  onTap: () {},
)
```

#### StatefulWidgetの例

```dart
// ✅ 推奨: StatefulWidgetの実装
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.initialValue,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
```

### 12.2 コンポーネントのプロップス設計

#### 必須パラメータとオプショナルパラメータ

```dart
// ✅ 推奨: 必須・オプショナルの明確な分離
class TaskListTile extends StatelessWidget {
  const TaskListTile({
    Key? key,
    required this.title,      // 必須
    required this.isCompleted, // 必須
    this.description,          // オプショナル
    this.dueDate,              // オプショナル
    this.onTap,                // オプショナル
    this.onCheckboxChanged,    // オプショナル
  }) : super(key: key);

  final String title;
  final bool isCompleted;
  final String? description;
  final DateTime? dueDate;
  final VoidCallback? onTap;
  final ValueChanged<bool?>? onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: onCheckboxChanged,
      ),
      title: Text(title),
      subtitle: description != null ? Text(description!) : null,
      trailing: dueDate != null ? Text(_formatDate(dueDate!)) : null,
      onTap: onTap,
    );
  }

  String _formatDate(DateTime date) {
    // 日付フォーマット処理
    return '${date.month}/${date.day}';
  }
}
```

#### デフォルト値の設定

```dart
// ✅ 推奨: デフォルト値を設定
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,      // nullの場合はテーマから取得
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 8.0,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
```

### 12.3 コンポーネントライブラリの配置

プロジェクト全体で再利用可能なコンポーネントは `lib/core/widgets/` に配置します。

```
lib/
├── core/
│   ├── router/
│   └── widgets/               # 共通Widgetライブラリ
│       ├── buttons/
│       │   ├── custom_button.dart
│       │   └── icon_button_with_badge.dart
│       ├── cards/
│       │   ├── info_card.dart
│       │   └── task_card.dart
│       ├── inputs/
│       │   ├── custom_text_field.dart
│       │   └── date_picker_field.dart
│       └── layouts/
│           ├── page_scaffold.dart
│           └── responsive_layout.dart
└── features/
    └── {feature_name}/
        └── presentation/
            └── widgets/       # 機能固有のWidget
                └── task_list_tile.dart
```

**配置のガイドライン**:

| 配置場所 | 条件 | 例 |
|---------|------|-----|
| `lib/core/widgets/` | 3つ以上の機能で使用される | CustomButton, InfoCard |
| `lib/features/{feature}/presentation/widgets/` | 特定の機能でのみ使用される | TaskListTile, TaskFilterChip |

### 12.4 コンポーネントのテスト

```dart
// ✅ 推奨: Widget Testの作成
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomCard', () {
    testWidgets('タイトルが表示される', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(title: 'テストタイトル'),
          ),
        ),
      );

      expect(find.text('テストタイトル'), findsOneWidget);
    });

    testWidgets('onTapが呼ばれる', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(
              title: 'テストタイトル',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('テストタイトル'));
      expect(tapped, true);
    });
  });
}
```

## 13. 実装チェックリスト

新しい画面やコンポーネントを実装する際は、以下を確認してください：

### UI実装チェック

- [ ] MD3コンポーネントを使用している
- [ ] カラーは `Theme.of(context).colorScheme.*` から取得
- [ ] テキストスタイルは `Theme.of(context).textTheme.*` から取得
- [ ] スペーシングは8dpまたは4dpの倍数
- [ ] ライトモード・ダークモードの両方で動作確認
- [ ] タップ領域は最小44x44pt
- [ ] セマンティクスラベルを設定
- [ ] コントラスト比がWCAG 2.1 AAを満たす
- [ ] レスポンシブ対応（必要に応じて）
- [ ] レイアウト制約が適切に設定されている
- [ ] Elevationが適切に設定されている

### コンポーネント設計チェック

- [ ] StatelessWidget/StatefulWidgetの選択が適切
- [ ] 必須パラメータとオプショナルパラメータが明確
- [ ] デフォルト値が適切に設定されている
- [ ] `const` コンストラクタを使用している（可能な場合）
- [ ] 再利用可能なコンポーネントは適切な場所に配置されている

### コード品質チェック

- [ ] `flutter analyze` でエラーなし
- [ ] ハードコードされた色・サイズがない
- [ ] アニメーションは適切なDuration/Curveを使用
- [ ] コメントで複雑なロジックを説明
- [ ] Widget Testを作成している（再利用可能コンポーネント）

## 14. 参考資料

### Material Design 3

- [Material Design 3 公式サイト](https://m3.material.io/)
- [MD3 カラーシステム](https://m3.material.io/styles/color/overview)
- [MD3 タイポグラフィ](https://m3.material.io/styles/typography/overview)
- [MD3 コンポーネント](https://m3.material.io/components)
- [MD3 Elevation](https://m3.material.io/styles/elevation/overview)

### Flutter

- [Material Components for Flutter](https://docs.flutter.dev/ui/widgets/material)
- [Flutter アクセシビリティガイド](https://docs.flutter.dev/accessibility-and-localization/accessibility)
- [Flutter テーマ設定](https://docs.flutter.dev/cookbook/design/themes)
- [Flutter レイアウト基礎](https://docs.flutter.dev/ui/layout)
- [Understanding Constraints](https://docs.flutter.dev/ui/layout/constraints)

### アクセシビリティ

- [WCAG 2.1 ガイドライン](https://www.w3.org/WAI/WCAG21/quickref/)
- [Material Design アクセシビリティ](https://m3.material.io/foundations/accessible-design/overview)

## 15. 変更履歴

| 日付 | バージョン | 変更内容 | 著者 |
|------|-----------|----------|------|
| 2026-01-26 | 1.0 | 初版作成、MD3正式採用 | Claude Code |
| 2026-01-26 | 2.0 | レイアウトシステム、Elevation、再利用可能コンポーネント設計を追加 | Claude Code |
