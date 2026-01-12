# 機能仕様テンプレート

## 機能名

{機能名}

## 概要

{機能の目的と概要を記載}

## 機能仕様

### 主要機能

- {機能1の説明}
- {機能2の説明}
- {機能3の説明}

### UI/UX

{画面の構成やユーザーインタラクションを説明}

## 実装詳細

### ディレクトリ構造

```
features/{feature_name}/
├── {feature}_route.dart
├── presentation/
│   ├── {feature}_page.dart
│   └── {feature}_view_model.dart
└── data/  # 必要に応じて
    └── {feature}_repository.dart
```

### ルート定義

{ルート定義のコード例}

### ViewModel

{ViewModelのコード例}

### データフロー

{データの流れを説明}

1. ユーザーアクション
2. ViewModelでの処理
3. 状態更新
4. UI更新

## 依存関係

{この機能が依存している他の機能やモジュールを説明}

## テスト

### テストカバレッジ

- 単体テスト: ViewModelのロジック
- Widgetテスト: UIコンポーネント（必要に応じて）

### テスト例

{テストコードの例}

## 今後の拡張予定

{将来の機能拡張の予定を記載}

## 関連ドキュメント

- [新機能追加ガイド](../../implementation/how-to/add-feature.md)
- [ナビゲーション設計](../../common/architecture-principles.md)
