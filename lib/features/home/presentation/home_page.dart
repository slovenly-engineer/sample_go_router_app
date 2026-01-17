import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/home/presentation/home_view_model.dart';
import 'package:sample_go_router_app/features/notifications/notification_test_route.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                unawaited(
                  ref
                      .read(homeViewModelProvider.notifier)
                      .onItemSelected('123'),
                );
              },
              child: const Text('Go to Item 123'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                unawaited(
                  ref
                      .read(appNavigatorProvider)
                      .navigateTo(const NotificationTestRoute()),
                );
              },
              icon: const Icon(Icons.notifications),
              label: const Text('Notification Test'),
            ),
          ],
        ),
      ),
    );
  }
}
