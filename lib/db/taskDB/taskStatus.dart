import 'package:flutter/material.dart';

class TaskStatus {
  static const tblTaskStatus = "TaskStatus";
  static const dbId = "id";
  static const dbCreated = "created";
  static const dbUpdated = "updated";
  static const dbTaskId = "task_id";
  static const dbStatus = "status";

  int? id, created, updated, taskId, status;

  TaskStatus.create(
      {@required this.taskId, this.created = -1, this.updated = -1}) {
    if (this.created == -1) {
      this.created = DateTime.now().millisecondsSinceEpoch;
      this.updated = DateTime.now().millisecondsSinceEpoch;
    }
    this.status = TaskStatusEnum.PENDING.index;
  }

  bool operator ==(o) => o is TaskStatus && o.id == id;

  TaskStatus.update({
    @required this.taskId,
    this.created,
    this.updated = -1,
    this.status,
  }) {
    if (this.updated == -1) {
      this.updated = DateTime.now().millisecondsSinceEpoch;
    }
  }

  TaskStatus.fromMap(Map<String, dynamic> map)
      : this.update(
          taskId: map[dbTaskId],
          created: map[dbCreated],
          updated: map[dbUpdated],
          status: map[dbStatus],
        );
}

enum TaskStatusEnum {
  PENDING,
  COMPLETE,
}
