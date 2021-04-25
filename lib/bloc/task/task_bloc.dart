import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genshin_calculator/db/taskDB/task_db.dart';
import 'package:genshin_calculator/db/taskDB/tasks.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskblocBloc extends Bloc<TaskblocEvent, TaskblocState> {
  TaskblocBloc() : super(TaskblocInitial());

  @override
  Stream<TaskblocState> mapEventToState(
    TaskblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetAllTasks) {
      yield* _mapGetAllTasksToState(event);
    }
  }

  Stream<TaskblocState> _mapGetAllTasksToState(GetAllTasks event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();
    yield FinishGetAllTasks(tasks: tasks);
  }
}
