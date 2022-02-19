import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus_db.dart';
import 'package:genshin_calculator/db/taskDB/task_db.dart';
import 'package:genshin_calculator/db/taskDB/tasks.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskblocBloc extends Bloc<TaskblocEvent, TaskblocState> {
  TaskblocBloc() : super(TaskblocInitial()) {
    on<TaskblocEvent>((event, emit) async {
      if (event is GetAllTasks) {
        await _mapGetAllTasksToState(event, emit);
      } else if (event is RefreshAllTask) {
        _mapRefreshAllTasksToState(event, emit);
      } else if (event is InitTasks) {
        _mapInitTasksToState(event, emit);
      } else if (event is UpdateTaskStatus) {
        _mapUpdateTaskStatus(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _mapUpdateTaskStatus(
      UpdateTaskStatus event, Emitter<TaskblocState> emit) async {
    final TaskStatusDB _taskStatusDB = TaskStatusDB.get();
    _taskStatusDB
        .updateStatusTask(event.taskID, event.statusIndex)
        .then((value) => {add(GetAllTasks())});
  }

  Future<void> _mapGetAllTasksToState(
      GetAllTasks event, Emitter<TaskblocState> emit) async {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();

    if (tasks.isEmpty) {
      // inject initial data
      add(InitTasks());
    }
    print(tasks);
    emit(FinishGetAllTasks(tasks: tasks));
  }

  Future<void> _mapInitTasksToState(
      InitTasks event, Emitter<TaskblocState> emit) async {
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
    Tasks task4 = Tasks.create(
      title: 'Daily Artifact Run',
      comment: 'Daily collect artifact on map.',
    );
    taskList.add(task4);

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

  Future<void> _mapRefreshAllTasksToState(
      RefreshAllTask event, Emitter<TaskblocState> emit) async {
    final TaskDB _taskDB = TaskDB.get();
    List<Tasks> tasks = await _taskDB.getTasks();
    emit(FinishGetAllTasks(tasks: tasks));
  }
}
