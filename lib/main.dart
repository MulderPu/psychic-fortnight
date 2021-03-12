import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/routes.dart';
import 'package:genshin_calculator/views/homeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,

      home: HomeView(
        title: "Genshin Calculator",
      ),
    );
  }
}
