import './episode.dart';
import './movie.dart';

class MovieOrEpisode {
  Movie movie;
  Episode episode;

  MovieOrEpisode({ this.movie, this.episode });

  MovieOrEpisode.fromJson(dynamic jsonData) {
    if (jsonData['type'] == 'movie') {
      movie = Movie.fromJson(jsonData);
    } else {
      episode = Episode.fromJson(jsonData);
    }
  }

  bool get isEpisode => episode != null;
  bool get isMovie => movie != null;
}
