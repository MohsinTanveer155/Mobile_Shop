// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_shop/main.dart';
import 'package:mobile_shop/providers/settings_provider.dart';
import 'package:mobile_shop/services/preferences_service.dart';

void main() {
  testWidgets('App loads with onboarding screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferencesService = PreferencesService();
    await preferencesService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          preferencesServiceProvider.overrideWithValue(preferencesService),
        ],
        child: const MobileShopApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Mobile Shop'), findsOneWidget);
    expect(find.text('Welcome to Mobile Shop'), findsOneWidget);
  });
}
