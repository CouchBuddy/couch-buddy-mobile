import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_cast_button/bloc_media_route.dart';
import 'package:flutter_google_cast_button/cast_button_widget.dart';

import 'home.dart';
import 'search.dart';
import 'explore.dart';
import 'downloads.dart';
import 'settings.dart';
import '../utils/localization.dart';

class TabsLayout extends StatefulWidget {
  TabsLayout({Key key}) : super(key: key);

  @override
  TabsLayoutState createState() => TabsLayoutState();
}

class TabsLayoutState extends State<TabsLayout> with SingleTickerProviderStateMixin {
  TabController controller;
  MediaRouteBloc _mediaRouteBloc;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    controller = TabController(length: 5, initialIndex: 0, vsync: this);
    _mediaRouteBloc = MediaRouteBloc();
  }

  @override
  void dispose() {
    _mediaRouteBloc.close();
    super.dispose();
  }

  String _(String key, [int howMany = 1]) => AppLocalizations.of(context).translate(key, howMany);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: TabBar(
        labelStyle: TextStyle(fontSize: 10.0),
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).accentColor, width: 3.0)
          )
        ),
        controller: controller,
        tabs: <Widget>[
          Tab(text: _('home'), icon: Icon(Icons.weekend)),
          Tab(text: _('search'), icon: Icon(Icons.search)),
          Tab(text: _('explore'), icon: Icon(Icons.explore)),
          Tab(text: _('download', 2), icon: Icon(Icons.file_download)),
          Tab(text: _('setting', 2), icon: Icon(Icons.settings)),
        ],
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
          Search(),
          Explore(),
          Downloads(),
          Settings(),
        ],
      ),
      floatingActionButton: CastButtonWidget(
        bloc: _mediaRouteBloc,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        tintColor: Colors.white,
      ),
    );
  }
}
