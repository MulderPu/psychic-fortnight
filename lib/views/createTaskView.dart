import 'package:flutter/material.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({Key key}) : super(key: key);

  @override
  _CreateTaskViewState createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("Create Task"),
          ),
          Checkbox(
            value: _value,
            onChanged: (value) {
              print("onchange $value");
              setState(() {
                _value = !_value;
              });
            },
          ),
        ],
      ),
    );
  }
}
