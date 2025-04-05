import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybete_app/diabete_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Initialize test environment
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DiabeteOptions loads and displays all buttons', (WidgetTester tester) async {
    // Set mock SharedPreferences values
    SharedPreferences.setMockInitialValues({'onboarding': false});

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: DiabeteOptions(),
      ),
    );

    // Ensure the widget is fully built
    await tester.pump();
    await tester.pumpAndSettle();

    // Check that the instruction text is displayed
    expect(find.text("Choose one option from these three"), findsOneWidget);

    // Check that the buttons are present
    expect(find.text("Have Diabetes"), findsOneWidget);
    expect(find.text("Don't Have Diabetes"), findsOneWidget);
    expect(find.text("Need Guidance"), findsOneWidget);
  });
}
