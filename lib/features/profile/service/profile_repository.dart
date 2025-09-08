import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/services/dio_service.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';
import 'package:gemini_project/features/profile/model/channel_model.dart';


final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileRepository(dio);
});

class ProfileRepository {
  final Dio _dio;
  ProfileRepository(this._dio);

  Future<Channel> fetchChannelDetails({required String channelId}) async {
    try {
      // Fetch channel details and videos in parallel
      final responses = await Future.wait([
        // Request for channel details
        _dio.get('/channels', queryParameters: {
          'part': 'snippet,statistics',
          'id': channelId,
        }),
        // Request for channel's videos
        _dio.get('/search', queryParameters: {
          'part': 'snippet',
          'channelId': channelId,
          'maxResults': 20,
          'order': 'date',
          'type': 'video',
        }),
      ]);

      // Process channel details response
      final channelResponse = responses[0];
      if (channelResponse.data['items'].isEmpty) {
        throw Exception('Channel not found');
      }
      final channelItem = channelResponse.data['items'][0];
      
      // Process videos response
      final videosResponse = responses[1];
      final List<dynamic> videoItems = videosResponse.data['items'];
      
      final videos = videoItems.map((item) {
        // Note: The /search endpoint doesn't provide statistics like views/likes.
        // A more complex implementation would require another API call per video.
        // For this project, we'll populate with available data.
        return VideoPost(
          videoId: item['id']['videoId'],
          title: item['snippet']['title'],
          description: item['snippet']['description'],
          thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
          channelId: item['snippet']['channelId'],
          channelTitle: item['snippet']['channelTitle'],
          viewCount: 'N/A', // Not available from this endpoint
          likeCount: 'N/A', // Not available from this endpoint
          publishedAt: DateTime.parse(item['snippet']['publishedAt']),
        );
      }).toList();

      return Channel(
        id: channelItem['id'],
        title: channelItem['snippet']['title'],
        description: channelItem['snippet']['description'],
        avatarUrl: channelItem['snippet']['thumbnails']['high']['url'],
        subscriberCount: channelItem['statistics']['subscriberCount'] ?? '0',
        videos: videos,
      );

    } on DioException catch (e) {
      print('Error fetching channel details: $e');
      throw Exception('Failed to load channel details');
    }
  }
}