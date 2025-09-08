// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:gemini_project/features/feed/model/video_post_model.dart';
// import 'package:gemini_project/features/profile/model/channel_model.dart';
// import 'package:gemini_project/features/profile/service/profile_repository.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'profile_repository_test.mocks.dart';

// @GenerateMocks([Dio])
// void main() {
//   late ProfileRepository profileRepository;
//   late MockDio mockDio;

//   setUp(() {
//     mockDio = MockDio();
//     profileRepository = ProfileRepository(mockDio);
//   });

//   group('ProfileRepository', () {
//     group('fetchChannelDetails', () {
//       test('returns a Channel on success', () async {
//         final responseData = {
//           'items': [
//             {
//               'id': '1',
//               'snippet': {
//                 'title': 'Test Channel',
//                 'thumbnails': {'default': {'url': 'url'}},
//                 'description': 'description',
//               },
//               'statistics': {'subscriberCount': '100'}
//             }
//           ]
//         };
//         final response = Response(
//           data: responseData,
//           statusCode: 200,
//           requestOptions: RequestOptions(path: ''),
//         );
//         when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
//             .thenAnswer((_) async => response);

//         final result = await profileRepository.fetchChannelDetails('1');

//         expect(result, isA<Channel>());
//         expect(result.id, '1');
//       });

//       test('throws an exception on failure', () async {
//         when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
//             .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

//         expect(() => profileRepository.fetchChannelDetails('1'),
//             throwsA(isA<DioException>()));
//       });
//     });

//     group('fetchChannelVideos', () {
//       test('returns a list of VideoPost on success', () async {
//         final searchResponseData = {
//           'items': [
//             {
//               'id': {'videoId': '1'},
//             }
//           ]
//         };
//         final videoResponseData = {
//           'items': [
//             {
//               'id': '1',
//               'snippet': {
//                 'title': 'Test Video',
//                 'thumbnails': {'high': {'url': 'url'}},
//                 'channelTitle': 'Test Channel',
//               },
//               'statistics': {'viewCount': '100'}
//             }
//           ]
//         };
//         final searchResponse = Response(
//           data: searchResponseData,
//           statusCode: 200,
//           requestOptions: RequestOptions(path: ''),
//         );
//         final videoResponse = Response(
//           data: videoResponseData,
//           statusCode: 200,
//           requestOptions: RequestOptions(path: ''),
//         );
//         when(mockDio.get('/search', queryParameters: anyNamed('queryParameters')))
//             .thenAnswer((_) async => searchResponse);
//         when(mockDio.get('/videos', queryParameters: anyNamed('queryParameters')))
//             .thenAnswer((_) async => videoResponse);

//         final result = await profileRepository.fetchChannelVideos('1');

//         expect(result, isA<List<VideoPost>>());
//         expect(result.length, 1);
//         expect(result[0].videoId, '1');
//       });

//       test('throws an exception on failure', () async {
//         when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
//             .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

//         expect(() => profileRepository.fetchChannelVideos('1'),
//             throwsA(isA<DioException>()));
//       });
//     });
//   });
// }
