import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        prefs.setInt("missionCount", 0);
        prefs.setString("suddenDateTime", currentDateTime.toString());
        storedMissionCount = 0;
      }
    }

    print("stored mission count: $storedMissionCount");
    emit(LoadSessionState(storedMissionCount));
  }

  resetView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("missionCount", 0);
    emit(ResetState(0));
  }
}
