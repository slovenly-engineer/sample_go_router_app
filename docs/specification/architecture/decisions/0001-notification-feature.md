# ADR-0001: flutter_local_notifications 導入とプッシュ通知からの画面遷移機能

作成日: 2026-01-13
ステータス: 承認済み（実装完了: 2026-01-14）

## 概要

flutter_local_notificationsパッケージを導入し、ローカルプッシュ通知から既存のすべての画面へ遷移できる機能を追加します。既存の画面遷移方式（GoRouter + AppNavigator）は維持します。

## ユーザー要件

- **通知タイプ**: ローカル通知のみ（flutter_local_notifications）
- **画面遷移**: すべての既存画面（7画面）へ遷移可能
- **トリガー**: テストボタンから即座に通知表示（開発・デモ用）

## アーキテクチャ判断

### 1. 通知サービスの配置場所

**決定**: `lib/features/notifications/` に配置

**理由**:
- 通知機能は独立した機能であり、Feature-First原則に従う
- core/は共通インフラ層であり、特定機能は配置しない
- 将来的に通知設定画面などの追加が容易

### 2. 画面遷移の実装方法

**決定**: 既存のAppNavigatorを使用

**理由**:
- プロジェクト全体で画面遷移方法を統一
- HierarchyRoute/ModalRouteの判別ロジックを一元管理
- 将来的な遷移ロジックの変更が容易
- 既存のパターンに従うことで保守性向上

### 3. ルート情報の管理と責任の分離

**決定**:
- 通知ペイロードにパス文字列を格納
- `pathToRoute`関数（`core/router/route_resolver.dart`）でパスからAppBaseRouteを特定
- `NotificationNavigationHandler`（`features/notifications/handlers/`）で通知タップ時の画面遷移を担当
- `NotificationService`は通知の管理のみを担当（初期化、表示、削除など）

**理由**:
- **責任の明確な分離**:
  - `pathToRoute`関数（`core/router/route_resolver.dart`）: 汎用的なパスからルートへの変換機能
  - `NotificationService`（`features/notifications/data/`）: 通知の管理のみ（初期化、表示、削除など）
  - `NotificationNavigationHandler`（`features/notifications/handlers/`）: 通知タップ時の画面遷移を担当
- **テスト容易性**: 各コンポーネントを独立してテスト可能、依存をモック化しやすい
- **再利用性**: `pathToRoute`は通知以外（ディープリンクなど）でも使用可能
- **拡張性**: 通知タップ時の処理を変更する場合も`NotificationNavigationHandler`のみ変更
- プライベートメソッドを排除（すべて公開メソッド）
- 依存性注入により、テスト時にモック化が容易
- 想定外のパスは`null`を返して遷移を拒否
- AppBaseRoute.locationを使って型安全にパス生成可能
- **新しい画面追加時にコード変更不要**（GoRouterに登録されていれば自動対応）
- **パラメータ付きルートも自動対応**
- **ネストされたルート（StatefulShellRoute内のルート）も自動対応**
- **保守性の向上**（手動マッピングの削除）

**注意点**:
- `pathToRoute`が非同期メソッドになるため、呼び出し側も非同期処理が必要
- GoRouterの`routeInformationParser`が非同期で動作するため、パフォーマンスへの影響を考慮（ただし、通知タップ時の1回のみなので影響は軽微）

## 実装ファイル一覧

### 新規作成ファイル（3ファイル）

1. **`lib/core/router/route_resolver.dart`**
   - 汎用的なパスからルートへの変換機能
   - `pathToRoute`関数を提供
   - 通知、ディープリンク、その他の用途で使用可能

2. **`lib/features/notifications/data/notification_service.dart`**
   - 通知サービス本体（Riverpod Provider）
   - 初期化、通知表示処理、権限リクエスト
   - 通知の管理のみを担当（画面遷移は含まない）
   - **画面情報のハードコードを排除し、純粋な送信処理のみを提供**

3. **`lib/features/notifications/handlers/notification_navigation_handler.dart`**
   - 通知タップ時の画面遷移を担当
   - `pathToRoute`と`AppNavigator`を使用して画面遷移を実行

4. **`lib/features/notifications/notification_test_route.dart`**
   - 通知テスト専用画面のルート定義
   - ModalRoute（モーダル表示）として定義

5. **`lib/features/notifications/presentation/notification_test_page.dart`**
   - 通知テスト専用画面
   - 7つの個別ボタンを配置（各画面への通知を個別に送信可能）

### 変更ファイル（5ファイル）

