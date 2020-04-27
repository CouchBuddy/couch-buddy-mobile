// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subtitle _$SubtitleFromJson(Map<String, dynamic> json) {
  return Subtitle()
    ..fileName = json['fileName'] as String
    ..lang = json['lang'] as String
    ..mediaId = json['mediaId'] as int
    ..mediaType = json['mediaType'] as String
    ..id = json['id'] as int
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String);
}

Map<String, dynamic> _$SubtitleToJson(Subtitle instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'lang': instance.lang,
      'mediaId': instance.mediaId,
      'mediaType': instance.mediaType,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
