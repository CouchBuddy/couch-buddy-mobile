import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';
import '../models/movie.dart';
import '../pages/movie_details.dart';
import '../widgets/stream_builder_enhanced.dart';

class MovieDetailsFromId extends StatefulWidget {
  final int movieId;

  MovieDetailsFromId(this.movieId, { Key key }) : super(key: key);

  @override
  _MovieDetailsFromIdState createState() => _MovieDetailsFromIdState();

}
class _MovieDetailsFromIdState extends State<MovieDetailsFromId> {
  final MoviesBloc bloc = MoviesBloc();

  @override
  Widget build(BuildContext context) {
    bloc.fetchOneMovie(widget.movieId);

    return StreamBuilderEnhanced(
      stream: bloc.oneMovie,
      builder: (Movie movie) => MovieDetails(movie)
    );
  }
}