6. **`pubspec.yaml`**
   - `flutter_local_notifications: ^17.2.3` を追加

7. **`lib/main.dart`**
   - 通知サービスの初期化処理を追加
   - `ProviderContainer`を使用した非同期初期化
   - `UncontrolledProviderScope`を使用して既存の`ProviderScope`と統合
   - **理由**: 通知サービスの初期化は非同期処理が必要なため、`main`関数で`await`を使用できるように`ProviderContainer`を事前に作成。`UncontrolledProviderScope`により、既存のRiverpodパターンと互換性を保ちつつ、初期化済みのコンテナを使用可能。

8. **`android/app/src/main/AndroidManifest.xml`**
   - `POST_NOTIFICATIONS` 権限追加（Android 13+対応）
   - `VIBRATE` 権限追加
   - `RECEIVE_BOOT_COMPLETED` 権限追加
   - `ScheduledNotificationReceiver` レシーバー追加
   - `ScheduledNotificationBootReceiver` レシーバー追加

9. **`ios/Runner/AppDelegate.swift`**
   - `import flutter_local_notifications` 追加
   - `FlutterLocalNotificationsPlugin.setPluginRegistrantCallback` 追加（バックグラウンド通知対応）
   - `UNUserNotificationCenter.current().delegate = self` 追加（フォアグラウンド通知表示に必須）

10. **`lib/features/home/presentation/home_page.dart`**
    - 「Notification Test」ボタンを追加（NotificationTestPageへ遷移）

## 詳細設計

---

> **⚠️ 設計変更に関する注記（2026-01-14）**
>
> 以下のセクション1「pathToRoute関数」およびセクション3「NotificationNavigationHandler」の設計は、**実装時に変更されました**。
>
> GoRouter 17.0.0で `routeInformationParser.parseRouteInformation` が `UnimplementedError` を投げるようになったため、`pathToRoute` 関数は廃止され、代わりに `AppNavigator.navigateToPath(String path)` メソッドを使用する設計に変更されています。
>
> 詳細は本ドキュメント末尾の「トラブルシューティング」セクションを参照してください。
>
> **現在の実装:**
> - `route_resolver.dart` は作成されていません
> - `NotificationNavigationHandler` は `AppNavigator.navigateToPath()` を直接呼び出します

---

### 1. ~~pathToRoute関数（パスからルートへの変換ロジック）~~ （廃止）

**ファイル: `lib/core/router/route_resolver.dart`** ※廃止済み

```dart
import 'package:go_router/go_router.dart';
import 'route_types.dart';

/// パス文字列からAppBaseRouteを復元する汎用的な関数
/// 通知、ディープリンク、その他の用途で使用可能
/// GoRouterのrouteInformationParserを使用して、location文字列から
/// 自動的にGoRouteDataを取得します。
///
/// 想定外のパスの場合はnullを返す
Future<AppBaseRoute?> pathToRoute(GoRouter router, String path) async {
  try {
    final routeInformation = RouteInformation(uri: Uri.parse(path));
    final routeMatchList = await router.routeInformationParser
        .parseRouteInformation(routeInformation);

    if (routeMatchList.matches.isEmpty) {
      print('[WARNING] No route match found for path: $path');
      return null;
    }

    // 最後のマッチ（実際のルート）を取得
    // matchesには親ルートから子ルートへの順序で格納されているため、
    // lastを取得することで最終的なルート（実際に表示される画面）を特定できる
    // 例: StatefulShellRoute -> HomeRoute の場合、HomeRouteがlastになる
    final lastMatch = routeMatchList.matches.last;
    final routeData = lastMatch.route;

    if (routeData is AppBaseRoute) {
      return routeData;
    }

    print('[WARNING] Route data is not AppBaseRoute: ${routeData.runtimeType}');
    return null;
  } catch (e) {
    print('[WARNING] Failed to parse path: $path, error: $e');
    return null;
  }
}
```

**設計の利点:**
- **汎用性**: 通知、ディープリンク、その他の用途で使用可能
- **責任の分離**: パスからルートへの変換のみを担当（純粋関数）
- **テスト容易性**: 関数として単体テストが簡単（GoRouterをモックして渡すだけ）

**新しい画面追加時:**
- GoRouterにルートを登録するだけで自動対応（コード変更不要）

### 2. NotificationService（通知の管理のみ）

**ファイル: `lib/features/notifications/data/notification_service.dart`**

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../handlers/notification_navigation_handler.dart';

part 'notification_service.g.dart';

