import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_go_router_app/core/app_launch/app_launch_manager_provider.dart';
import 'package:sample_go_router_app/core/router/router.dart';
import 'package:sample_go_router_app/features/notifications/data/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  if (!kIsWeb) {
    // 起動情報の収集（通知、ディープリンクなど）
    await container
        .read(appLaunchManagerProvider)
        .collectLaunchInfo();

    // NotificationServiceの初期化
    await container.read(notificationServiceProvider).initialize();
  }

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
