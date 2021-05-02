import 'package:genshin_calculator/db/taskDB/taskStatus.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus_db.dart';
import 'package:genshin_calculator/db/taskDB/tasks.dart';
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

    // if (taskStatus != null) {
    //   var taskWhereClause =
    //       "${Tasks.tblTask}.${Tasks.dbStatus} = ${taskStatus.index}";
    //   whereClause = whereClause.isEmpty
    //       ? "WHERE $taskWhereClause"
    //       : "$whereClause AND $taskWhereClause";
    // }

    var result = await db.rawQuery('SELECT ${Tasks.tblTask}.* '
        'FROM ${Tasks.tblTask} '
        // 'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        '$whereClause ORDER BY ${Tasks.tblTask}.${Tasks.dbId} ASC;');

    return _bindData(result);
  }

  List<Tasks> _bindData(List<Map<String, dynamic>> result) {
    List<Tasks> tasks = [];
    for (Map<String, dynamic> item in result) {
      var myTask = Tasks.fromMap(item);
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

  // Future<List<Tasks>> getTasksByProject(int projectId,
  //     {TaskStatus status}) async {
  //   var db = await _appDatabase.getDb();
  //   String whereStatus = status != null
  //       ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${status.index}"
  //       : "";
  //   var result = await db.rawQuery(
  //       'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
  //       'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
  //       'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
  //       'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=$projectId $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

  //   return _bindData(result);
  // }

  // Future<List<Tasks>> getTasksByLabel(String labelName,
  //     {TaskStatus status}) async {
  //   var db = await _appDatabase.getDb();
  //   String whereStatus = status != null
  //       ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${TaskStatus.PENDING.index}"
  //       : "";
  //   var result = await db.rawQuery(
  //       'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
  //       'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
  //       'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project.dbId} $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

  //   return _bindData(result);
  // }

  Future deleteTask(int taskID) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tasks.tblTask} SET ${Tasks.dbIsDeleted} = '${Tasks.deleted}' WHERE ${Tasks.dbId} = '$taskID'");
    });
  }

  // Future updateTaskStatus(int taskID, TaskStatus status) async {
  //   var db = await _appDatabase.getDb();
  //   await db.transaction((Transaction txn) async {
  //     await txn.rawQuery(
  //         "UPDATE ${Tasks.tblTask} SET ${Tasks.dbStatus} = '${status.index}' WHERE ${Tasks.dbId} = '$taskID'");
  //   });
  // }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks.dbComment})'
          ' VALUES(${task.id}, "${task.title}", "${task.comment}")');
      if (id > 0) {
        var task = TaskStatus.create(
          taskId: id,
        );
        _taskStatusDB.createTaskStatus(task);
      }
    });
  }
}
