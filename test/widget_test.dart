import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybete_app/screens/diabete_options.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  // Disable animations during tests
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DiabeteOptions loads and displays all buttons', (WidgetTester tester) async {
    // Mock SharedPreferences
    final mockPrefs = MockSharedPreferences();
    when(mockPrefs.getBool('onboarding')).thenReturn(false);

    // Inject the mock SharedPreferences instance
    SharedPreferences.setMockInitialValues({});

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: DiabeteOptions(),
      ),
    );

    // Wait for the widget tree to settle
    await tester.pumpAndSettle(Duration(seconds: 1));

    // Check that the instruction text is displayed
    expect(find.text("Choose one option from these three"), findsOneWidget);

    // Check that the buttons are present
    expect(find.text("Have Diabetes"), findsOneWidget);
    expect(find.text("Don't Have Diabetes"), findsOneWidget);
    expect(find.text("Need Guidance"), findsOneWidget);
  });
}
