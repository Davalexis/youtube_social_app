// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:gemini_project/features/feed/controller/feed_controller.dart';
// import 'package:gemini_project/features/feed/model/video_post_model.dart';
// import 'package:gemini_project/features/feed/view/feed_view.dart';
// import 'package:mockito/mockito.dart';

// class MockFeedController extends Mock implements FeedController {}

// void main() {
//   testWidgets('FeedView shows loading indicator, then videos', (tester) async {
//     final mockController = MockFeedController();

//     when(mockController.build()).thenAnswer((_) async => [
//           const VideoPost(
//             videoId: '1',
//             title: 'Test Video',
//             thumbnailUrl: 'https://example.com/thumbnail.jpg',
//             channelName: 'Test Channel',
//             channelAvatarUrl: 'https://example.com/avatar.jpg',
//             viewCount: '100',
//           )
//         ]);

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           feedControllerProvider.overrideWith((_) => mockController),
//         ],
//         child: const MaterialApp(home: FeedView()),
//       ),
//     );

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     await tester.pumpAndSettle();

//     expect(find.byType(VideoPostWidget), findsOneWidget);
//   });

//   testWidgets('FeedView shows error message on error', (tester) async {
//     final mockController = MockFeedController();

//     when(mockController.build()).thenThrow(Exception('Test Error'));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           feedControllerProvider.overrideWith((_) => mockController),
//         ],
//         child: const MaterialApp(home: FeedView()),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('An error occurred: Exception: Test Error'), findsOneWidget);
//   });
// }
