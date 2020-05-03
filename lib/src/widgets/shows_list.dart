import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie_or_episode.dart';

class ShowsList extends StatelessWidget {
  final ScrollController controller = ScrollController();
  final String title;
  final List<MovieOrEpisode> items;
  final Function (MovieOrEpisode) onTap;

  ShowsList({
    this.title,
    this.items,
    this.onTap,
  });

  List<Widget> renderItems() {
    return items.map((show) {
      return InkWell(
        onTap: () => onTap(show),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          width: 120.0,
          child: AspectRatio(
            aspectRatio: 2/3,
            child: CachedNetworkImage(
              imageUrl: show.isMovie
                ? show.movie.poster
                : (show.episode.movie != null) ? show.episode.movie.poster : show.episode.poster,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(color: Colors.grey)
            )
          )
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return items.length > 0 ? Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subhead,
            )
          ),
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: renderItems(),
            ),
          )
        ],
      ),
    ) : Container();
  }
}
