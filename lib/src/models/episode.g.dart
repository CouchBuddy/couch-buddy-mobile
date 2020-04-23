// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode()
    ..actors = json['actors'] as String
    ..director = json['director'] as String
    ..episode = json['episode'] as int
    ..firstAired = json['firstAired'] as String
    ..imdbId = json['imdbId'] as String
    ..movie = json['movie'] == null
        ? null
        : Movie.fromJson(json['movie'] as Map<String, dynamic>)
    ..plot = json['plot'] as String
    ..poster = json['poster'] as String
    ..ratingImdb = (json['ratingImdb'] as num)?.toDouble()
    ..ratingMetascore = json['ratingMetascore'] as int
    ..ratingRottenTomatoes = json['ratingRottenTomatoes'] as int
    ..resolution = json['resolution'] as String
    ..runtime = json['runtime'] as String
    ..season = json['season'] as int
    ..thumbnail = json['thumbnail'] as String
    ..title = json['title'] as String
    ..watched = (json['watched'] as num)?.toDouble()
    ..writer = json['writer'] as String
    ..year = json['year'] as int
    ..id = json['id'] as int
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String);
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'actors': instance.actors,
      'director': instance.director,
      'episode': instance.episode,
      'firstAired': instance.firstAired,
      'imdbId': instance.imdbId,
      'movie': instance.movie,
      'plot': instance.plot,
      'poster': instance.poster,
      'ratingImdb': instance.ratingImdb,
      'ratingMetascore': instance.ratingMetascore,
      'ratingRottenTomatoes': instance.ratingRottenTomatoes,
      'resolution': instance.resolution,
      'runtime': instance.runtime,
      'season': instance.season,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'watched': instance.watched,
      'writer': instance.writer,
      'year': instance.year,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
