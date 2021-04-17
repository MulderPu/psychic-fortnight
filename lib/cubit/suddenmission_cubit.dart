import 'package:bloc/bloc.dart';
import 'package:genshin_calculator/models/clickHistory.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'suddenmission_state.dart';

class SuddenmissionCubit extends Cubit<SuddenmissionState> {
  SuddenmissionCubit() : super(SuddenmissionInitial());

  void increment(count) {
    if (count <= 10) {
      emit(IncrementState(count));
    } else {}
  }

  void decrement(count) {
    if (count >= 0) {
      emit(DecrementState(count));
    }
  }

  Future<void> readSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ClickHistory latestHistory = ClickHistory();
    ClickHistory previousHistory = ClickHistory();

    var storedMissionCount = prefs.getInt("missionCount");
    if (storedMissionCount == null) {
      storedMissionCount = 0;
    }

    // see if new day
    var suddenDateTime = prefs.getString("suddenDateTime");
    var currentDateTime = DateTime.now();
    if (suddenDateTime == null) {
      // init datetime and do nothing, wait next day
      prefs.setString("suddenDateTime", currentDateTime.toString());
    } else {
      var storedDatetime = DateTime.parse(suddenDateTime);

      var formatStoreDatetime =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(storedDatetime));
      var formatCurrentDatetime =
          DateTime.parse(DateFormat('yyyy-MM-dd').format(currentDateTime));

      // compare date see if new day
      if (formatCurrentDatetime.difference(formatStoreDatetime).inDays > 0) {
        // reset mission count since is new day
        prefs.setInt("missionCount", 0);

        // reset click history since is new day
        ClickHistory resetLatestHistory = ClickHistory();
        prefs.setString("latestHistory", json.encode(resetLatestHistory));
        ClickHistory resetPreviousHistory = ClickHistory();
        prefs.setString("previousHistory", json.encode(resetPreviousHistory));

        // reset datetime
        prefs.setString("suddenDateTime", currentDateTime.toString());
        storedMissionCount = 0;
      }
    }

    latestHistory = prefs.getString("latestHistory") != null
        ? ClickHistory.fromJson(json.decode(prefs.getString("latestHistory")))
        : ClickHistory();
    previousHistory = prefs.getString("previousHistory") != null
        ? ClickHistory.fromJson(json.decode(prefs.getString("previousHistory")))
        : ClickHistory();

    print("stored mission count: $storedMissionCount");
    emit(LoadSessionState(storedMissionCount, latestHistory, previousHistory));
  }

  resetView() async {
    var resetCount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("missionCount", resetCount);

    // reset latest click history
    ClickHistory resetLatestHistory = ClickHistory();
    prefs.setString("latestHistory", json.encode(resetLatestHistory));

    // reset previous click history
    ClickHistory resetPreviousHistory = ClickHistory();
    prefs.setString("previousHistory", json.encode(resetPreviousHistory));

    emit(ResetState(resetCount, resetLatestHistory, resetPreviousHistory));
  }
}
