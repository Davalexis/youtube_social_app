// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChannelImpl _$$ChannelImplFromJson(Map<String, dynamic> json) =>
    _$ChannelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      avatarUrl: json['avatarUrl'] as String,
      subscriberCount: json['subscriberCount'] as String,
      videos:
          (json['videos'] as List<dynamic>)
              .map((e) => VideoPost.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$ChannelImplToJson(_$ChannelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'subscriberCount': instance.subscriberCount,
      'videos': instance.videos,
    };