@Riverpod(keepAlive: true)
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  return NotificationService(
    plugin: ref.watch(flutterLocalNotificationsPluginProvider),
    navigationHandler: ref.watch(notificationNavigationHandlerProvider),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationNavigationHandler _navigationHandler;
  final TargetPlatform? _platform;

  NotificationService({
    required FlutterLocalNotificationsPlugin plugin,
    required NotificationNavigationHandler navigationHandler,
    TargetPlatform? platform,
  })  : _plugin = plugin,
        _navigationHandler = navigationHandler,
        _platform = platform;

  /// 初期化
  /// initSettingsは内部で定義（固定値）
  /// 通知タップ時の処理はNotificationNavigationHandlerに委譲
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // 通知タップ時の処理はNotificationNavigationHandlerに委譲
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _navigationHandler.handleNotificationTapped,
    );

    await requestPermissions();
  }

  /// 通知権限をリクエスト
  /// プラットフォームに応じて適切な権限リクエストを実行
  Future<void> requestPermissions() async {
    final platform = _platform ?? defaultTargetPlatform;

    if (platform == TargetPlatform.iOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (platform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  /// 即座に通知表示（基本メソッド）
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    required String path,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      channelDescription: 'Channel for instant notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: path,
    );
  }
}
```

**責任の分離:**
- `NotificationService`: 通知の管理のみ（初期化、表示、削除など）
- 画面遷移の処理は含まない
- **画面情報のハードコードを排除**（ルート情報は呼び出し側が渡す）

**テスト可能性:**
- `FlutterLocalNotificationsPlugin`をモック化可能（コンストラクタで注入）
- `NotificationNavigationHandler`をモック化可能（コンストラクタで注入）
- すべて公開メソッド（プライベートメソッドなし）

**バックグラウンド通知ハンドラー（将来の拡張）:**

アプリがバックグラウンドまたは終了状態で通知をタップした場合に対応するため、トップレベル関数の追加が推奨されます：

```dart
// notification_service.dart のトップレベルに追加
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  // バックグラウンドでのタップ処理
  // 注意: この関数は別のisolateで実行されるため、
  // Providerへのアクセスは制限される
  debugPrint('Background notification tapped: ${response.payload}');
}

// initialize() 内で登録
await _plugin.initialize(
  initSettings,
  onDidReceiveNotificationResponse: _navigationHandler.handleNotificationTapped,
  onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
);
```

**注意:**
- `@pragma('vm:entry-point')` アノテーションが必須
- トップレベル関数または静的メソッドである必要がある
- 別のisolateで実行されるため、Riverpod Providerへの直接アクセスは不可

### 3. ~~NotificationNavigationHandler（通知タップ時の画面遷移）~~ （設計変更済み）

**ファイル: `lib/features/notifications/handlers/notification_navigation_handler.dart`**

---

> **⚠️ 以下は当初の設計です。実際の実装とは異なります。**

---

<details>
<summary>当初の設計（クリックで展開）</summary>

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/router/app_navigator.dart';
import '../../../core/router/router.dart';
import '../../../core/router/route_resolver.dart';

part 'notification_navigation_handler.g.dart';

@Riverpod(keepAlive: true)
NotificationNavigationHandler notificationNavigationHandler(Ref ref) {
  return NotificationNavigationHandler(
    router: ref.watch(goRouterProvider),
    navigator: ref.watch(appNavigatorProvider),
  );
}

class NotificationNavigationHandler {
  final GoRouter _router;
  final AppNavigator _navigator;

  NotificationNavigationHandler({
    required GoRouter router,
    required AppNavigator navigator,
  })  : _router = router,
        _navigator = navigator;

  /// 通知タップ時の処理
  /// NotificationServiceのinitializeでコールバックとして使用
  Future<void> handleNotificationTapped(NotificationResponse response) async {
    final path = response.payload;
    if (path == null || path.isEmpty) return;

    // ルートの特定（core/router/route_resolver.dartのpathToRouteを使用）
    final route = await pathToRoute(_router, path);
    if (route == null) {
      print('[WARNING] Invalid path from notification: $path');
      return;
    }

    // 画面遷移の実行
    _navigator.navigateTo(route);
  }
}
```

**画面遷移の仕組み:**
1. 通知タップ → `handleNotificationTapped()` 呼び出し（非同期）
2. ペイロードからパス文字列を取得
3. `pathToRoute(router, path)` でGoRouterの`routeInformationParser`を使用してルートを自動復元（非同期）
4. `AppNavigator.navigateTo(route)` で既存メソッドを使って遷移

