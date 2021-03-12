import 'package:flutter/material.dart';
import 'package:genshin_calculator/views/homeView.dart';
import 'package:genshin_calculator/views/resinTimeView.dart';

class RouteGenerator {
  static const ROUTE_RESIN = "/resin";
  // static const ROUTE_SEARCH = "/search";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_RESIN:
        final page = ResinTimeView();
        return MaterialPageRoute(builder: (context) => page);

      // case ROUTE_SEARCH:
      //   final page = SearchScreen();
      //   return MaterialPageRoute(builder: (context) => page);

      default:
        return MaterialPageRoute(builder: (context) => HomeView());
    }
  }
}
