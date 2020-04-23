import 'package:json_annotation/json_annotation.dart';

import './episode.dart';

part 'movie.g.dart';

@JsonSerializable()

class Movie {
  Movie();

  String actors;
  String awards;
  String country;
  String director;
  String genre;
  String imdbId;
  String language;
  String plot;
  String poster;
  String rated;
  double ratingImdb;
  int ratingMetacritic;
  int ratingRottenTomatoes;
  String released;
  String resolution;
  String runtime;
  String title;
  String type;
  double watched;
  String writer;
  int year;

  List<Episode> episodes = [];
  Movie movie;

  int id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  bool get isMovie => this.type == 'movie';
  bool get isSeries => this.type == 'series';
}
