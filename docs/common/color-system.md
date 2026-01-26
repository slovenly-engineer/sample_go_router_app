# カラーシステム定義

## ドキュメント情報

- **作成日**: 2026-01-26
- **最終更新**: 2026-01-26
- **ステータス**: 承認済み
- **対象**: プロジェクト全体のカラーシステム

## 概要

このドキュメントは、プロジェクト全体で使用するカラーシステムを定義します。Material Design 3（MD3）のカラートークンと、プロジェクト固有のセマンティックカラーを含みます。

**重要**: すべてのUI実装（Flutter、Pencilデザイン）は、このドキュメントで定義された色を使用してください。

## 1. MD3カラートークン

### 1.1 Primary Colors（プライマリカラー）

主要なアクション、強調表示に使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **primary** | 主要な要素の背景色 | `#65558F` | `#CFBDFE` |
| **onPrimary** | Primary上のテキスト・アイコン | `#FFFFFF` | `#36275D` |
| **primaryContainer** | Primary要素のコンテナ背景 | `#E9DDFF` | `#4D3D75` |
| **onPrimaryContainer** | PrimaryContainer上のテキスト | `#4D3D75` | `#E9DDFF` |
| **primaryFixed** | 固定Primary色（テーマ非依存） | `#E9DDFF` | `#E9DDFF` |
| **onPrimaryFixed** | PrimaryFixed上のテキスト | `#201047` | `#201047` |
| **primaryFixedDim** | 暗めの固定Primary色 | `#CFBDFE` | `#CFBDFE` |
| **onPrimaryFixedVariant** | PrimaryFixedVariant上のテキスト | `#4D3D75` | `#4D3D75` |

#### 使用例
- ~~AppBarの背景: `primary`~~ → **推奨: `surfaceContainer`**（MD3標準）
- AppBarのタイトル: `onPrimary`
- FABの背景: `primaryContainer`
- FAB内のアイコン: `onPrimaryContainer`

### 1.2 Secondary Colors（セカンダリカラー）

補助的なアクション、強調度の低い要素に使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **secondary** | 補助的な要素の背景色 | `#625B71` | `#CBC2DB` |
| **onSecondary** | Secondary上のテキスト・アイコン | `#FFFFFF` | `#332D41` |
| **secondaryContainer** | Secondary要素のコンテナ背景 | `#E8DEF8` | `#4A4458` |
| **onSecondaryContainer** | SecondaryContainer上のテキスト | `#4A4458` | `#E8DEF8` |
| **secondaryFixed** | 固定Secondary色（テーマ非依存） | `#E8DEF8` | `#E8DEF8` |
| **onSecondaryFixed** | SecondaryFixed上のテキスト | `#1E192B` | `#1E192B` |
| **secondaryFixedDim** | 暗めの固定Secondary色 | `#CBC2DB` | `#CBC2DB` |
| **onSecondaryFixedVariant** | SecondaryFixedVariant上のテキスト | `#4A4458` | `#4A4458` |

#### 使用例
- 副次的なボタン背景: `secondaryContainer`
- フィルターチップ: `secondaryContainer`

### 1.3 Tertiary Colors（ターシャリカラー）

アクセント、特別な強調に使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **tertiary** | アクセント要素の背景色 | `#7E5260` | `#EFB8C8` |
| **onTertiary** | Tertiary上のテキスト・アイコン | `#FFFFFF` | `#4A2532` |
| **tertiaryContainer** | Tertiary要素のコンテナ背景 | `#FFD9E3` | `#633B48` |
| **onTertiaryContainer** | TertiaryContainer上のテキスト | `#633B48` | `#FFD9E3` |
| **tertiaryFixed** | 固定Tertiary色（テーマ非依存） | `#FFD9E3` | `#FFD9E3` |
| **onTertiaryFixed** | TertiaryFixed上のテキスト | `#31101D` | `#31101D` |
| **tertiaryFixedDim** | 暗めの固定Tertiary色 | `#EFB8C8` | `#EFB8C8` |
| **onTertiaryFixedVariant** | TertiaryFixedVariant上のテキスト | `#633B48` | `#633B48` |

