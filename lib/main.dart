import 'package:flutter/material.dart';
import 'package:genshin_calculator/views/homeView.dart';

import 'utils/blocObserver.dart';

void main() {
  FlutterBlocObserver observer = FlutterBlocObserver();
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
      home: HomeView(
        title: "Genshin Calculator",
      ),
    );
  }
}