**責任の分離:**
- `pathToRoute`関数: パスからルートへの変換のみを担当（純粋関数）
- `NotificationNavigationHandler.handleNotificationTapped`: 通知タップ時の画面遷移を担当
- `AppNavigator.navigateTo`: 実際の画面遷移を実行

**テスト可能性:**
- `GoRouter`と`AppNavigator`をモック化可能（コンストラクタで注入）
- すべて公開メソッド（プライベートメソッドなし）

</details>

---

**✅ 実際の実装:**

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/router/app_navigator.dart';

part 'notification_navigation_handler.g.dart';

@Riverpod(keepAlive: true)
NotificationNavigationHandler notificationNavigationHandler(Ref ref) {
  return NotificationNavigationHandler(
    navigator: ref.watch(appNavigatorProvider),
  );
}

class NotificationNavigationHandler {
  final AppNavigator _navigator;

  NotificationNavigationHandler({
    required AppNavigator navigator,
  }) : _navigator = navigator;

  /// 通知タップ時の処理
  /// NotificationServiceのinitializeでコールバックとして使用
  void handleNotificationTapped(NotificationResponse response) {
    final path = response.payload;
    if (path == null || path.isEmpty) return;

    // パス文字列から直接遷移（GoRouterが有効なパスか検証）
    _navigator.navigateToPath(path);
  }
}
```

**変更点:**
- `GoRouter` への依存を削除（`AppNavigator` のみに依存）
- `pathToRoute` 関数の使用を廃止
- `AppNavigator.navigateToPath(path)` を直接呼び出し
- 同期メソッドに変更（`Future<void>` → `void`）

### 4. main.dart 初期化フロー

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // NotificationServiceの初期化だけ（内部で完結）
  await container.read(notificationServiceProvider).initialize();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
```

### 5. NotificationTestRoute（通知テスト画面のルート定義）

**ファイル: `lib/features/notifications/notification_test_route.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/route_types.dart';
import 'presentation/notification_test_page.dart';

part 'notification_test_route.g.dart';

@TypedGoRoute<NotificationTestRoute>(
  path: '/notification-test',
)
class NotificationTestRoute extends ModalRoute {
  const NotificationTestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationTestPage();
  }
}
```

**理由:**
- ModalRouteとして定義（モーダル表示）
- テスト専用画面なので独立したルートとして管理

### 6. NotificationTestPage（通知テスト専用画面）

**ファイル: `lib/features/notifications/presentation/notification_test_page.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/router/route_types.dart';
import '../data/notification_service.dart';
import '../../auth/login_route.dart';
import '../../home/home_route.dart';
import '../../search/search_route.dart';
import '../../search/filter_route.dart';
import '../../mypage/mypage_route.dart';
import '../../mypage/settings_route.dart';
import '../../items/item_route.dart';

class NotificationTestPage extends ConsumerWidget {
  const NotificationTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tap each button to send a test notification',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            _buildNotificationButton(
              ref: ref,
              id: 1,
              title: 'Go to Login',
              body: 'Tap to navigate to Login page',
              route: const LoginRoute(),
              icon: Icons.login,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 2,
              title: 'Go to Home',
              body: 'Tap to navigate to Home page',
              route: const HomeRoute(),
              icon: Icons.home,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 3,
              title: 'Go to Search',
              body: 'Tap to navigate to Search page',
              route: const SearchRoute(),
              icon: Icons.search,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 4,
              title: 'Go to MyPage',
              body: 'Tap to navigate to MyPage',
              route: const MyPageRoute(),
              icon: Icons.person,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 5,
              title: 'Go to Settings',
              body: 'Tap to navigate to Settings page',
              route: const SettingsRoute(),
              icon: Icons.settings,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 6,
              title: 'Go to Item Detail',
              body: 'Tap to view Item #42',
              route: const ItemDetailRoute(id: '42'),
              icon: Icons.info,
            ),
            const SizedBox(height: 12),

            _buildNotificationButton(
              ref: ref,
              id: 7,
              title: 'Go to Filter',
              body: 'Tap to open Filter screen',
              route: const FilterRoute(),
              icon: Icons.filter_list,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton({
    required WidgetRef ref,
    required int id,
    required String title,
    required String body,
    required AppBaseRoute route,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: () async {
        await ref.read(notificationServiceProvider).showInstantNotification(
              id: id,
              title: title,
              body: body,
              path: route.location,
            );
      },
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
```