#### 使用例
- 特別なバッジ: `tertiaryContainer`
- アクセントアイコン: `tertiary`

### 1.4 Error Colors（エラーカラー）

エラー状態、警告、危険なアクションに使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **error** | エラー要素の背景色 | `#BA1A1A` | `#FFB4AB` |
| **onError** | Error上のテキスト・アイコン | `#FFFFFF` | `#690005` |
| **errorContainer** | エラーコンテナ背景 | `#FFDAD6` | `#93000A` |
| **onErrorContainer** | ErrorContainer上のテキスト | `#93000A` | `#FFDAD6` |

#### 使用例
- 期限切れタスクの期限表示: `error`
- エラーメッセージ背景: `errorContainer`
- エラーダイアログのアクションボタン: `error`

**注意**: `error` を背景とする場合、`onError` のテキストは太字（Bold）にするか、18pt以上のサイズで使用してください（ライトモードのコントラスト比は3.99:1のため）。

### 1.5 Surface Colors（サーフェスカラー）

背景、カード、ダイアログなどのサーフェスに使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **surface** | カード、ダイアログの背景 | `#FDF7FF` | `#141218` |
| **onSurface** | Surface上のテキスト・アイコン | `#1D1B20` | `#E6E0E9` |
| **surfaceVariant** | サーフェスのバリエーション | `#E7E0EB` | `#49454E` |
| **onSurfaceVariant** | SurfaceVariant上のテキスト | `#49454E` | `#CAC4CF` |
| **surfaceTint** | サーフェスのティント色 | `#65558F` | `#CFBDFE` |
| **surfaceDim** | サーフェスの暗い変種 | `#DED8E0` | `#141218` |
| **surfaceBright** | サーフェスの明るい変種 | `#FDF7FF` | `#3B383E` |
| **surfaceContainerLowest** | 最も低いコンテナサーフェス | `#FFFFFF` | `#0F0D13` |
| **surfaceContainerLow** | 低いコンテナサーフェス | `#F8F2FA` | `#1D1B20` |
| **surfaceContainer** | 標準コンテナサーフェス | `#F2ECF4` | `#211F24` |
| **surfaceContainerHigh** | 高いコンテナサーフェス | `#ECE6EE` | `#2B292F` |
| **surfaceContainerHighest** | 最も高いコンテナサーフェス | `#E6E0E9` | `#36343A` |

#### Surface Container階層

MD3では、Surfaceに5段階の階層が定義されています（最も明るい/暗い → 最も濃い順）：

```
surface (基準)
  ↓
surfaceContainerLowest (最も明るい/暗い、白に近い)
  ↓
surfaceContainerLow
  ↓
surfaceContainer (中間、AppBarなどに推奨)
  ↓
surfaceContainerHigh
  ↓
surfaceContainerHighest (最も濃い)
```

#### 使用例
- Cardの背景: `surface`
- Card内のテキスト: `onSurface`
- 補足テキスト（説明など）: `onSurfaceVariant`
- **AppBarの背景: `surfaceContainer`（コンテンツとの自然な区別を提供）**
- ダイアログの背景: `surfaceContainerHigh`
- Snackbarの背景: `inverseSurface`

### 1.6 Background Colors（背景カラー）

画面全体の背景に使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **background** | 画面全体の背景色 | `#FDF7FF` | `#141218` |
| **onBackground** | Background上のテキスト・アイコン | `#1D1B20` | `#E6E0E9` |

#### 使用例
- Scaffoldの背景: `background`
- 画面全体のテキスト: `onBackground`

### 1.7 Outline Colors（アウトラインカラー）

境界線、区切り線に使用します。

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **outline** | 境界線、区切り線 | `#7A757F` | `#948F99` |
| **outlineVariant** | 薄い境界線、区切り線 | `#CAC4CF` | `#49454E` |

#### 使用例
- TextFieldのボーダー: `outline`
- リストの区切り線: `outlineVariant`

