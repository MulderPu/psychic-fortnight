part of 'task_bloc.dart';

@immutable
abstract class TaskblocEvent {}

class GetAllTasks extends TaskblocEvent {}

class RefreshAllTask extends TaskblocEvent {}
