import 'package:json_annotation/json_annotation.dart';

import './movie.dart';

part 'episode.g.dart';

@JsonSerializable()

class Episode {
  Episode();

  String actors;
  String director;
  int episode;
  String firstAired;
  String imdbId;
  Movie movie;
  String plot;
  String poster;
  double ratingImdb;
  int ratingMetascore;
  int ratingRottenTomatoes;
  String resolution;
  String runtime;
  int season;
  String thumbnail;
  String title;
  double watched;
  String writer;
  int year;

  int id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