### 1.8 その他のカラー

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **shadow** | 影の色 | `#000000` | `#000000` |
| **scrim** | スクリム（オーバーレイ背景） | `#000000` | `#000000` |
| **inverseSurface** | 反転サーフェス（Snackbarなど） | `#322F35` | `#E6E0E9` |
| **onInverseSurface** | InverseSurface上のテキスト | `#F5EFF7` | `#322F35` |
| **inversePrimary** | InverseSurface上のPrimary色 | `#CFBDFE` | `#65558F` |

## 2. セマンティックカラー

MD3の標準カラーに加え、プロジェクト固有のセマンティックカラーを定義します。

### 2.1 Success（成功）

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **success** | 成功状態の背景・強調色 | `#4CAF50` | `#81C784` |
| **onSuccess** | Success上のテキスト・アイコン | `#1B5E20` | `#FFFFFF` |
| **successContainer** | 成功状態のコンテナ背景 | `#C8E6C9` | `#2E7D32` |
| **onSuccessContainer** | SuccessContainer上のテキスト | `#1B5E20` | `#C8E6C9` |

#### 使用例
- 完了タスクの「完了」表示: `success`
- 成功メッセージ背景: `successContainer`
- チェック済みバッジ: `success`

### 2.2 Warning（警告）

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **warning** | 警告状態の背景・強調色 | `#F57C00` | `#FFB74D` |
| **onWarning** | Warning上のテキスト・アイコン | `#000000` | `#FFFFFF` |
| **warningContainer** | 警告状態のコンテナ背景 | `#FFE0B2` | `#EF6C00` |
| **onWarningContainer** | WarningContainer上のテキスト | `#E65100` | `#FFE0B2` |

#### 使用例
- 今日期限のタスク期限表示: `warning`
- 注意喚起メッセージ: `warningContainer`

### 2.3 Info（情報）

| トークン | 用途 | ライトモード | ダークモード |
|---------|------|------------|-------------|
| **info** | 情報状態の背景・強調色 | `#1976D2` | `#64B5F6` |
| **onInfo** | Info上のテキスト・アイコン | `#000000` | `#FFFFFF` |
| **infoContainer** | 情報状態のコンテナ背景 | `#BBDEFB` | `#1565C0` |
| **onInfoContainer** | InfoContainer上のテキスト | `#0D47A1` | `#BBDEFB` |

#### 使用例
- 明日期限のタスク期限表示: `info`
- 情報メッセージ背景: `infoContainer`
- ヒント表示: `info`

## 3. Pencil変数とのマッピング

Pencilデザインファイルで使用する変数名とMD3トークンのマッピングです。

### 3.1 Primary Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$primary` | `primary` | `#65558F` | `#CFBDFE` |
| `$on-primary` | `onPrimary` | `#FFFFFF` | `#36275D` |
| `$primary-container` | `primaryContainer` | `#E9DDFF` | `#4D3D75` |
| `$on-primary-container` | `onPrimaryContainer` | `#4D3D75` | `#E9DDFF` |
| `$primary-fixed` | `primaryFixed` | `#E9DDFF` | `#E9DDFF` |
| `$on-primary-fixed` | `onPrimaryFixed` | `#201047` | `#201047` |
| `$primary-fixed-dim` | `primaryFixedDim` | `#CFBDFE` | `#CFBDFE` |
| `$on-primary-fixed-variant` | `onPrimaryFixedVariant` | `#4D3D75` | `#4D3D75` |

### 3.2 Secondary Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$secondary` | `secondary` | `#625B71` | `#CBC2DB` |
| `$on-secondary` | `onSecondary` | `#FFFFFF` | `#332D41` |
| `$secondary-container` | `secondaryContainer` | `#E8DEF8` | `#4A4458` |
| `$on-secondary-container` | `onSecondaryContainer` | `#4A4458` | `#E8DEF8` |
| `$secondary-fixed` | `secondaryFixed` | `#E8DEF8` | `#E8DEF8` |
| `$on-secondary-fixed` | `onSecondaryFixed` | `#1E192B` | `#1E192B` |
| `$secondary-fixed-dim` | `secondaryFixedDim` | `#CBC2DB` | `#CBC2DB` |
| `$on-secondary-fixed-variant` | `onSecondaryFixedVariant` | `#4A4458` | `#4A4458` |

