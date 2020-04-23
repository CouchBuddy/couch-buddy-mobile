// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Download _$DownloadFromJson(Map<String, dynamic> json) {
  return Download()
    ..infoHash = json['infoHash'] as String
    ..name = json['name'] as String
    ..info = json['info'] == null
        ? null
        : DownloadInfo.fromJson(json['info'] as Map<String, dynamic>)
    ..timeRemaining = (json['timeRemaining'] as num)?.toDouble()
    ..downloadSpeed = (json['downloadSpeed'] as num)?.toDouble()
    ..uploadSpeed = (json['uploadSpeed'] as num)?.toDouble()
    ..downloaded = json['downloaded'] as int
    ..length = json['length'] as int
    ..progress = (json['progress'] as num)?.toDouble()
    ..paused = json['paused'] as bool
    ..done = json['done'] as bool
    ..numPeers = json['numPeers'] as int;
}

Map<String, dynamic> _$DownloadToJson(Download instance) => <String, dynamic>{
      'infoHash': instance.infoHash,
      'name': instance.name,
      'info': instance.info,
      'timeRemaining': instance.timeRemaining,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'downloaded': instance.downloaded,
      'length': instance.length,
      'progress': instance.progress,
      'paused': instance.paused,
      'done': instance.done,
      'numPeers': instance.numPeers,
    };

DownloadInfo _$DownloadInfoFromJson(Map<String, dynamic> json) {
  return DownloadInfo()
    ..title = json['title'] as String
    ..season = json['season'] as int
    ..episode = json['episode'] as int
    ..resolution = json['resolution'] as String
    ..codec = json['codec'] as String
    ..source = json['source'] as String;
}

Map<String, dynamic> _$DownloadInfoToJson(DownloadInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'season': instance.season,
      'episode': instance.episode,
      'resolution': instance.resolution,
      'codec': instance.codec,
      'source': instance.source,
    };
