import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/features/explore/controller/explore_state.dart';
import 'package:gemini_project/features/explore/service/explore_repository.dart';

final exploreControllerProvider =
    StateNotifierProvider<ExploreController, ExploreState>((ref) {
  return ExploreController(ref.watch(exploreRepositoryProvider));
});

class ExploreController extends StateNotifier<ExploreState> {
  final ExploreRepository _exploreRepository;
 
  ExploreController(this._exploreRepository) : super(const ExploreState());

  Future<void> searchVideos(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(status: ExploreStatus.initial, videos: []);
      return;
    }
    
    state = state.copyWith(status: ExploreStatus.loading, query: query);

    try {
      final videos = await _exploreRepository.searchVideos(query: query);
      state = state.copyWith(status: ExploreStatus.success, videos: videos);
    } catch (e) {
      state = state.copyWith(
        status: ExploreStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}