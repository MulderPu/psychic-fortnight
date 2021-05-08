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
    } else if (event is RefreshAllTask) {
      yield* _mapRefreshAllTasksToState(event);
    } else if (event is InitTasks) {
      yield* _mapInitTasksToState(event);
    }
  }

  Stream<TaskblocState> _mapGetAllTasksToState(GetAllTasks event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();

    if (tasks.isEmpty) {
      // inject initial data
      add(InitTasks());
    }
    yield FinishGetAllTasks(tasks: tasks);
  }

  Stream<TaskblocState> _mapInitTasksToState(InitTasks event) async* {
    final TaskDB _taskDB = TaskDB.get();
    var task = Tasks.create(
      title: 'Daily Sudden Event',
      comment: 'Do max 10 times to gain friendship points.',
    );
    var result = await _taskDB.updateTask(task);
    if (result) {
      add(GetAllTasks());
    }
  }

  Stream<TaskblocState> _mapRefreshAllTasksToState(
      RefreshAllTask event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();
    yield FinishGetAllTasks(tasks: tasks);
  }
}
