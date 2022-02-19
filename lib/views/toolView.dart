import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:genshin_calculator/views/resinTimeView.dart';
import 'package:genshin_calculator/views/suddenMissionView.dart';
import 'package:genshin_calculator/views/widgets/gradientAppBar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class ToolView extends StatefulWidget {
  const ToolView({Key? key}) : super(key: key);

  @override
  _ToolViewState createState() => _ToolViewState();
}

class _ToolViewState extends State<ToolView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: "Tools",
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const ResinTimeView(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                    onPrimary: Colors.white,
                    primary: lightPurple,
                    onSurface: Colors.grey,
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text("Resin Time")),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: const SuddenMissionView(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                    onPrimary: Colors.white,
                    primary: lightPurple,
                    onSurface: Colors.grey,
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text("Sudden Mission")),
            ),
          ],
        ),
      ),
    );
  }
}
