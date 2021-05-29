import 'package:genshin_calculator/db/taskDB/taskStatus.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus_db.dart';
import 'package:genshin_calculator/db/taskDB/tasks.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../app_db.dart';

class TaskDB {
  static final TaskDB _taskDb = TaskDB._internal(AppDatabase.get());
  TaskStatusDB _taskStatusDB;

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskDB._internal(this._appDatabase);

  //static TaskDB get taskDb => _taskDb;

  static TaskDB get() {
    return _taskDb;
  }

  Future<List<Tasks>> getTasks() async {
    var db = await _appDatabase.getDb();
    var whereClause = "";

    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*, ${TaskStatus.tblTaskStatus}.${TaskStatus.dbStatus}, ${TaskStatus.tblTaskStatus}.${TaskStatus.dbUpdated} as update_status '
        'FROM ${Tasks.tblTask} '
        'INNER JOIN ${TaskStatus.tblTaskStatus} ON ${Tasks.tblTask}.${Tasks.dbId} = ${TaskStatus.tblTaskStatus}.${TaskStatus.dbTaskId} $whereClause ORDER BY ${Tasks.tblTask}.${Tasks.dbId} ASC;');

    // * check result
    // * if next day, reset checkbox result
    bool refreshTask = false;
    for (var item in result) {
      var epoch = item['update_status'];
      if (epoch != null) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(epoch);
        // * checking datetime here
        var currentDateTime = DateTime.now();
        // ! simulate current date for testing
        // currentDateTime = currentDateTime.add(Duration(days: 1));

        var formatStoreDatetime =
            DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
        var formatCurrentDatetime =
            DateTime.parse(DateFormat('yyyy-MM-dd').format(currentDateTime));

        if (formatCurrentDatetime.difference(formatStoreDatetime).inDays > 0) {
          refreshTask = true;

          final TaskStatusDB _taskStatusDB = TaskStatusDB.get();
          await _taskStatusDB.updateStatusTask(
              item[Tasks.dbId], TaskStatusEnum.PENDING.index);
        }
      }
    }

    if (refreshTask) {
      result = await db.rawQuery(
          'SELECT ${Tasks.tblTask}.*, ${TaskStatus.tblTaskStatus}.${TaskStatus.dbStatus}, ${TaskStatus.tblTaskStatus}.${TaskStatus.dbUpdated} as update_status '
          'FROM ${Tasks.tblTask} '
          'INNER JOIN ${TaskStatus.tblTaskStatus} ON ${Tasks.tblTask}.${Tasks.dbId} = ${TaskStatus.tblTaskStatus}.${TaskStatus.dbTaskId} $whereClause ORDER BY ${Tasks.tblTask}.${Tasks.dbId} ASC;');
    }

    return _bindData(result);
  }

  List<Tasks> _bindData(List<Map<String, dynamic>> result) {
    // * print check result
    // print(result);
    List<Tasks> tasks = [];
    for (Map<String, dynamic> item in result) {
      var myTask = Tasks.fromMap(item);
      myTask.statusIndex = item[TaskStatus.dbStatus];
      // myTask.statusID = item["statusID"];
      // myTask.projectName = item[Project.dbName];
      // myTask.projectColor = item[Project.dbColorCode];
      // var labelComma = item["labelNames"];
      // if (labelComma != null) {
      //   myTask.labelList = labelComma.toString().split(",");
      // }
      tasks.add(myTask);
    }
    return tasks;
  }

  Future deleteTask(int taskID) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tasks.tblTask} SET ${Tasks.dbIsDeleted} = '${Tasks.deleted}' WHERE ${Tasks.dbId} = '$taskID'");
    });
  }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task) async {
    var db = await _appDatabase.getDb();
    bool status = false;
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks.dbComment})'
          ' VALUES(${task.id}, "${task.title}", "${task.comment}")');
      if (id > 0 && id != null) {
        var taskStatus = TaskStatus.create(
          taskId: id,
        );
        txn.rawInsert('INSERT OR REPLACE INTO '
            '${TaskStatus.tblTaskStatus}(${TaskStatus.dbId},${TaskStatus.dbTaskId},${TaskStatus.dbStatus},${TaskStatus.dbCreated},${TaskStatus.dbUpdated})'
            ' VALUES(null, ${taskStatus.taskId}, ${taskStatus.status}, ${taskStatus.created}, ${taskStatus.updated})');
      }
      status = true;
    });
    return status;
  }
}
