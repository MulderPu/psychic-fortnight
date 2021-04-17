part of 'suddenmission_cubit.dart';

abstract class SuddenmissionState {}

class SuddenmissionInitial extends SuddenmissionState {}

class IncrementState extends SuddenmissionState {
  int count;

  IncrementState(this.count);

  @override
  String toString() {
    // TODO: implement toString
    return "Increment ...";
  }
}

class DecrementState extends SuddenmissionState {
  int count;

  DecrementState(this.count);

  @override
  String toString() {
    return "Decrement ...";
  }
}

class LoadSessionState extends SuddenmissionState {
  int count;
  ClickHistory latestHistory;
  ClickHistory previousHistory;

  LoadSessionState(this.count, this.latestHistory, this.previousHistory);

  @override
  String toString() {
    return "Load session ...";
  }
}

class ResetState extends SuddenmissionState {
  int count;
  ClickHistory latestHistory;
  ClickHistory previousHistory;

  ResetState(this.count, this.latestHistory, this.previousHistory);

  @override
  String toString() {
    return "Reset ..";
  }
}