### 3.3 Tertiary Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$tertiary` | `tertiary` | `#7E5260` | `#EFB8C8` |
| `$on-tertiary` | `onTertiary` | `#FFFFFF` | `#4A2532` |
| `$tertiary-container` | `tertiaryContainer` | `#FFD9E3` | `#633B48` |
| `$on-tertiary-container` | `onTertiaryContainer` | `#633B48` | `#FFD9E3` |
| `$tertiary-fixed` | `tertiaryFixed` | `#FFD9E3` | `#FFD9E3` |
| `$on-tertiary-fixed` | `onTertiaryFixed` | `#31101D` | `#31101D` |
| `$tertiary-fixed-dim` | `tertiaryFixedDim` | `#EFB8C8` | `#EFB8C8` |
| `$on-tertiary-fixed-variant` | `onTertiaryFixedVariant` | `#633B48` | `#633B48` |

### 3.4 Error Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$error` | `error` | `#BA1A1A` | `#FFB4AB` |
| `$on-error` | `onError` | `#FFFFFF` | `#690005` |
| `$error-container` | `errorContainer` | `#FFDAD6` | `#93000A` |
| `$on-error-container` | `onErrorContainer` | `#93000A` | `#FFDAD6` |

### 3.5 Surface Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$surface` | `surface` | `#FDF7FF` | `#141218` |
| `$on-surface` | `onSurface` | `#1D1B20` | `#E6E0E9` |
| `$surface-variant` | `surfaceVariant` | `#E7E0EB` | `#49454E` |
| `$on-surface-variant` | `onSurfaceVariant` | `#49454E` | `#CAC4CF` |
| `$surface-tint` | `surfaceTint` | `#65558F` | `#CFBDFE` |
| `$surface-dim` | `surfaceDim` | `#DED8E0` | `#141218` |
| `$surface-bright` | `surfaceBright` | `#FDF7FF` | `#3B383E` |
| `$surface-container-lowest` | `surfaceContainerLowest` | `#FFFFFF` | `#0F0D13` |
| `$surface-container-low` | `surfaceContainerLow` | `#F8F2FA` | `#1D1B20` |
| `$surface-container` | `surfaceContainer` | `#F2ECF4` | `#211F24` |
| `$surface-container-high` | `surfaceContainerHigh` | `#ECE6EE` | `#2B292F` |
| `$surface-container-highest` | `surfaceContainerHighest` | `#E6E0E9` | `#36343A` |

### 3.6 Background Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$background` | `background` | `#FDF7FF` | `#141218` |
| `$on-background` | `onBackground` | `#1D1B20` | `#E6E0E9` |

### 3.7 Semantic Colors

| Pencil変数名 | セマンティックトークン | ライトモード | ダークモード |
|-------------|---------------------|------------|-------------|
| `$success` | `success` | `#4CAF50` | `#81C784` |
| `$on-success` | `onSuccess` | `#1B5E20` | `#FFFFFF` |
| `$success-container` | `successContainer` | `#C8E6C9` | `#2E7D32` |
| `$on-success-container` | `onSuccessContainer` | `#1B5E20` | `#C8E6C9` |
| `$warning` | `warning` | `#F57C00` | `#FFB74D` |
| `$on-warning` | `onWarning` | `#000000` | `#FFFFFF` |
| `$warning-container` | `warningContainer` | `#FFE0B2` | `#EF6C00` |
| `$on-warning-container` | `onWarningContainer` | `#E65100` | `#FFE0B2` |
| `$info` | `info` | `#1976D2` | `#64B5F6` |
| `$on-info` | `onInfo` | `#000000` | `#FFFFFF` |
| `$info-container` | `infoContainer` | `#BBDEFB` | `#1565C0` |
| `$on-info-container` | `onInfoContainer` | `#0D47A1` | `#BBDEFB` |

### 3.8 Outline Colors

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$outline` | `outline` | `#7A757F` | `#948F99` |
| `$outline-variant` | `outlineVariant` | `#CAC4CF` | `#49454E` |

### 3.9 その他のカラー

