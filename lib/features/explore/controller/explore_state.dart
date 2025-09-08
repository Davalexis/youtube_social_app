import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';

part 'explore_state.freezed.dart';

enum ExploreStatus { initial, loading, success, failure }

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState({
    @Default(ExploreStatus.initial) ExploreStatus status,
    @Default([]) List<VideoPost> videos,
    @Default('') String query,
    String? errorMessage,
  }) = _ExploreState;
}