import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybete_app/diabete_options.dart';
import 'package:mybete_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MyApp Widget Test', () {
    testWidgets('Should display CircularProgressIndicator while checking login status', (WidgetTester tester) async {
      // Fake SharedPreferences for logged out state
      SharedPreferences.setMockInitialValues({
        'isLoggedIn': false,
        'lastLoginDate': '',
      });

      await tester.pumpWidget(MyApp());

      // Let async init finish
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Should display DiabeteOptions when user is logged in', (WidgetTester tester) async {
      // Fake SharedPreferences for logged in state
      SharedPreferences.setMockInitialValues({
        'isLoggedIn': true,
        'lastLoginDate': DateTime.now().toIso8601String(),
      });

      await tester.pumpWidget(MyApp());

      // Let async init finish
      await tester.pumpAndSettle();

      expect(find.byType(DiabeteOptions), findsOneWidget);
    });
  });
}
