import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../blocs/explore_bloc.dart';
import '../models/movie.dart';
import '../utils/routes.dart';

class Explore extends StatefulWidget {
  Explore({
    Key key,
  }) : super(key: key);

  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends State<Explore> {
  ExploreBloc bloc;

  final TextEditingController _filter = new TextEditingController();
  final PublishSubject<String> _textUpdates = PublishSubject<String>();

  @override
  void initState() {
    bloc = ExploreBloc();

    _filter.addListener(() => _textUpdates.add(_filter.text));

    _textUpdates
      .debounceTime(Duration(milliseconds: 350))
      .listen((String val) {
        bloc.searchMovies(val);
      });

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _textUpdates.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextField(
              autofocus: true,
              controller: _filter,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        StreamBuilder(
          stream: bloc.searchResults,
          initialData: List<Movie>(),
          builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: GridView.count(
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2/3,
                  crossAxisCount: 3,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  children: snapshot.data.map((item) =>
                    Ink.image(
                      image: NetworkImage(item.poster),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          router.navigateTo(
                            context,
                            '${Routes.detail}/${item.id}',
                            transition: TransitionType.inFromBottom,
                            transitionDuration: const Duration(milliseconds: 200),
                          );
                        },
                      ),
                    )
                  ).toList()
                )
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: Colors.white),
                )
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(219, 0, 0, 1.0)),
              )
            );
          }
        )
      ],
    );
  }
}