### 7. HomePage の変更（テスト画面への遷移ボタン追加）

**ファイル: `lib/features/home/presentation/home_page.dart`**

既存のコンテンツに以下のボタンを追加:

```dart
// 既存のボタンの下に追加
const SizedBox(height: 16),
ElevatedButton.icon(
  onPressed: () {
    ref.read(appNavigatorProvider).navigateTo(
          const NotificationTestRoute(),
        );
  },
  icon: const Icon(Icons.notifications),
  label: const Text('Notification Test'),
),
```

**必要なインポート追加:**
```dart
import '../notifications/notification_test_route.dart';
```

### 8. ルート登録（router.dart への追加）

**ファイル: `lib/core/router/router.dart`**

`@TypedGoRoute` アノテーションでルートを自動登録するため、コード変更不要。
`build_runner` 実行時に自動的に `NotificationTestRoute` が登録される。

**設計の利点:**
- ✅ **テストコードと本番コードの分離**: Home画面はクリーンなまま
- ✅ **削除が容易**: 本番リリース時にNotificationTest関連を削除しやすい
- ✅ NotificationServiceは純粋に通知送信のみ（画面情報を持たない）
- ✅ 各ボタンで個別に通知をテスト可能
- ✅ 通知内容を柔軟に変更できる
- ✅ UIとして直感的（どの通知を送るか明確）
- ✅ 新規画面追加時もServiceの変更不要

## プラットフォーム設定

### Android

**AndroidManifest.xml に追加:**

1. **パーミッション**（`<manifest>` タグ直下）:
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
```

2. **通知レシーバー**（`<application>` タグ内）:
```xml
<receiver android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
<receiver android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
        <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
    </intent-filter>
</receiver>
```

**注意:** スケジュール通知を使用しない場合でも、レシーバーの登録は推奨されます。

### iOS

**AppDelegate.swift の設定（必須）:**

```swift
import Flutter
import UIKit
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // バックグラウンド通知用コールバック登録
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // iOS 10以上でのデリゲート設定（フォアグラウンド通知表示に必須）
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

**重要:**
- `import flutter_local_notifications` が必要
- `UNUserNotificationCenter.current().delegate = self` がないと、**アプリがフォアグラウンドの時に通知が表示されない**
- `FlutterLocalNotificationsPlugin.setPluginRegistrantCallback` がないと、バックグラウンドでの通知タップが正常に処理されない可能性がある

**Info.plist（オプション）:**
```xml
<key>NSUserNotificationsUsageDescription</key>
<string>This app needs notification permissions to send you important updates.</string>
```

## 実装順序

### Phase 1: パッケージ導入
1. `pubspec.yaml` に `flutter_local_notifications` 追加
2. `flutter pub get` 実行

### Phase 2: サービス実装
3. `core/router/route_resolver.dart` 作成
   - `pathToRoute`関数の実装（汎用的なパスからルートへの変換ロジック）
4. `features/notifications/handlers/notification_navigation_handler.dart` 作成
   - 通知タップ時の画面遷移処理
5. `features/notifications/data/notification_service.dart` 作成
   - `NotificationService`クラスの実装
   - 初期化処理（initSettingsは内部で定義）
   - 通知表示メソッド（`showInstantNotification`のみ）
   - **画面情報のハードコードを排除**（呼び出し側がルート情報を渡す）
6. `features/notifications/notification_test_route.dart` 作成
   - 通知テスト画面のルート定義（ModalRoute）
7. `features/notifications/presentation/notification_test_page.dart` 作成
   - 通知テスト専用画面の実装
   - 7つの個別ボタンを配置
8. `flutter pub run build_runner build --delete-conflicting-outputs` 実行

### Phase 3: アプリ統合
9. `main.dart` 更新（初期化処理）
10. `home_page.dart` 更新（NotificationTestPageへの遷移ボタン追加）
11. `AndroidManifest.xml` 更新（権限・レシーバー追加）
12. `ios/Runner/AppDelegate.swift` 更新（デリゲート設定追加）

### Phase 4: 検証
13. `flutter analyze` で静的解析
14. Android/iOSエミュレータで動作確認
    - 通知権限リクエストの確認
    - Home画面から「Notification Test」ボタンでテスト画面へ遷移
    - 各ボタンで個別に通知が送信されることを確認
    - 各通知タップで対応画面へ遷移することを確認

## 既存コードへの影響

