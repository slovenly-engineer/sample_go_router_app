import 'package:flutter/foundation.dart';

/// プラットフォーム判定を提供するシングルトンクラス
///
/// 通常時は実際のプラットフォームを返す。
/// テスト時のみ [overridePlatform] でプラットフォームを上書き可能。
class PlatformDetector {
  PlatformDetector._();

  static final PlatformDetector _instance = PlatformDetector._();
  static PlatformDetector get instance => _instance;

  TargetPlatform? _overridePlatform;

  /// 現在のプラットフォームを取得
  /// テストで上書きされている場合はその値を返す
  ///
  /// 注意: Web環境では defaultTargetPlatform が iOS/Android を返すことがあるため、
  /// プラットフォーム判定時は [isWeb] も併用することを推奨
  TargetPlatform get current => _overridePlatform ?? defaultTargetPlatform;

  /// Webプラットフォームかどうか
  /// kIsWeb で判定するため、TargetPlatform の列挙値とは独立
  bool get isWeb => kIsWeb;

  /// iOSプラットフォームかどうか
  bool get isIOS => current == TargetPlatform.iOS;

  /// Androidプラットフォームかどうか
  bool get isAndroid => current == TargetPlatform.android;

  /// Linuxプラットフォームかどうか
  bool get isLinux => current == TargetPlatform.linux;

  /// macOSプラットフォームかどうか
  bool get isMacOS => current == TargetPlatform.macOS;

  /// Windowsプラットフォームかどうか
  bool get isWindows => current == TargetPlatform.windows;

  /// テスト用: プラットフォームを上書き
  ///
  /// [platform] が null の場合は上書きを解除し、実際のプラットフォームに戻る
  @visibleForTesting
  // setterに変更すると対応するgetterがない警告が出るため、メソッドとして定義
  // ignore: use_setters_to_change_properties
  void overridePlatform(TargetPlatform? platform) {
    _overridePlatform = platform;
  }

  /// テスト用: プラットフォームの上書きをリセット
  @visibleForTesting
  void reset() {
    _overridePlatform = null;
  }
}
