import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/views/customShape/circle.dart';

class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  const GradientAppBar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        AppBar(
          // automaticallyImplyLeading: false, // hides default back button
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  purple,
                  lightPurple,
                ]),
          )),
          title: Text(title),
          centerTitle: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomPaint(
              painter: CircleOne(),
            ),
            CustomPaint(
              painter: CircleTwo(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
