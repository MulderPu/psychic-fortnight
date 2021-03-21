import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  TaskView({Key key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Tasks"),
      ),
      body: Container(
         child: Text("Task View"),
      ),
    );
  }
}