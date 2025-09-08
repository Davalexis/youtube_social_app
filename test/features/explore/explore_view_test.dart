import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_project/features/explore/view/explore_view.dart';

void main() {
  testWidgets('ExploreView renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ExploreView(),
      ),
    );

    expect(find.text('Explore View'), findsOneWidget);
  });
}
