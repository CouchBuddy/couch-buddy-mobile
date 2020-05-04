import 'package:json_annotation/json_annotation.dart';

part 'subtitle.g.dart';

@JsonSerializable()

class Subtitle {
  Subtitle();

  String fileName;
  String lang;
  String langName;
  int mediaId;
  String mediaType;

  int id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Subtitle.fromJson(Map<String, dynamic> json) => _$SubtitleFromJson(json);

  Map<String, dynamic> toJson() => _$SubtitleToJson(this);
}