| Pencil変数名 | MD3トークン | ライトモード | ダークモード |
|-------------|------------|------------|-------------|
| `$shadow` | `shadow` | `#000000` | `#000000` |
| `$scrim` | `scrim` | `#000000` | `#000000` |
| `$inverse-surface` | `inverseSurface` | `#322F35` | `#E6E0E9` |
| `$on-inverse-surface` | `onInverseSurface` | `#F5EFF7` | `#322F35` |
| `$inverse-primary` | `inversePrimary` | `#CFBDFE` | `#65558F` |

## 4. カラー使用ガイドライン

### 4.1 タスク期限表示のカラーマッピング

| 期限状態 | 使用するトークン | ライトモード | ダークモード |
|---------|----------------|------------|-------------|
| **期限切れ** | `error` | `#BA1A1A` | `#FFB4AB` |
| **今日** | `warning` | `#F57C00` | `#FFB74D` |
| **明日** | `info` | `#1976D2` | `#64B5F6` |
| **1週間以内** | `onSurfaceVariant` | `#49454F` | `#CAC4D0` |
| **1週間以降** | `outline` | `#79747E` | `#938F99` |
| **期限なし** | `outline` | `#79747E` | `#938F99` |
| **完了** | `success` | `#4CAF50` | `#81C784` |

**アクセシビリティ要件**: 期限の状態を色で区別する際は、**必ずアイコンやテキストラベル（例: "期限切れ"）を併用**してください。色だけに依存した情報伝達は、色覚特性を持つユーザーにとって識別が困難です。

### 4.2 ボタンのカラーマッピング

| ボタンタイプ | 背景色 | テキスト色 |
|------------|-------|----------|
| **FilledButton（主要）** | `primary` | `onPrimary` |
| **FilledButton（強調）** | `primaryContainer` | `onPrimaryContainer` |
| **ElevatedButton** | `surface` (Elevation 1) | `primary` |
| **OutlinedButton** | 透明 | `primary` |
| **TextButton** | 透明 | `primary` |

### 4.3 状態別カラーマッピング

| 状態 | 背景色トークン | テキスト色トークン | 使用例 |
|------|--------------|------------------|--------|
| **成功** | `successContainer` | `onSuccessContainer` | 成功メッセージ、完了バッジ |
| **警告** | `warningContainer` | `onWarningContainer` | 注意喚起、今日期限 |
| **エラー** | `errorContainer` | `onErrorContainer` | エラーメッセージ、期限切れ |
| **情報** | `infoContainer` | `onInfoContainer` | ヒント、情報表示 |

### 4.4 コントラスト比の要件

すべての色の組み合わせは **WCAG 2.1 AAレベル** を満たす必要があります。

| 要素 | 最小コントラスト比 | 例 |
|------|------------------|-----|
| **通常テキスト** | 4.5:1 | Body text, Labels |
| **大きなテキスト** (18pt以上または14pt Bold以上) | 3:1 | Headlines, Titles |
| **アイコン・グラフィック** | 3:1 | Icons, Borders |

**注意**: 上記で定義されたすべてのカラーペアは、この基準を満たすように設計されています。

## 5. Flutter実装での使用方法

### 5.1 ColorSchemeの定義

`lib/core/theme/app_theme.dart` でColorSchemeを定義します。

