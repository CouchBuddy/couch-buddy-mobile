import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/movie_details.dart';
import '../pages/watch.dart';

final homeRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Home();
  },
);

final detailsRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MovieDetails(int.parse(params['id'][0]));
  },
);

final videoRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Watch(Uri.decodeComponent(params['url'][0]));
  },
);

// var filterRouteHandler = Handler(
//   handlerFunc: (BuildContext context, Map<String, List<String>> params,
//       [dynamic object]) {
//     return Filter(
//       type: object['type'],
//     );
//   },
// );

class Routes {
  static String home = '/';
  static String detail = '/detail';
  static String filter = '/filter';
  static String video = '/watch';

  static void initRoutes() {
    router.define(home, handler: homeRouteHandler);

    router.define('$detail/:id', handler: detailsRouteHandler);

    // router.define(filter, handler: filterRouteHandler);

    router.define('$video/:url', handler: videoRouteHandler);

    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('Route not found!');
        return null;
      });
  }
}

final router = Router();