### 変更不要なファイル
- ✅ `lib/core/router/router.dart` - 変更不要
- ✅ `lib/core/router/app_navigator.dart` - 変更不要
- ✅ `lib/core/router/route_types.dart` - 変更不要
- ✅ すべてのルート定義ファイル - 変更不要

### 影響範囲
- **最小限**: 既存の画面遷移ロジックには一切影響なし
- **分離設計**: 通知機能は独立したfeatureとして実装

## テスト計画

> **更新（2026-01-14）**: `pathToRoute`関数は廃止されたため、テスト対象から除外。
> モックライブラリは Mocktail を使用。

### 単体テスト

#### NotificationNavigationHandlerのテスト
- **テストファイル**: `test/features/notifications/handlers/notification_navigation_handler_test.dart`
- **テスト項目**:
  - `handleNotificationTapped`が正しく画面遷移を実行すること
  - 空のペイロードの場合、画面遷移が実行されないこと
  - nullのペイロードの場合、画面遷移が実行されないこと
  - パラメータ付きパスで遷移が実行されること

**実装コード**: `test/features/notifications/handlers/notification_navigation_handler_test.dart` を参照

#### NotificationServiceのテスト
- **テストファイル**: `test/features/notifications/data/notification_service_test.dart`
- **テスト項目**:
  - `initialize`が正しく初期化すること
  - `showInstantNotification`が通知を表示しペイロードにパスが設定されること
  - 異なるIDで複数の通知を表示できること
  - `requestPermissions` がiOSプラットフォームの場合にiOS権限リクエストを呼び出すこと
  - `requestPermissions` がAndroidプラットフォームの場合にAndroid権限リクエストを呼び出すこと
  - `requestPermissions` がその他のプラットフォームの場合に何も実行しないこと

**実装コード**: `test/features/notifications/data/notification_service_test.dart` を参照

### 手動テスト
1. アプリ起動
2. Home画面で「Notification Test」ボタンを確認
3. 「Notification Test」ボタンをタップしてテスト画面へ遷移
4. テスト画面で7つのボタンを確認
5. 各ボタンをタップして個別に通知が送信されることを確認
6. 各通知をタップして対応画面へ遷移することを確認:
   - Login通知 → Login画面
   - Home通知 → Home画面
   - Search通知 → Search画面
   - MyPage通知 → MyPage画面
   - Settings通知 → Settings画面
   - Item Detail通知 → Item Detail画面（ID: 42）
   - Filter通知 → Filter画面
7. 通知の内容（タイトル、本文）が正しく表示されることを確認

### 検証項目
- [ ] パッケージが正しくインストールされている
- [ ] 通知サービスが初期化されている
- [ ] **iOS: AppDelegate.swiftにデリゲート設定が追加されている**
- [ ] **iOS: フォアグラウンドで通知が表示される**
- [ ] **Android: AndroidManifest.xmlにレシーバーが登録されている**
- [ ] Android/iOSで通知権限がリクエストされる
- [ ] Home画面に「Notification Test」ボタンが表示される
- [ ] 「Notification Test」ボタンでテスト画面へ遷移する
- [ ] テスト画面に7つの個別ボタンが正しく表示される
- [ ] 各ボタンで個別に通知が送信される
- [ ] 各通知タップで対応画面に遷移する
- [ ] パラメータ付きルート（ItemDetail）が正しく動作する
- [ ] ネストルート（Settings）が正しく動作する
- [ ] 静的解析エラーがない（`flutter analyze`）
- [ ] 単体テストがすべて通過する

## 将来の拡張性

このアーキテクチャは以下の拡張に対応可能:
- スケジュール通知（特定時刻に通知）
- 定期通知（毎日、毎週など）
- リッチ通知（BigTextStyle、BigPictureStyleなど）
- Firebase Cloud Messaging（FCM）との統合

## 代替案

### 代替案1: NotificationServiceに`showTestNotificationsForAllRoutes`メソッドを追加
- NotificationServiceに7つの通知を一括送信するメソッドを追加
- HomePage側では単一のボタンで一括送信
- **却下理由**:
  - NotificationServiceに画面情報がハードコードされる（責任過多）
  - 新しい画面追加時にServiceの変更が必要（保守性低下）
  - 個別の通知をテストできない（柔軟性不足）
  - ビジネスロジック（どの画面に送るか）がServiceに含まれる

### 代替案2: ルートクラス名とパラメータを格納
- NotificationPayloadにルートクラス名（例: `LoginRoute`）とパラメータを格納
- `toRoute()`メソッドでルートオブジェクトを再構築
- **却下理由**: 画面追加時にNotificationPayloadの`toRoute()`を更新する必要がある。switchケースが肥大化し保守性が低下する。

