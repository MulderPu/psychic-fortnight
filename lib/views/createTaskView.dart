import 'package:flutter/material.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({Key key}) : super(key: key);

  @override
  _CreateTaskViewState createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Task"),),
      body: Container(
        child: Text("Create Task"),
      ),
    );
  }
}
