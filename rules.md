# Flutter AI Rules

## 重要原則

- 共通情報は記載しない。すべて docs/common/ を参照すること
- このファイルには差分のみを記載する

## 警告

このファイルには差分のみを記載しています。
実装時は必ず docs/implementation/index.md を参照してください。
参照を忘れた場合、実装が不完全になる可能性があります。

## Flutter/Dart固有の実装支援

Flutter/Dart固有の実装支援時は、以下を参照してください：

- docs/implementation/index.md（実装支援の入口）
- docs/common/coding-conventions.md（コーディング規約）

## Flutter固有の指示

- Riverpod Providerを使用する際は、コード生成を必ず実行すること：
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- GoRouterのルート定義を変更した場合も、コード生成を実行すること
- コード生成後は、生成ファイル（`*.g.dart`）が正しく生成されているか確認すること
- 新機能追加時は、docs/implementation/how-to/add-feature.md の手順に従うこと
- 画面遷移追加時は、docs/implementation/how-to/add-navigation.md の手順に従うこと
