import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/route_types.dart';

part 'login_route.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends HierarchyRoute with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login Page')),
    );
  }
}
