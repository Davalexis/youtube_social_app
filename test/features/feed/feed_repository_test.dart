// import 'package:flutter_test/flutter_test.dart';
// import 'package:gemini_project/features/feed/model/video_post_model.dart';
// import 'package:gemini_project/features/feed/service/feed_repository.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dio/dio.dart';

// import 'feed_repository_test.mocks.dart';

// @GenerateMocks([Dio])
// void main() {
//   late FeedRepository feedRepository;
//   late MockDio mockDio;

//   setUp(() {
//     mockDio = MockDio();
//     feedRepository = FeedRepository(mockDio);
//   });

//   group('FeedRepository', () {
//     test('fetchTrendingVideos returns a list of VideoPost on success', () async {
//       final videosResponseData = {
//         'items': [
//           {
//             'id': '1',
//             'snippet': {
//               'title': 'Test Video 1',
//               'thumbnails': {'high': {'url': 'url1'}},
//               'channelTitle': 'Test Channel 1',
//               'channelId': 'c1',
//             },
//             'statistics': {'viewCount': '100'}
//           },
//         ]
//       };
//       final channelsResponseData = {
//         'items': [
//           {
//             'id': 'c1',
//             'snippet': {
//               'thumbnails': {'default': {'url': 'avatar_url'}}
//             }
//           }
//         ]
//       };
//       final videosResponse = Response(
//         data: videosResponseData,
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/videos'),
//       );
//       final channelsResponse = Response(
//         data: channelsResponseData,
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/channels'),
//       );

//       when(mockDio.get(
//         '/videos',
//         queryParameters: anyNamed('queryParameters'),
//       )).thenAnswer((_) async => videosResponse);

//       when(mockDio.get(
//         '/channels',
//         queryParameters: anyNamed('queryParameters'),
//       )).thenAnswer((_) async => channelsResponse);

//       final result = await feedRepository.fetchTrendingVideos();

//       expect(result, isA<List<VideoPost>>());
//       expect(result.length, 1);
//       expect(result[0].videoId, '1');
//       expect(result[0].channelAvatarUrl, 'avatar_url');
//     });

//     test('fetchTrendingVideos throws an exception on failure', () async {
//       when(mockDio.get(
//         '/videos',
//         queryParameters: anyNamed('queryParameters'),
//       )).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

//       expect(() => feedRepository.fetchTrendingVideos(), throwsA(isA<DioException>()));
//     });
//   });
// }