import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_post_model.freezed.dart';
part 'video_post_model.g.dart';

@freezed
class VideoPost with _$VideoPost {
  const factory VideoPost({
    required String videoId,
    required String title,
    required String description,
    required String thumbnailUrl,
    required String channelId,
    required String channelTitle,
    required String viewCount,
    required String likeCount,
    required DateTime publishedAt,
  }) = _VideoPost;

  factory VideoPost.fromJson(Map<String, dynamic> json) =>
      _$VideoPostFromJson(json);
}