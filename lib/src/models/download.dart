import 'package:json_annotation/json_annotation.dart';

part 'download.g.dart';

@JsonSerializable()

class Download {
  Download();

  String infoHash;
  String name;
  DownloadInfo info;
  double timeRemaining;
  double downloadSpeed;
  double uploadSpeed;
  int downloaded;
  int length;
  double progress;
  bool paused;
  bool done;
  int numPeers;

  factory Download.fromJson(Map<String, dynamic> json) => _$DownloadFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadToJson(this);
}

@JsonSerializable()

class DownloadInfo {
  DownloadInfo();

  String title;
  int season;
  int episode;
  String resolution;
  String codec;
  String source;

  factory DownloadInfo.fromJson(Map<String, dynamic> json) => _$DownloadInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadInfoToJson(this);
}
