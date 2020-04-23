import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import './src/pages/tabs_layout.dart';
import './src/utils/localization.dart';
import './src/utils/routes.dart';
import './src/utils/theme/color.dart';

class CouchBuddy extends StatelessWidget {
  CouchBuddy({Key key}) : super(key: key) {
    Routes.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CouchBuddy',
      theme: ThemeData.dark().copyWith(
        accentColor: Palette.netflixRed,
        textSelectionHandleColor: Palette.netflixRed
      ),
      onGenerateRoute: router.generator,
      localizationsDelegates: [
        AppLocalizationsDelegate(context),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      home: TabsLayout(),
    );
  }
}
