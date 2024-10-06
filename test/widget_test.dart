import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculatorapp/main.dart';

void main() {
  testWidgets('Calculator app smoke test', (WidgetTester tester) async {
    // Build the CalculatorApp and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the calculator screen is displayed.
    expect(find.text('0'), findsOneWidget);  // Assumes your app starts with 0.

    // Tap on button '1' and then button '+'.
    await tester.tap(find.text('1'));
    await tester.pump();
    
    expect(find.text('1'), findsOneWidget);  // Should show 1 in the display.

    await tester.tap(find.text('+'));
    await tester.pump();

    // Tap on button '2' and then '='.
    await tester.tap(find.text('2'));
    await tester.pump();
    
    expect(find.text('2'), findsOneWidget);  // Should now display 2.

    await tester.tap(find.text('='));
    await tester.pump();

    // Verify that the result is '3'.
    expect(find.text('3'), findsOneWidget);  // Should display 1 + 2 = 3.
  });
}
