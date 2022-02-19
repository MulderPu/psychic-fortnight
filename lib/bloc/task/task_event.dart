part of 'task_bloc.dart';

@immutable
abstract class TaskblocEvent {}

class GetAllTasks extends TaskblocEvent {}

class RefreshAllTask extends TaskblocEvent {}

class InitTasks extends TaskblocEvent {}

class UpdateTaskStatus extends TaskblocEvent {
  final int taskID;
  final int statusIndex;

  UpdateTaskStatus({required this.taskID, required this.statusIndex});

  @override
  String toString() {
    return "Update task status.";
  }
}
