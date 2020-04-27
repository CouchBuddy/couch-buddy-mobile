import 'dart:async';
import 'package:dio/dio.dart';

import '../models/download.dart';
import '../models/movie.dart';
import '../models/movie_or_episode.dart';
import '../models/shows_collection.dart';
import '../models/subtitle.dart';
import '../utils/preferences.dart';

Dio client = Dio(
  BaseOptions(
    baseUrl: '${preferences.serverUrl}/api'
  )
);

class MoviesApi {
  static Future<List<ShowsCollection>> fetchMoviesCollections() async {
    final collections = [
      [ 'Continue Watching', 'continue-watching' ],
      [ 'Recently Added', 'recently-added' ]
    ];

    try {
      final List<ShowsCollection> list = List();

      for (final collection in collections) {
        final response = await client.get('/collections/${collection[1]}');

        list.add(
          ShowsCollection(
            collection[0],
            List.from(response.data)
              .map((movie) => MovieOrEpisode.fromJson(movie))
              .toList()
          )
        );
      }
      return list;
    } catch (e) {
      print(e);
      throw Exception('Failed to load movies');
    }
  }

  static Future<Movie> fetchOne(int id) async {
    try {
      final response = await client.get('/library/${id > 0 ? id : 'random'}', queryParameters: {
        'include': 'episodes'
      });

      return Movie.fromJson(response.data);
    } catch(e) {
      print(e);
      throw Exception('Failed to load movie');
    }
  }

  static Future<List<Movie>> searchMovies(String search) async {
    try {
      final response = await client.get('/library', queryParameters: {
        'search': search
      });

      return List.from(response.data)
        .map((movie) => Movie.fromJson(movie))
        .toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to search movies');
    }
  }

  static Future<List<Subtitle>> fetchSubtitles(String watchId) async {
    try {
      final response = await client.get('/watch/$watchId/subtitles');

      return List.from(response.data)
        .map((subtitle) => Subtitle.fromJson(subtitle))
        .toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch subtitles');
    }
  }

  static Future<List<Movie>> exploreMovies(String search) async {
    try {
      final response = await client.get('/explore', queryParameters: {
        'search': search
      });

      return List.from(response.data)
        .map((movie) => Movie.fromJson(movie))
        .toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to search movies');
    }
  }

  static Future<Download> addDownload(String magnetUrl) async {
    try {
      final response = await client.post('/downloads', data: {
        'magnetURI': magnetUrl
      });

      return Download.fromJson(response.data);
    } catch (e) {
      print(e);
      throw Exception('Failed to add download');
    }
  }
}