### 代替案3: GoRouter.go()を直接使用
- AppNavigatorを使わず、GoRouterのgo()メソッドを直接呼び出す
- **却下理由**: プロジェクト全体で画面遷移方法が統一されず、保守性が低下する。

### 代替案4: core/notifications/に配置
- 通知サービスをcore層に配置
- **却下理由**: Feature-First原則に反する。通知は独立した機能であり、features配下が適切。

## トラブルシューティング

### 問題: GoRouter 17.0.0で通知タップ時に画面遷移が失敗する

**症状**:
```
flutter: [WARNING] Failed to parse path: /login, error: UnimplementedError: Use parseRouteInformationWithDependencies instead
flutter: [WARNING] Invalid path from notification: /login
```

**原因**:
GoRouter 17.0.0で`routeInformationParser.parseRouteInformation`が非推奨になり、`UnimplementedError`を投げるようになった。新しい`parseRouteInformationWithDependencies`は`BuildContext`を必要とするが、通知タップのコールバック内では`BuildContext`が利用できない。

**解決策**:
`pathToRoute`関数を廃止し、`AppNavigator`に`navigateToPath`メソッドを追加。GoRouterの`go()`/`push()`メソッドはパス文字列を直接受け付けるため、`BuildContext`なしで動作する。

**修正後の設計**:
1. `AppNavigator.navigateToPath(String path)` - パス文字列から直接遷移
2. `NotificationNavigationHandler` - `AppNavigator`のみに依存（`GoRouter`と`pathToRoute`への依存を削除）
3. `route_resolver.dart` - 削除

**教訓**:
- GoRouterの内部API（`routeInformationParser`）に依存しない
- GoRouterの公開API（`go()`/`push()`）を直接使用する
- シンプルな設計を優先する

### 問題: 通知タップ時のFilterPage画面に戻るボタンがない

**症状**:
Search画面からFilterPageに遷移した場合は戻るボタンがあるが、通知からFilterPageに遷移した場合は戻るボタンがない。

**原因**:
`FilterRoute`に2つのバグがあった：

1. **継承元が間違い**: `ModalRoute`を継承していたが、本来は`HierarchyRoute`
2. **ルート階層が間違い**: ルートレベル（`/filter`）に配置されていたが、本来はSearchRouteの子（`/search/filter`）

FilterPageはSearch画面の子階層（Search → Filter）であり、`SettingsRoute`（MyPageRoute → Settings）と同様のパターンで定義すべきだった。

**解決策**:

1. `FilterRoute`の継承元を`ModalRoute`から`HierarchyRoute`に変更
2. `filter_route.dart`を`part of router.dart`形式に変更
3. `router.dart`で`SearchRoute`の子ルートとして定義

```dart
// router.dart
TypedStatefulShellBranch(
  routes: [
    TypedGoRoute<SearchRoute>(
      path: '/search',
      routes: [TypedGoRoute<FilterRoute>(path: 'filter')],  // /search/filter
    ),
  ],
),

// filter_route.dart
part of '../../core/router/router.dart';

class FilterRoute extends HierarchyRoute with $FilterRoute {
  const FilterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FilterPage();
}
```

**修正後のパス**: `/filter` → `/search/filter`

**教訓**:
- 画面の階層構造をGoRouterのルート定義に正確に反映する
- 親子関係のある画面は子ルートとして定義する（`SettingsRoute`パターン参照）
- `part of router.dart`形式を使用すると、ルート階層が明確になる

### 問題: Androidビルド時にcore library desugaringエラーが発生する

**症状**:
```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:checkReleaseAarMetadata'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.CheckAarMetadataWorkAction
   > An issue was found when checking AAR metadata:

       1.  Dependency ':flutter_local_notifications' requires core library desugaring to be enabled
           for :app.
```

**原因**:
`flutter_local_notifications` パッケージが Java 8以降のAPI（java.timeパッケージなど）を使用しているため、Android Gradle Plugin のcore library desugaring機能を有効にする必要がある。desugaring機能により、古いAndroidバージョン（API level 26未満）でもJava 8+ APIを使用できるようになる。

**解決策**:

[android/app/build.gradle.kts](../../../../../android/app/build.gradle.kts) に以下の設定を追加：

1. **compileOptionsセクションに`coreLibraryDesugaringEnabled`を追加**:
```kotlin
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
    isCoreLibraryDesugaringEnabled = true
}
```

