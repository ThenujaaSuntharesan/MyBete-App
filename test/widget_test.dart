import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mybete_app/diabete_options.dart';
import 'package:mybete_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

// Mock SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('MyApp Widget Test', () {
    late MockSharedPreferences mockPrefs;

    setUp(() {
      mockPrefs = MockSharedPreferences();
    });

    testWidgets('Should display CircularProgressIndicator while checking login status', (WidgetTester tester) async {
      // Mock that user is logged out
      when(() => mockPrefs.getBool('isLoggedIn')).thenReturn(false);
      when(() => mockPrefs.getString('lastLoginDate')).thenReturn('');

      await tester.pumpWidget(MyApp());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should display DiabeteOptions when user is logged in', (WidgetTester tester) async {
      // Mock that user is logged in
      when(() => mockPrefs.getBool('isLoggedIn')).thenReturn(true);
      when(() => mockPrefs.getString('lastLoginDate')).thenReturn(DateTime.now().toIso8601String());

      await tester.pumpWidget(MyApp());

      expect(find.byType(DiabeteOptions), findsOneWidget);
    });
  });
}
