// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoPostImpl _$$VideoPostImplFromJson(Map<String, dynamic> json) =>
    _$VideoPostImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      channelId: json['channelId'] as String,
      channelTitle: json['channelTitle'] as String,
      viewCount: json['viewCount'] as String,
      likeCount: json['likeCount'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$$VideoPostImplToJson(_$VideoPostImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'channelId': instance.channelId,
      'channelTitle': instance.channelTitle,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
