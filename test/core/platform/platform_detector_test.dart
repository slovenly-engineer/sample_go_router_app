import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_go_router_app/core/platform/platform_detector.dart';

void main() {
  group('PlatformDetector', () {
    setUp(() {
      // 各テスト前にリセット
      PlatformDetector.instance.reset();
    });

    test('instanceはシングルトンである', () {
      final instance1 = PlatformDetector.instance;
      final instance2 = PlatformDetector.instance;
      expect(instance1, same(instance2));
    });

    test('currentはデフォルトでdefaultTargetPlatformを返す（非Web環境）', () {
      // kIsWeb == false の環境（通常のテスト環境）
      expect(PlatformDetector.instance.current, equals(defaultTargetPlatform));
    });

    test('overridePlatformでプラットフォームを上書きできる', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.iOS);
      expect(PlatformDetector.instance.current, equals(TargetPlatform.iOS));

      PlatformDetector.instance.overridePlatform(TargetPlatform.android);
      expect(
        PlatformDetector.instance.current,
        equals(TargetPlatform.android),
      );
    });

    test('resetで上書きをクリアできる', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.iOS);
      PlatformDetector.instance.reset();
      expect(PlatformDetector.instance.current, equals(defaultTargetPlatform));
    });

    test('isIOSはiOS環境でtrueを返す', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.iOS);
      expect(PlatformDetector.instance.isIOS, isTrue);
      expect(PlatformDetector.instance.isAndroid, isFalse);
    });

    test('isAndroidはAndroid環境でtrueを返す', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.android);
      expect(PlatformDetector.instance.isAndroid, isTrue);
      expect(PlatformDetector.instance.isIOS, isFalse);
    });

    test('isLinuxはLinux環境でtrueを返す', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.linux);
      expect(PlatformDetector.instance.isLinux, isTrue);
      expect(PlatformDetector.instance.isIOS, isFalse);
    });

    test('isMacOSはmacOS環境でtrueを返す', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.macOS);
      expect(PlatformDetector.instance.isMacOS, isTrue);
      expect(PlatformDetector.instance.isIOS, isFalse);
    });

    test('isWindowsはWindows環境でtrueを返す', () {
      PlatformDetector.instance.overridePlatform(TargetPlatform.windows);
      expect(PlatformDetector.instance.isWindows, isTrue);
      expect(PlatformDetector.instance.isIOS, isFalse);
    });

    // Web環境でのテストは実際のWebビルドで確認
    // kIsWebは定数のため、テスト時にモック化できない
  });
}