2. **dependenciesセクションに desugaring ライブラリを追加**:
```kotlin
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
```

**修正完了日**: 2026-01-15

**教訓**:
- flutter_local_notificationsなど、Java 8+ APIを使用するパッケージを導入する際は、Androidのcore library desugaringが必要
- エラーメッセージに記載されたURLを確認し、公式の推奨設定に従う
- [Android公式ドキュメント: Java 8+サポート](https://developer.android.com/studio/write/java8-support.html)

### 問題: Android 13+ で起動時に通知許諾ダイアログが表示されない

**症状**:
- Android 13以上のデバイスでアプリを起動しても、通知許諾ダイアログが自動表示されない
- iOSでは起動時にダイアログが表示されるが、Androidでは表示されない
- AndroidManifest.xmlには `POST_NOTIFICATIONS` 権限が宣言されているにもかかわらず、通知が送信できない

**原因**:
Android 13 (API level 33) 以上では、POST_NOTIFICATIONS は危険権限（Dangerous Permission）として分類され、実行時リクエストが必須になりました。AndroidManifest.xml への静的な権限宣言だけでは不十分で、アプリ起動時に `requestNotificationsPermission()` を呼び出す必要があります。

当初の実装では `requestIOSPermissions()` のみが実装されており、Android向けの実行時リクエスト処理が欠落していました。

**解決策**:

1. **NotificationService に単一の `requestPermissions()` メソッドを実装**:

```dart
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationNavigationHandler _navigationHandler;
  final TargetPlatform? _platform;

  NotificationService({
    required FlutterLocalNotificationsPlugin plugin,
    required NotificationNavigationHandler navigationHandler,
    TargetPlatform? platform,  // テスト用に依存性注入可能
  }) : _plugin = plugin,
       _navigationHandler = navigationHandler,
       _platform = platform;

  /// 通知権限をリクエスト
  /// プラットフォームに応じて適切な権限リクエストを実行
  Future<void> requestPermissions() async {
    final platform = _platform ?? defaultTargetPlatform;

    if (platform == TargetPlatform.iOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (platform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }
}
```

2. **`initialize()` メソッドで権限リクエストを呼び出し**:

```dart
Future<void> initialize() async {
  // ... 初期化設定 ...

  await _plugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse:
        _navigationHandler.handleNotificationTapped,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  await requestPermissions();  // 単一メソッドで両プラットフォームに対応
}
```

**修正完了日**: 2026-01-15

**設計判断**:
- **単一メソッド化**: `requestIOSPermissions()` と `requestAndroidPermissions()` を分離するのではなく、単一の `requestPermissions()` メソッド内でプラットフォーム判定を行う設計に変更
  - 呼び出し側が複数のメソッドを意識する必要がなくなる
  - プラットフォーム判定ロジックが内部に集約される
- **依存性注入**: `TargetPlatform` をコンストラクタで注入可能にすることで、単体テストでプラットフォーム分岐を検証可能
  - 本番環境では `defaultTargetPlatform` を使用
  - テスト環境では `TargetPlatform.iOS` や `TargetPlatform.android` を明示的に指定

**教訓**:
- Android 13+ では POST_NOTIFICATIONS が危険権限に昇格したため、実行時リクエストが必須
- プラットフォーム判定ロジックは内部に隠蔽し、呼び出し側をシンプルに保つ
- OS分岐は単体テストで検証できるよう、依存性注入を活用する
- `resolvePlatformSpecificImplementation` は適切にプラットフォームを判定するため、追加の `Platform.isAndroid` 判定は不要
- flutter_local_notifications パッケージは `requestNotificationsPermission()` メソッドを提供しているため、追加のパーミッションライブラリ（permission_handlerなど）は不要

**参考資料**:
- [Handling Notification Permissions in Flutter for Android 13](https://www.linkedin.com/pulse/handling-notification-permissions-flutter-android-13-neha-tanwar)
- [Android Notification Runtime Permissions](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [flutter_local_notifications package](https://pub.dev/packages/flutter_local_notifications)

## 参考資料

- [flutter_local_notifications パッケージ](https://pub.dev/packages/flutter_local_notifications)
- [GoRouter 公式ドキュメント](https://pub.dev/packages/go_router)
- [プロジェクトアーキテクチャ原則](../../../common/architecture-principles.md)
- [新機能追加手順](../../implementation/how-to/add-feature.md)
- [Android Java 8+ サポート](https://developer.android.com/studio/write/java8-support.html)
