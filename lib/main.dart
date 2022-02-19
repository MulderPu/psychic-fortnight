import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genshin_calculator/views/homeView.dart';
import 'package:sizer/sizer.dart';

import 'utils/blocObserver.dart';

void main() {
  // FlutterBlocObserver observer = FlutterBlocObserver();
  // runApp(MyApp());
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: FlutterBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Home',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeView(
            title: "Genshin Calculator",
          ),
        );
      },
    );
  }
}
