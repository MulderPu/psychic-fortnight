part of 'task_bloc.dart';

@immutable
abstract class TaskblocState {}

class TaskblocInitial extends TaskblocState {}

class FinishGetAllTasks extends TaskblocState {
  final List<Tasks>? tasks;

  FinishGetAllTasks({this.tasks});

  @override
  String toString() {
    return "Finish getting all tasks.";
  }
}
