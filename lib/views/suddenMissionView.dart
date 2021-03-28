import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genshin_calculator/cubit/suddenmission_cubit.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SuddenMissionView extends StatefulWidget {
  SuddenMissionView({Key key}) : super(key: key);

  @override
  _SuddenMissionViewState createState() => _SuddenMissionViewState();
}

class _SuddenMissionViewState extends State<SuddenMissionView> {
  int suddenMissionCount;
  bool resetUi;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuddenmissionCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sudden Mission"),
        ),
        body: BlocConsumer<SuddenmissionCubit, SuddenmissionState>(
          listener: (context, state) {
            print("listen state : $state");
            if (state is IncrementState) {
              suddenMissionCount = state.count;
              saveSuddenMissionCount(state.count);
            }

            if (state is DecrementState) {
              suddenMissionCount = state.count;
              saveSuddenMissionCount(state.count);
            }

            if (state is LoadSessionState) {
              suddenMissionCount = state.count;
            }

            if (state is ResetState) {
              suddenMissionCount = state.count;
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
                      backgroundColor: Colors.purple,
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
                        fontSize: FONT_LARGE.sp,
                      ),
                    ),
                    suddenMissionCount != 10
                        ? FloatingActionButton(
                            heroTag: 'fas',
                            backgroundColor: Colors.purple,
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
                      ? const EdgeInsets.all(20.0)
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
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        // RESET
                        context.read<SuddenmissionCubit>().resetView();
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                        onPrimary: Colors.white,
                        primary: Colors.purple,
                        onSurface: Colors.grey,
                        minimumSize: Size(double.infinity, 50),
                        elevation: 10,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text("Reset Count")),
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
}
