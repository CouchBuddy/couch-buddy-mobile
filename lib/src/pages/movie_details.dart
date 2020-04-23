import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_cast_button/flutter_google_cast_button.dart';
import 'package:flutter_google_cast_button/bloc_media_route.dart';

import '../blocs/movies_bloc.dart';
import '../models/episode.dart';
import '../models/movie.dart';
import '../utils/localization.dart';
import '../utils/routes.dart';
import '../widgets/stream_builder_enhanced.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails(this.movieId, { Key key }) : super(key: key);

  @override
  MovieDetailsState createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  final MoviesBloc bloc = MoviesBloc();
  final MediaRouteBloc castBloc = MediaRouteBloc();

  int currentSeason = -1;
  bool isCastConnected = false;

  String _(String key, [int howMany = 1]) => AppLocalizations.of(context).translate(key, howMany);

  @override
  void initState() {
    castBloc.listen((state) {
      setState(() => isCastConnected = state is Connected);
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    castBloc.close();
    super.dispose();
  }

  void _playOrCast(String url) {
    if (isCastConnected) {
      FlutterGoogleCastButton.loadMedia(url);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]).then((e) {
        router.navigateTo(
          context,
          '${Routes.video}/${Uri.encodeComponent(url)}',
          transition: TransitionType.inFromBottom,
          transitionDuration: const Duration(milliseconds: 200),
        );
      });
    }
  }

  void _playOrCastMovie(Movie movie) {
    _playOrCast('http://192.168.1.2:3000/api/watch/m${movie.id}');
  }

  void _playOrCastEpisode(Episode episode) {
    _playOrCast('http://192.168.1.2:3000/api/watch/e${episode.id}');
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchOneMovie(widget.movieId);

    return StreamBuilderEnhanced(
      stream: bloc.oneMovie,
      builder: _buildPage
    );
  }

  Widget _buildPage(Movie movie) {
    final nextEpisode = movie.episodes
      .lastWhere((e) => e.watched < 95, orElse: () => null);

    final Set<int> seasons = movie.episodes
      .map((e) => e.season)
      .toSet();

    if (seasons.length > 0 && !seasons.contains(currentSeason)) {
      currentSeason = nextEpisode.season;
    }

    List<Episode> seasonEpisodes = movie.episodes
      .where((Episode e) => e.season == currentSeason)
      .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(movie),
          _buildMovieInfo(movie, seasons),
          _buildEpisodesList(seasonEpisodes)
        ],
      ),
    );
  }

  Widget _buildHeader(Movie movie) {
    return SliverAppBar(
      primary: true,
      expandedHeight: 220.0,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: Theme.of(context).textTheme.title
        ),
        background: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) =>
                LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [ Colors.transparent, Colors.black ],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
              blendMode: BlendMode.darken,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movie.poster),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            movie.isMovie ? Center(
              child: Container(
                height: 96.0,
                width: 96.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      _playOrCastMovie(movie);
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: Icon(
                      isCastConnected ? Icons.cast_connected : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 36.0,
                    ),
                  ),
                )
              )
            ) : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo(Movie movie, Set<int> seasons) {
    List<String> info = [ movie.year.toString(), movie.rated ];
    if (movie.isSeries) {
      info.add('${seasons.length} ${_('seasons', seasons.length)}');
    }

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: info.map((text) => Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.caption,
                  ),
                )).toList(),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              movie.plot,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Cast: ${movie.actors}',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ),

          movie.isSeries ? _buildSeriesHeader(seasons) : Container()
        ],
      ),
    );
  }

  Widget _buildSeriesHeader(Set<int> seasons) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<int>(
            value: currentSeason,
            underline: Container(height: 0),
            items: seasons.map((season) => DropdownMenuItem<int>(
                value: season,
                child: Text('${_('season')} $season'),
              )).toList(),
            onChanged: (int result) {
              setState(() { currentSeason = result; });
            },
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildEpisodesList(List<Episode> seasonEpisodes) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Episode episode = seasonEpisodes[index];

          return Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                      color: Colors.grey,
                      width: 150,
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            _getThumbnailImage(episode),
                            Container(
                              child: Container(
                                height: 3.0,
                                child: LinearProgressIndicator(
                                  backgroundColor: episode.watched > 0
                                    ? Colors.white10 : Colors.transparent,
                                  value: episode.watched / 100,
                                ),
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                            Center(
                              child: FloatingActionButton(
                                child: Icon(
                                  Icons.play_circle_filled,
                                  size: 32.0,
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                onPressed: () {
                                  _playOrCastEpisode(episode);
                                }
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${index + 1}. ${episode.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.body2
                        ),
                        Text(
                          episode.runtime ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  episode.plot ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption
                )
              ],
            ),
          );
        },
        childCount: seasonEpisodes.length,
      ),
    );
  }

  Widget _getThumbnailImage(Episode episode) {
    return CachedNetworkImage(
      imageUrl: 'http://192.168.1.2:3000/api/episodes/${episode.id}/thumbnail',
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container()
    );
  }
}
