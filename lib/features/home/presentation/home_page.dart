import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sample_go_router_app/features/home/presentation/home_view_model.dart';

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
                // Example navigation
                ref.read(homeViewModelProvider.notifier).onItemSelected('123');
              },
              child: const Text('Go to Item 123'),
            ),
          ],
        ),
      ),
    );
  }
}
