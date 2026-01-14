import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/core/router/router.dart'; // Import router for SettingsRoute

class MyPagePage extends ConsumerWidget {
  const MyPagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('MyPage'),
            ElevatedButton(
              onPressed: () => ref
                  .read(appNavigatorProvider)
                  .navigateTo(const SettingsRoute()),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
