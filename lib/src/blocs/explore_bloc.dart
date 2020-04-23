import 'dart:async';
import 'package:rxdart/subjects.dart';

import '../models/movie.dart';
import '../resources/movies_api.dart';

class ExploreBloc {
  final _searchFetcher = PublishSubject<List<Movie>>();

  Stream<List<Movie>> get searchResults => _searchFetcher.stream;

  searchMovies(String search) async {
    if (search.isEmpty) { return; }

    try {
      _searchFetcher.sink.add(await MoviesApi.exploreMovies(search));
    } catch (e) {
      _searchFetcher.sink.addError(e);
    }
  }

  dispose() {
    _searchFetcher.close();
  }
}