import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/services/dio_service.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FeedRepository(dio);
});

class FeedRepository {
  final Dio _dio;
  FeedRepository(this._dio);

  Future<List<VideoPost>> fetchTrendingVideos({String? pageToken}) async {
    try {
      final response = await _dio.get('/videos', queryParameters: {
        'part': 'snippet,statistics',
        'chart': 'mostPopular',
        'regionCode': 'US',
        'maxResults': 10,
        'pageToken': pageToken,
      });

      final List<dynamic> items = response.data['items'];
      
      final videos = items.map((item) {
        return VideoPost(
          videoId: item['id'],
          title: item['snippet']['title'],
          description: item['snippet']['description'],
          thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
          channelId: item['snippet']['channelId'],
          channelTitle: item['snippet']['channelTitle'],
          viewCount: item['statistics']['viewCount'] ?? '0',
          likeCount: item['statistics']['likeCount'] ?? '0',
          publishedAt: DateTime.parse(item['snippet']['publishedAt']),
        );
      }).toList();

      return videos;
    } on DioException catch (e) {
      // You can handle specific errors here
      print('Error fetching trending videos: $e');
      throw Exception('Failed to load videos');
    }
  }
}