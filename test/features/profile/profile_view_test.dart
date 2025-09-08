// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:gemini_project/features/profile/controller/profile_controller.dart';
// import 'package:gemini_project/features/profile/model/channel_model.dart';
// import 'package:gemini_project/features/profile/view/profile_view.dart';
// import 'package:mockito/mockito.dart';

// class MockProfileController extends Mock implements ProfileController {}

// void main() {
//   testWidgets('ProfileView shows loading indicator, then profile data', (tester) async {
//     final mockController = MockProfileController();

//     when(mockController.build('1')).thenAnswer((_) async => const Channel(
//           id: '1',
//           title: 'Test Channel',
//           avatarUrl: 'https://example.com/avatar.jpg',
//           subscriberCount: '100',
//           description: 'Test Description',
//         ));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           profileControllerProvider.overrideWith((ref, channelId) => mockController),
//         ],
//         child: const MaterialApp(home: ProfileView(channelId: '1')),
//       ),
//     );

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     await tester.pumpAndSettle();

//     expect(find.text('Test Channel'), findsOneWidget);
//     expect(find.text('100 subscribers'), findsOneWidget);
//     expect(find.text('Test Description'), findsOneWidget);
//   });

//   testWidgets('ProfileView shows error message on error', (tester) async {
//     final mockController = MockProfileController();

//     when(mockController.build('1')).thenThrow(Exception('Test Error'));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           profileControllerProvider.overrideWith((ref, channelId) => mockController),
//         ],
//         child: const MaterialApp(home: ProfileView(channelId: '1')),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('Exception: Test Error'), findsOneWidget);
//   });
// }
