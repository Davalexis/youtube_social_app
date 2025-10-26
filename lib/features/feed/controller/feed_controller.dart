import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';
import 'package:gemini_project/features/feed/service/feed_repository.dart';

final feedControllerProvider =
    StateNotifierProvider<FeedController, AsyncValue<List<VideoPost>>>((ref) {
  return FeedController(ref.watch(feedRepositoryProvider));
});

class FeedController extends StateNotifier<AsyncValue<List<VideoPost>>> {
  final FeedRepository _feedRepository;
  String? _nextPageToken;
  bool _isLoading = false;

  FeedController(this._feedRepository) : super(const AsyncValue.loading()) {
    fetchInitialVideos();
  }

  Future<void> fetchInitialVideos() async {
    state = const AsyncValue.loading();
    try {
      final videos = await _feedRepository.fetchTrendingVideos();
      state = AsyncValue.data(videos);
      // Note: The YouTube API v3 doesn't consistently return a nextPageToken for the 'mostPopular' chart
      // We will handle pagination assuming it might be available for other query types in the future.
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    try {
      final videos = await _feedRepository.fetchTrendingVideos();
      state = AsyncValue.data(videos);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchMoreVideos() async {
    // Prevent multiple simultaneous requests
    if (_isLoading) return;
    _isLoading = true;

    try {
      final newVideos = await _feedRepository.fetchTrendingVideos(pageToken: _nextPageToken);
      
      state.whenData((existingVideos) {
        state = AsyncValue.data([...existingVideos, ...newVideos]);
      });
    } catch (e) {
      // Handle error without overwriting existing data
      print("Error fetching more videos: $e");
    } finally {
      _isLoading = false;
    }
  }
}