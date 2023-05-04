// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoItems _$VideoItemsFromJson(Map<String, dynamic> json) => VideoItems(
      id: json['id'] as String,
      snippet: VideoSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      statistics:
          VideoStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoItemsToJson(VideoItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet,
      'statistics': instance.statistics,
    };

VideoSnippet _$VideoSnippetFromJson(Map<String, dynamic> json) => VideoSnippet(
      publishedAt: json['publishedAt'] as String,
      title: json['title'] as String,
      thumbnails:
          VideoThumbnail.fromJson(json['thumbnails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoSnippetToJson(VideoSnippet instance) =>
    <String, dynamic>{
      'publishedAt': instance.publishedAt,
      'title': instance.title,
      'thumbnails': instance.thumbnails,
    };

VideoThumbnail _$VideoThumbnailFromJson(Map<String, dynamic> json) =>
    VideoThumbnail(
      medium: ThumbnailURL.fromJson(json['medium'] as Map<String, dynamic>),
      high: ThumbnailURL.fromJson(json['high'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoThumbnailToJson(VideoThumbnail instance) =>
    <String, dynamic>{
      'medium': instance.medium,
      'high': instance.high,
    };

ThumbnailURL _$ThumbnailURLFromJson(Map<String, dynamic> json) => ThumbnailURL(
      url: json['url'] as String,
    );

Map<String, dynamic> _$ThumbnailURLToJson(ThumbnailURL instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

VideoStatistics _$VideoStatisticsFromJson(Map<String, dynamic> json) =>
    VideoStatistics(
      viewCount: json['viewCount'] as String,
    );

Map<String, dynamic> _$VideoStatisticsToJson(VideoStatistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
    };
