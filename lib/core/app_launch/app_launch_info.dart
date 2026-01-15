/// アプリ起動のソースを表す列挙型
enum AppLaunchSource {
  /// 通常起動（ユーザーがアイコンをタップ）
  normal,

  /// 通知から起動
  notification,

  /// ディープリンク（URLスキーム、ユニバーサルリンク）から起動
  deepLink,
}

/// アプリ起動時の情報を保持するデータクラス
class AppLaunchInfo {
  const AppLaunchInfo({required this.source, this.path, this.payload});

  /// 起動ソース
  final AppLaunchSource source;

  /// 遷移先パス（通知やディープリンクの場合）
  final String? path;

  /// 追加データ（将来の拡張用）
  final Map<String, dynamic>? payload;

  /// 有効なパスを持っているか
  bool get hasPath => path != null && path!.isNotEmpty;
}
