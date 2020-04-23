import './movie_or_episode.dart';

class ShowsCollection {
  String title;
  List<MovieOrEpisode> shows = [];

  ShowsCollection(this.title, this.shows);

  ShowsCollection.fromJson(Map<String, dynamic> parsedJson) {
    title = parsedJson['title'];
    shows = List.from(parsedJson['items'])
      .map((item) => MovieOrEpisode.fromJson(item))
      .toList();
  }
}
