import 'package:meta/meta.dart';

class Tasks {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbCreated = "created";
  static final dbUpdated = "updated";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbIsDeleted = "isDeleted";

  // const
  static final active = 0;
  static final deleted = 1;

  String title, comment;
  int id, created, updated, isDeleted, statusIndex;
  // TaskStatus tasksStatus;
  // List<String> labelList = List<String>();

  Tasks.create(
      {@required this.title,
      this.comment = "",
      this.created = -1,
      this.updated = -1}) {
    if (this.created == -1) {
      this.created = DateTime.now().millisecondsSinceEpoch;
      this.updated = DateTime.now().millisecondsSinceEpoch;
    }
    this.isDeleted = active;
    // this.tasksStatus = TaskStatus.PENDING;
  }

  bool operator ==(o) => o is Tasks && o.id == id;

  Tasks.update({
    @required this.id,
    @required this.title,
    this.created,
    this.updated = -1,
    this.comment = "",
    // this.tasksStatus = TaskStatus.PENDING,
  }) {
    if (this.updated == -1) {
      this.updated = DateTime.now().millisecondsSinceEpoch;
    }
    // this.isDeleted = active;
  }

  Tasks.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          title: map[dbTitle],
          created: map[dbCreated],
          updated: map[dbUpdated],
          comment: map[dbComment],

          // dueDate: map[dbDueDate],
          // tasksStatus: TaskStatus.values[map[dbStatus]],
        );
}

// enum TaskStatus {
//   ACTIVE,
//   COMPLETE,
// }
