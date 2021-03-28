import 'package:flutter/material.dart';
import 'package:genshin_calculator/views/homeView.dart';
import 'package:sizer/sizer.dart';

import 'utils/blocObserver.dart';

void main() {
  FlutterBlocObserver observer = FlutterBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              title: 'Home',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: HomeView(
                title: "Genshin Calculator",
              ),
            );
          },
        );
      },
    );
  }
}
