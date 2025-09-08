import 'package:dio/dio.dart';
import 'package:gemini_project/core/services/dio_service.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exploreRepositoryProvider = Provider<ExploreRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ExploreRepository(dio);
});

class ExploreRepository {
  final Dio _dio;
  ExploreRepository(this._dio);

  Future<List<VideoPost>> searchVideos({required String query}) async {
    try {
      final response = await _dio.get('/search', queryParameters: {
        'part': 'snippet',
        'q': query,
        'maxResults': 20,
        'type': 'video',
      });

      final List<dynamic> items = response.data['items'];
      
      final videos = items.map((item) {
        return VideoPost(
          videoId: item['id']['videoId'],
          title: item['snippet']['title'],
          description: item['snippet']['description'],
          thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
          channelId: item['snippet']['channelId'],
          channelTitle: item['snippet']['channelTitle'],
          viewCount: 'N/A', // Not available from search endpoint
          likeCount: 'N/A', // Not available from search endpoint
          publishedAt: DateTime.parse(item['snippet']['publishedAt']),
        );
      }).toList();

      return videos;
      
    } on DioException catch (e) {
      print('Error searching videos: $e');
      throw Exception('Failed to search videos');
    }
  }
}