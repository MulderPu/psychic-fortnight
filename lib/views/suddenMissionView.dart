import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:genshin_calculator/cubit/suddenmission_cubit.dart';
import 'package:genshin_calculator/models/clickHistory.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:genshin_calculator/views/widgets/gradientAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class SuddenMissionView extends StatefulWidget {
  SuddenMissionView({Key key}) : super(key: key);

  @override
  _SuddenMissionViewState createState() => _SuddenMissionViewState();
}

class _SuddenMissionViewState extends State<SuddenMissionView> {
  int suddenMissionCount;
  bool resetUi;
  ClickHistory latestHistory = ClickHistory();
  ClickHistory previousHistory = ClickHistory();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuddenmissionCubit(),
      child: Scaffold(
        appBar: GradientAppBar(
          title: "Sudden Event",
        ),
        body: BlocConsumer<SuddenmissionCubit, SuddenmissionState>(
          listener: (context, state) {
            print("listen state : $state");
            if (state is IncrementState) {
              suddenMissionCount = state.count;
              saveSuddenMissionCount(state.count);

              if (latestHistory.title != "") {
                previousHistory.title = latestHistory.title;
              }

              if (latestHistory.datetime != "") {
                previousHistory.datetime = latestHistory.datetime;
              }

              // add new log
              latestHistory.title = "Increment by 1";
              latestHistory.datetime = DateFormat('yyyy-MM-dd kk:mm:ss')
                  .format(DateTime.now())
                  .toString();

              saveClickHistory("latestHistory", latestHistory);
              saveClickHistory("previousHistory", previousHistory);
            }

            if (state is DecrementState) {
              suddenMissionCount = state.count;
              saveSuddenMissionCount(state.count);

              if (latestHistory.title != "") {
                previousHistory.title = latestHistory.title;
              }

              if (latestHistory.datetime != "") {
                previousHistory.datetime = latestHistory.datetime;
              }

              // add new log
              latestHistory.title = "Decrement by 1";
              latestHistory.datetime = DateFormat('yyyy-MM-dd kk:mm:ss')
                  .format(DateTime.now())
                  .toString();

              saveClickHistory("latestHistory", latestHistory);
              saveClickHistory("previousHistory", previousHistory);
            }

            if (state is LoadSessionState) {
              suddenMissionCount = state.count;
              latestHistory = state.latestHistory;
              previousHistory = state.previousHistory;
            }

            if (state is ResetState) {
              suddenMissionCount = state.count;
              latestHistory = state.latestHistory;
              previousHistory = state.previousHistory;

              showToast("Mission count is reset.", context: context);
            }
          },
          builder: (context, state) {
            print("current state : $state");
            if (state is SuddenmissionInitial) {
              suddenMissionCount = 0;
              context.read<SuddenmissionCubit>().readSession();

              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: 'da',
                      backgroundColor: lightPurple,
                      onPressed: () => context
                          .read<SuddenmissionCubit>()
                          .decrement(suddenMissionCount - 1),
                      child: Icon(Icons.remove),
                    ),
                    Text(
                      suddenMissionCount == null
                          ? 0
                          : suddenMissionCount.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: FONT_MEDIUM.sp,
                      ),
                    ),
                    suddenMissionCount != 10
                        ? FloatingActionButton(
                            heroTag: 'fas',
                            backgroundColor: lightPurple,
                            onPressed: () {
                              context
                                  .read<SuddenmissionCubit>()
                                  .increment(suddenMissionCount + 1);
                            },
                            child: Icon(Icons.add),
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            focusElevation: 0,
                            hoverElevation: 0,
                            backgroundColor: Colors.grey,
                            onPressed: () => null,
                            child: Icon(Icons.add),
                          ),
                  ],
                ),
                Padding(
                  padding: suddenMissionCount == 10
                      ? const EdgeInsets.only(
                          left: PADDING_MEDIUM,
                          right: PADDING_MEDIUM,
                          top: PADDING_MEDIUM,
                        )
                      : const EdgeInsets.all(0.0),
                  child: Text(
                    suddenMissionCount == 10
                        ? "Sudden Mission has been done! Please come back tomorrow."
                        : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: suddenMissionCount == 10
                          ? Colors.green
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: FONT_MEDIUM.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING_LARGE),
                  child: ElevatedButton(
                      onPressed: () async {
                        // RESET
                        context.read<SuddenmissionCubit>().resetView();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                        onPrimary: Colors.white,
                        primary: lightPurple,
                        onSurface: Colors.grey,
                        minimumSize: Size(double.infinity, 50),
                        elevation: 10,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text("Reset Count")),
                ),
                // log here
                Text(
                  "Click's History",
                  style: TextStyle(
                      fontSize: FONT_LABEL.sp, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: PADDING_MEDIUM, right: PADDING_MEDIUM),
                  child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            reverseDuration: const Duration(milliseconds: 100),
                            child: Text(
                              latestHistory.title ?? "",
                              key: ValueKey<String>(latestHistory.datetime),
                            ),
                          ),
                        ),
                        trailing: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          reverseDuration: const Duration(milliseconds: 100),
                          child: Text(
                            latestHistory.datetime ?? "",
                            key: ValueKey<String>(latestHistory.datetime),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: PADDING_MEDIUM, right: PADDING_MEDIUM),
                  child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 100),
                            child: Text(
                              previousHistory.title ?? "",
                              key: ValueKey<String>(previousHistory.datetime),
                            ),
                          ),
                        ),
                        trailing: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 100),
                          child: Text(
                            previousHistory.datetime ?? "",
                            key: ValueKey<String>(previousHistory.datetime),
                          ),
                        ),
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  saveSuddenMissionCount(count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("missionCount", count);
  }

  saveClickHistory(key, ClickHistory data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(data));
  }
}