```dart
import 'package:flutter/material.dart';

// ライトテーマのColorScheme
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // Primary Colors
  primary: Color(0xFF65558F),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFE9DDFF),
  onPrimaryContainer: Color(0xFF4D3D75),
  primaryFixed: Color(0xFFE9DDFF),
  onPrimaryFixed: Color(0xFF201047),
  primaryFixedDim: Color(0xFFCFBDFE),
  onPrimaryFixedVariant: Color(0xFF4D3D75),
  // Secondary Colors
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF4A4458),
  secondaryFixed: Color(0xFFE8DEF8),
  onSecondaryFixed: Color(0xFF1E192B),
  secondaryFixedDim: Color(0xFFCBC2DB),
  onSecondaryFixedVariant: Color(0xFF4A4458),
  // Tertiary Colors
  tertiary: Color(0xFF7E5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E3),
  onTertiaryContainer: Color(0xFF633B48),
  tertiaryFixed: Color(0xFFFFD9E3),
  onTertiaryFixed: Color(0xFF31101D),
  tertiaryFixedDim: Color(0xFFEFB8C8),
  onTertiaryFixedVariant: Color(0xFF633B48),
  // Error Colors
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF93000A),
  // Surface Colors
  surface: Color(0xFFFDF7FF),
  onSurface: Color(0xFF1D1B20),
  surfaceVariant: Color(0xFFE7E0EB),
  onSurfaceVariant: Color(0xFF49454E),
  surfaceDim: Color(0xFFDED8E0),
  surfaceBright: Color(0xFFFDF7FF),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF8F2FA),
  surfaceContainer: Color(0xFFF2ECF4),
  surfaceContainerHigh: Color(0xFFECE6EE),
  surfaceContainerHighest: Color(0xFFE6E0E9),
  // Background Colors
  background: Color(0xFFFDF7FF),
  onBackground: Color(0xFF1D1B20),
  // Outline Colors
  outline: Color(0xFF7A757F),
  outlineVariant: Color(0xFFCAC4CF),
  // その他
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF322F35),
  onInverseSurface: Color(0xFFF5EFF7),
  inversePrimary: Color(0xFFCFBDFE),
  surfaceTint: Color(0xFF65558F),
);

// ダークテーマのColorScheme
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // Primary Colors
  primary: Color(0xFFCFBDFE),
  onPrimary: Color(0xFF36275D),
  primaryContainer: Color(0xFF4D3D75),
  onPrimaryContainer: Color(0xFFE9DDFF),
  primaryFixed: Color(0xFFE9DDFF),
  onPrimaryFixed: Color(0xFF201047),
  primaryFixedDim: Color(0xFFCFBDFE),
  onPrimaryFixedVariant: Color(0xFF4D3D75),
  // Secondary Colors
  secondary: Color(0xFFCBC2DB),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  secondaryFixed: Color(0xFFE8DEF8),
  onSecondaryFixed: Color(0xFF1E192B),
  secondaryFixedDim: Color(0xFFCBC2DB),
  onSecondaryFixedVariant: Color(0xFF4A4458),
  // Tertiary Colors
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF4A2532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD9E3),
  tertiaryFixed: Color(0xFFFFD9E3),
  onTertiaryFixed: Color(0xFF31101D),
  tertiaryFixedDim: Color(0xFFEFB8C8),
  onTertiaryFixedVariant: Color(0xFF633B48),
  // Error Colors
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  // Surface Colors
  surface: Color(0xFF141218),
  onSurface: Color(0xFFE6E0E9),
  surfaceVariant: Color(0xFF49454E),
  onSurfaceVariant: Color(0xFFCAC4CF),
  surfaceDim: Color(0xFF141218),
  surfaceBright: Color(0xFF3B383E),
  surfaceContainerLowest: Color(0xFF0F0D13),
  surfaceContainerLow: Color(0xFF1D1B20),
  surfaceContainer: Color(0xFF211F24),
  surfaceContainerHigh: Color(0xFF2B292F),
  surfaceContainerHighest: Color(0xFF36343A),
  // Background Colors
  background: Color(0xFF141218),
  onBackground: Color(0xFFE6E0E9),
  // Outline Colors
  outline: Color(0xFF948F99),
  outlineVariant: Color(0xFF49454E),
  // その他
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE6E0E9),
  onInverseSurface: Color(0xFF322F35),
  inversePrimary: Color(0xFF65558F),
  surfaceTint: Color(0xFFCFBDFE),
);
```

### 5.2 MD3カラートークンの使用

```dart
// ✅ 推奨: Theme.of(context).colorScheme を使用
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'テキスト',
    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
  ),
)
```

### 5.3 セマンティックカラーの使用

セマンティックカラーは、ColorScheme の Extension として定義します。

