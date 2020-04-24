// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie()
    ..actors = json['actors'] as String
    ..awards = json['awards'] as String
    ..background = json['background'] as String
    ..country = json['country'] as String
    ..director = json['director'] as String
    ..genre = json['genre'] as String
    ..imdbId = json['imdbId'] as String
    ..language = json['language'] as String
    ..plot = json['plot'] as String
    ..poster = json['poster'] as String
    ..rated = json['rated'] as String
    ..ratingImdb = (json['ratingImdb'] as num)?.toDouble()
    ..ratingMetacritic = json['ratingMetacritic'] as int
    ..ratingRottenTomatoes = json['ratingRottenTomatoes'] as int
    ..released = json['released'] as String
    ..resolution = json['resolution'] as String
    ..runtime = json['runtime'] as String
    ..title = json['title'] as String
    ..type = json['type'] as String
    ..watched = (json['watched'] as num)?.toDouble()
    ..writer = json['writer'] as String
    ..year = json['year'] as int
    ..episodes = (json['episodes'] as List)
            ?.map((e) =>
                e == null ? null : Episode.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..movie = json['movie'] == null
        ? null
        : Movie.fromJson(json['movie'] as Map<String, dynamic>)
    ..torrents = json['torrents'] as List ?? []
    ..id = json['id'] as int
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..updatedAt = json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'actors': instance.actors,
      'awards': instance.awards,
      'background': instance.background,
      'country': instance.country,
      'director': instance.director,
      'genre': instance.genre,
      'imdbId': instance.imdbId,
      'language': instance.language,
      'plot': instance.plot,
      'poster': instance.poster,
      'rated': instance.rated,
      'ratingImdb': instance.ratingImdb,
      'ratingMetacritic': instance.ratingMetacritic,
      'ratingRottenTomatoes': instance.ratingRottenTomatoes,
      'released': instance.released,
      'resolution': instance.resolution,
      'runtime': instance.runtime,
      'title': instance.title,
      'type': instance.type,
      'watched': instance.watched,
      'writer': instance.writer,
      'year': instance.year,
      'episodes': instance.episodes,
      'movie': instance.movie,
      'torrents': instance.torrents,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
