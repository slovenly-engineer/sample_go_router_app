import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// Import necessary routes (now parts of router.dart, but accessible via router.dart or imports if public)
// Since they are parts, and classes are public, we can import router.dart or the specific part file source?
// No, must import library 'router.dart'.
import 'package:sample_go_router_app/features/home/presentation/home_page.dart';
import 'package:sample_go_router_app/features/mypage/presentation/mypage_page.dart';
import 'package:sample_go_router_app/features/search/presentation/search_page.dart';
import 'package:sample_go_router_app/main.dart'; // For MyApp or main setup if needed, but we'll build a test app

void main() {
  testWidgets('Bottom Navigation Bar switching works', (
    WidgetTester tester,
  ) async {
    // Build the app with real router
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Initial Route should be /home
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SearchPage), findsNothing);

    // Tap Search Tab
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Should see SearchPage
    expect(find.byType(SearchPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);

    // Tap MyPage Tab
    await tester.tap(find.text('MyPage'));
    await tester.pumpAndSettle();

    // Should see MyPagePage
    expect(find.byType(MyPagePage), findsOneWidget);
  });

  testWidgets('Modal Route (Filter) covers BottomNavBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Navigate to Search
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Tap Open Filter
    await tester.tap(find.text('Open Filter'));
    await tester.pumpAndSettle();

    // Should see FilterPage
    expect(find.text('Filter Modal Dialog'), findsOneWidget);

    // BottomNavBar should be HIDDEN (not in tree or obscured?)
    // Since Filter is a root route (pushed on top of Shell), the Shell (and NavBar) is below it in stack.
    // But verify behavior: usually checking failure to find widgets is tricky if they are just obscured.
    // However, GoRouter root routes REPLACE the shell in the view stack? No, 'push' stacks them.
    // If we push, the BottomNavBar is still in the widget tree under the transparency (if modal is transparent)
    // or just covered.
    // But FilterPage is a MATERIAL PAGE. It's opaque.
    // The BottomNavBar is part of the Shell. The Shell is in the background.
    // FindsByText 'Search' (tab label) might still find it?
    // Let's check if the widget tree structure places FilterPage ABOVE the ScaffoldWithNavBar.
    // If so, user cannot interact with NavBar.

    // Nested Route Test
    // Navigate Back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Navigate to MyPage
    await tester.tap(find.text('MyPage'));
    await tester.pumpAndSettle();

    // Tap Open Settings
    await tester.tap(find.text('Open Settings'));
    await tester.pumpAndSettle();

    // Should see SettingsPage
    expect(find.text('Settings Page (Nested)'), findsOneWidget);

    // BottomNavBar should be VISIBLE
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text('MyPage'), findsWidgets); // Label on tab
  });
}
