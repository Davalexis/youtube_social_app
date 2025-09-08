import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_project/features/player/view/player_view.dart';

void main() {
  testWidgets('PlayerView renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PlayerView(videoId: 'test'),
      ),
    );

    expect(find.byType(PlayerView), findsOneWidget);
  });
}