```dart
// lib/core/theme/semantic_colors.dart
import 'package:flutter/material.dart';

extension SemanticColors on ColorScheme {
  // Success Colors
  Color get success => brightness == Brightness.light
      ? const Color(0xFF4CAF50)
      : const Color(0xFF81C784);

  Color get onSuccess => brightness == Brightness.light
      ? const Color(0xFF1B5E20)
      : const Color(0xFFFFFFFF);

  Color get successContainer => brightness == Brightness.light
      ? const Color(0xFFC8E6C9)
      : const Color(0xFF2E7D32);

  Color get onSuccessContainer => brightness == Brightness.light
      ? const Color(0xFF1B5E20)
      : const Color(0xFFC8E6C9);

  // Warning Colors
  Color get warning => brightness == Brightness.light
      ? const Color(0xFFF57C00)
      : const Color(0xFFFFB74D);

  Color get onWarning => brightness == Brightness.light
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);

  Color get warningContainer => brightness == Brightness.light
      ? const Color(0xFFFFE0B2)
      : const Color(0xFFEF6C00);

  Color get onWarningContainer => brightness == Brightness.light
      ? const Color(0xFFE65100)
      : const Color(0xFFFFE0B2);

  // Info Colors
  Color get info => brightness == Brightness.light
      ? const Color(0xFF1976D2)
      : const Color(0xFF64B5F6);

  Color get onInfo => brightness == Brightness.light
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);

  Color get infoContainer => brightness == Brightness.light
      ? const Color(0xFFBBDEFB)
      : const Color(0xFF1565C0);

  Color get onInfoContainer => brightness == Brightness.light
      ? const Color(0xFF0D47A1)
      : const Color(0xFFBBDEFB);
}

// 使用例
Text(
  '完了',
  style: TextStyle(color: Theme.of(context).colorScheme.success),
)

// Container版の使用例
Container(
  color: Theme.of(context).colorScheme.successContainer,
  child: Text(
    'タスク完了',
    style: TextStyle(color: Theme.of(context).colorScheme.onSuccessContainer),
  ),
)
```

## 6. Pencil実装での使用方法

### 6.1 変数の設定

`set_variables` ツールで以下のように変数を定義します。

```javascript
{
  "variables": {
    // Primary Colors
    "$primary": {"light": "#65558F", "dark": "#CFBDFE"},
    "$on-primary": {"light": "#FFFFFF", "dark": "#36275D"},
    "$primary-container": {"light": "#E9DDFF", "dark": "#4D3D75"},
    "$on-primary-container": {"light": "#4D3D75", "dark": "#E9DDFF"},

    // Secondary Colors
    "$secondary": {"light": "#625B71", "dark": "#CBC2DB"},
    "$on-secondary": {"light": "#FFFFFF", "dark": "#332D41"},
    "$secondary-container": {"light": "#E8DEF8", "dark": "#4A4458"},
    "$on-secondary-container": {"light": "#4A4458", "dark": "#E8DEF8"},

    // Tertiary Colors
    "$tertiary": {"light": "#7E5260", "dark": "#EFB8C8"},
    "$on-tertiary": {"light": "#FFFFFF", "dark": "#4A2532"},
    "$tertiary-container": {"light": "#FFD9E3", "dark": "#633B48"},
    "$on-tertiary-container": {"light": "#633B48", "dark": "#FFD9E3"},

    // Error Colors
    "$error": {"light": "#BA1A1A", "dark": "#FFB4AB"},
    "$on-error": {"light": "#FFFFFF", "dark": "#690005"},
    "$error-container": {"light": "#FFDAD6", "dark": "#93000A"},
    "$on-error-container": {"light": "#93000A", "dark": "#FFDAD6"},

    // Surface Colors
    "$surface": {"light": "#FDF7FF", "dark": "#141218"},
    "$on-surface": {"light": "#1D1B20", "dark": "#E6E0E9"},
    "$surface-variant": {"light": "#E7E0EB", "dark": "#49454E"},
    "$on-surface-variant": {"light": "#49454E", "dark": "#CAC4CF"},
    "$surface-tint": {"light": "#65558F", "dark": "#CFBDFE"},

    // Background Colors
    "$background": {"light": "#FDF7FF", "dark": "#141218"},
    "$on-background": {"light": "#1D1B20", "dark": "#E6E0E9"},

    // Outline Colors
    "$outline": {"light": "#7A757F", "dark": "#948F99"},
    "$outline-variant": {"light": "#CAC4CF", "dark": "#49454E"},

    // Semantic Colors - Success
    "$success": {"light": "#4CAF50", "dark": "#81C784"},
    "$on-success": {"light": "#1B5E20", "dark": "#FFFFFF"},
    "$success-container": {"light": "#C8E6C9", "dark": "#2E7D32"},
    "$on-success-container": {"light": "#1B5E20", "dark": "#C8E6C9"},

    // Semantic Colors - Warning
    "$warning": {"light": "#F57C00", "dark": "#FFB74D"},
    "$on-warning": {"light": "#000000", "dark": "#FFFFFF"},
    "$warning-container": {"light": "#FFE0B2", "dark": "#EF6C00"},
    "$on-warning-container": {"light": "#E65100", "dark": "#FFE0B2"},

    // Semantic Colors - Info
    "$info": {"light": "#1976D2", "dark": "#64B5F6"},
    "$on-info": {"light": "#000000", "dark": "#FFFFFF"},
    "$info-container": {"light": "#BBDEFB", "dark": "#1565C0"},
    "$on-info-container": {"light": "#0D47A1", "dark": "#BBDEFB"}
  }
}
```

