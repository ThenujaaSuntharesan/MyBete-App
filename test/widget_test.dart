import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybete_app/diabete_options.dart';

void main() {
  testWidgets('DiabeteOptions loads and displays all buttons',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: DiabeteOptions()),
        );

        await tester.pumpAndSettle();

        // Check the main instruction text
        expect(find.text("Choose one option from these three"), findsOneWidget);

        // Check the buttons
        expect(find.text("Have Diabetes"), findsOneWidget);
        expect(find.text("Don't Have Diabetes"), findsOneWidget);
        expect(find.text("Need Guidance"), findsOneWidget);
      });
}
