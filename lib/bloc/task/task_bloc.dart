import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus_db.dart';
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
    } else if (event is UpdateTaskStatus) {
      yield* _mapUpdateTaskStatus(event);
    }
  }

  Stream<TaskblocState> _mapUpdateTaskStatus(UpdateTaskStatus event) async* {
    final TaskStatusDB _taskStatusDB = TaskStatusDB.get();
    _taskStatusDB
        .updateStatusTask(event.taskID, event.statusIndex)
        .then((value) => {add(GetAllTasks())});
  }

  Stream<TaskblocState> _mapGetAllTasksToState(GetAllTasks event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();

    if (tasks.isEmpty) {
      print(tasks);
      // inject initial data
      add(InitTasks());
    }
    yield FinishGetAllTasks(tasks: tasks);
  }

  Stream<TaskblocState> _mapInitTasksToState(InitTasks event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> taskList = [];
    // initial tasks
    Tasks task = Tasks.create(
      title: 'Daily Sudden Event',
      comment: 'Do max 10 times to gain friendship points.',
    );
    taskList.add(task);
    Tasks task2 = Tasks.create(
      title: 'Daily Quest',
      comment: 'Do all 4 and get primo.',
    );
    taskList.add(task2);
    Tasks task3 = Tasks.create(
      title: 'Daily Web Check-in',
      comment: 'Daily checking on website to get reward.',
    );
    taskList.add(task3);

    // array inject
    int count = 0;
    taskList.forEach((element) async {
      var result = await _taskDB.updateTask(element);
      if (result) {
        count = count + 1;
        if (count == taskList.length) {
          add(GetAllTasks());
        }
      }
    });
  }

  Stream<TaskblocState> _mapRefreshAllTasksToState(
      RefreshAllTask event) async* {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();
    yield FinishGetAllTasks(tasks: tasks);
  }
}