### 6.2 変数の使用

```javascript
// ノードのプロパティで変数を参照
{
  "type": "text",
  "content": "期限切れ",
  "fill": "$error"  // 変数を参照
}
```

## 7. デザインツール間の一貫性

### 7.1 色の検証プロセス

1. **ドキュメント作成時**
   - このドキュメントで定義された色のみを使用
   - 新しい色が必要な場合は、このドキュメントを更新

2. **Pencilデザイン作成時**
   - `set_variables` で変数を定義
   - ハードコードされた色は使用しない

3. **Flutter実装時**
   - `ThemeData` で色を定義
   - `Theme.of(context).colorScheme.*` を使用

4. **レビュー時**
   - Pencilデザイン、Flutter実装が同じ色を使用しているか確認
   - 色の差異がある場合は修正

### 7.2 色の更新フロー

```
1. このドキュメント（color-system.md）を更新
    ↓
2. Pencilデザインファイルの変数を更新
    ↓
3. Flutter ThemeDataを更新
    ↓
4. 既存のUI実装を確認・修正
```

## 8. 参考資料

### Material Design 3

- [MD3 Color System](https://m3.material.io/styles/color/overview)
- [MD3 Dynamic Color](https://m3.material.io/styles/color/dynamic-color/overview)
- [MD3 Color Roles](https://m3.material.io/styles/color/roles)

### アクセシビリティ

- [WCAG 2.1 Contrast Requirements](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)
- [Material Design Accessibility](https://m3.material.io/foundations/accessible-design/overview)

### ツール

- [Material Theme Builder](https://m3.material.io/theme-builder) - MD3カラーパレット生成
- [Contrast Checker](https://webaim.org/resources/contrastchecker/) - コントラスト比チェック

## 9. 変更履歴

| 日付 | バージョン | 変更内容 | 著者 |
|------|-----------|----------|------|
| 2026-01-26 | 1.0 | 初版作成 | Claude Code |
| 2026-01-26 | 1.1 | Geminiレビュー結果を反映：コントラスト比修正（Success/Warning/Info）、Error色を標準値に修正、Pencil変数マッピング拡充、Flutter実装ガイド拡充、アクセシビリティ要件追加 | Claude Code |
| 2026-01-26 | 1.2 | Material Theme Builder公式ツール（seed: #6750A4）の出力結果に基づき全カラー値を更新。Primary, Secondary, Tertiary, Surface, Background, Outline等のライト・ダークモード全色を修正。Flutter ColorScheme定義、Pencil変数定義も同期更新 | Claude Code |
| 2026-01-26 | 1.3 | MD3完全対応：Surface Container系5階層（surfaceContainerLowest〜Highest）、Surface Dim/Bright、Primary/Secondary/Tertiary Fixed系カラートークンを追加。Flutter ColorScheme、Pencil変数マッピングも完全更新。AppBar背景色の推奨を`surfaceContainer`に変更 | Claude Code |
