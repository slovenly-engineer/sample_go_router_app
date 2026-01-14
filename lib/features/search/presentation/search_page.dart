import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/features/search/filter_route.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Search Page'),
            ElevatedButton(
              onPressed: () => ref
                  .read(appNavigatorProvider)
                  .navigateTo(const FilterRoute()),
              child: const Text('Open Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
