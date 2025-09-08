import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gemini_project/features/feed/model/video_post_model.dart';

part 'channel_model.freezed.dart';
part 'channel_model.g.dart';

@freezed
class Channel with _$Channel {
  const factory Channel({
    required String id,
    required String title,
    required String description,
    required String avatarUrl,
    required String subscriberCount,
    required List<VideoPost> videos,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}