import 'dart:async';
import 'package:rxdart/subjects.dart';

import '../models/movie.dart';
import '../models/shows_collection.dart';
import '../resources/movies_api.dart';

class MoviesBloc {
  final _moviesFetcher = PublishSubject<List<ShowsCollection>>();
  final _movieFetcher = PublishSubject<Movie>();
  final _searchFetcher = PublishSubject<List<Movie>>();

  Stream<List<ShowsCollection>> get allMovies => _moviesFetcher.stream;
  Stream<Movie> get oneMovie => _movieFetcher.stream;
  Stream<List<Movie>> get searchResults => _searchFetcher.stream;

  fetchAllMovies() async {
    try {
      _moviesFetcher.sink.add(await MoviesApi.fetchMoviesCollections());
    } catch (e) {
      _moviesFetcher.sink.addError(e);
    }
  }

  fetchOneMovie(int id) async {
    try {
      _movieFetcher.sink.add(await MoviesApi.fetchOne(id));
    } catch (e) {
      _movieFetcher.sink.addError(e);
    }
  }

  searchMovies(String search) async {
    if (search.isEmpty) { return; }

    try {
      _searchFetcher.sink.add(await MoviesApi.searchMovies(search));
    } catch (e) {
      _searchFetcher.sink.addError(e);
    }
  }

  dispose() {
    _moviesFetcher.close();
    _movieFetcher.close();
    _searchFetcher.close();
  }
}