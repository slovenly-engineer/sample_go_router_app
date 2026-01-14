import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/router/route_types.dart';
import '../../../core/router/router.dart';
import '../../auth/login_route.dart';
import '../data/notification_service.dart';

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
