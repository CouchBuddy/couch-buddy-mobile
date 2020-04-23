import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../blocs/home_bloc.dart';
import '../models/movie.dart';
import '../models/shows_collection.dart';
import '../utils/localization.dart';
import '../utils/routes.dart';
import '../widgets/shows_list.dart';
import '../widgets/stream_builder_enhanced.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc bloc = HomeBloc();

  String _(String key, [int howMany = 1]) => AppLocalizations.of(context).translate(key, howMany);

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void goTo(String type) {
    router.navigateTo(
      context,
      '${Routes.filter}',
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  void goToDetail(Movie item) {
    router.navigateTo(
      context,
      '${Routes.detail}/${item.id}',
      transition: TransitionType.inFromRight,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  void showTrailer() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]).then((e) {
      router.navigateTo(
        context,
        Routes.video,
        transition: TransitionType.inFromBottom,
        transitionDuration: const Duration(milliseconds: 200),
      );
    });
  }

  List<Widget> renderMainGenres(Movie movie) {
    List<Widget> genres = List.from(movie.genre.split(',').map((g) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          g.trim(),
          style: Theme.of(context).textTheme.body2
        ),
      );
    }).toList());
    return genres;
  }

  Widget renderTitle(String tag, String text) {
    return Hero(
      tag: tag,
      child: FlatButton(
        onPressed: () => goTo(tag),
        child: Text(
          text,
          style: Theme.of(context).textTheme.body2
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildFeaturedMovieHeader(),
        _buildMoviesCollections(),
      ],
    );
  }

  Widget _buildFeaturedMovieHeader() {
    final Size screenSize = MediaQuery.of(context).size;

    bloc.fetchFeaturedMovie();

    return SliverAppBar(
      primary: true,
      expandedHeight: screenSize.height * 0.65,
      backgroundColor: Colors.black,
      title: Title(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            renderTitle('Series', _('series', 2)),
            renderTitle('Movies', _('movie', 2)),
          ],
        ),
      ),
      flexibleSpace: StreamBuilderEnhanced(
        stream: bloc.featuredMovie,
        builder: (Movie movie) {
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  movie.poster != null
                    ? Image.network(movie.poster, fit: BoxFit.cover)
                    : Container(color: Colors.grey,),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        stops: [0.1, 0.6, 1.0],
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                          Colors.black
                        ],
                      ),
                    ),
                    child: Container(
                      height: 40.0,
                      width: screenSize.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 3.0,
                                    color:
                                        Color.fromRGBO(185, 3, 12, 1.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.display2
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: renderMainGenres(movie),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton.icon(
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  icon: Icon(Icons.play_arrow),
                                  label: Text(_('play')),
                                  onPressed: showTrailer,
                                ),
                                FlatButton.icon(
                                  icon: Icon(Icons.info_outline),
                                  label: Text(_('info')),
                                  onPressed: () => goToDetail(movie),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }

  Widget _buildMoviesCollections() {
    bloc.fetchCollections();

    return StreamBuilderEnhanced(
      stream: bloc.collections,
      sliver: true,
      builder: (List<ShowsCollection> collections) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ShowsList(
              items: collections[index].shows,
              onTap: (show) {
                router.navigateTo(
                  context,
                  '${Routes.detail}/${show.isMovie ? show.movie.id : show.episode.movie.id}',
                  transition: TransitionType.inFromRight,
                  transitionDuration: const Duration(milliseconds: 200),
                );
              },
              title: collections[index].title,
            ),
            childCount: collections.length,
          ),
        );
      },
    );
  }
}
