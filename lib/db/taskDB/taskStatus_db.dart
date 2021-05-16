import 'package:genshin_calculator/db/taskDB/taskStatus.dart';
import 'package:sqflite/sqflite.dart';

import '../app_db.dart';

class TaskStatusDB {
  static final TaskStatusDB _taskStatusDB =
      TaskStatusDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskStatusDB._internal(this._appDatabase);

  //static TaskStatusDB get TaskStatusDB => _TaskStatusDB;

  static TaskStatusDB get() {
    return _taskStatusDB;
  }

  Future<List<TaskStatus>> getTaskStatus() async {
    var db = await _appDatabase.getDb();
    var whereClause = "";

    var result = await db.rawQuery('SELECT ${TaskStatus.tblTaskStatus}.* '
        'FROM ${TaskStatus.tblTaskStatus} '
        '$whereClause ORDER BY ${TaskStatus.tblTaskStatus}.${TaskStatus.dbId} ASC;');

    return _bindData(result);
  }

  List<TaskStatus> _bindData(List<Map<String, dynamic>> result) {
    List<TaskStatus> tasks = [];
    for (Map<String, dynamic> item in result) {
      var myTask = TaskStatus.fromMap(item);
      tasks.add(myTask);
    }
    return tasks;
  }

  Future updateStatusTask(int taskID, int statusIndex) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${TaskStatus.tblTaskStatus} SET ${TaskStatus.dbStatus} = '$statusIndex' WHERE ${TaskStatus.dbTaskId} = '$taskID'");
    });
  }

  Future createTaskStatus(TaskStatus taskStatus) async {
    print(taskStatus);
    // var db = await _appDatabase.getDb();
    // await db.transaction((Transaction txn) async {
    //   await txn.rawInsert('INSERT OR REPLACE INTO '
    //       '${TaskStatus.tblTaskStatus}(${TaskStatus.dbId},${TaskStatus.dbTaskId},${TaskStatus.dbStatus})'
    //       ' VALUES(null, ${taskStatus.taskId}, ${taskStatus.status})');
    // });
  }
}
