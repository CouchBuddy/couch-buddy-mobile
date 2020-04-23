import 'dart:async';
import 'package:rxdart/subjects.dart';

import '../models/movie.dart';
import '../models/shows_collection.dart';
import '../resources/movies_api.dart';

class HomeBloc {
  final _collectionsFetcher = PublishSubject<List<ShowsCollection>>();
  final _featuredFetcher = PublishSubject<Movie>();

  Stream<List<ShowsCollection>> get collections => _collectionsFetcher.stream;
  Stream<Movie> get featuredMovie => _featuredFetcher.stream;

  fetchCollections() async {
    try {
      print('fetchCollections');
      _collectionsFetcher.sink.add(await MoviesApi.fetchMoviesCollections());
    } catch (e) {
      _collectionsFetcher.sink.addError(e);
    }
  }

  fetchFeaturedMovie() async {
    try {
      print('fetchFeaturedMovie');
      _featuredFetcher.sink.add(await MoviesApi.fetchOne(-1));
    } catch (e) {
      _featuredFetcher.sink.addError(e);
    }
  }

  dispose() {
    _collectionsFetcher.close();
    _featuredFetcher.close();
  }
}