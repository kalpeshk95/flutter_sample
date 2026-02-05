import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_sample/main.dart';

void main() {
  testWidgets('FinWise app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FinWiseApp());

    // Verify that the app loads successfully
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Wait for splash screen to potentially navigate
    await tester.pumpAndSettle();
  });
}
