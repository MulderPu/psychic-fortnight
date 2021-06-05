import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:genshin_calculator/utils/keys.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'widgets/gradientAppBar.dart';

class CreateTaskView extends StatefulWidget {
  final PersistentTabController controller;
  final VoidCallback callback;

  CreateTaskView({Key key, this.controller, this.callback}) : super(key: key);

  @override
  _CreateTaskViewState createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  // Create a global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: "Create New Task",
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextFormField(
                    key: Key(CreateTaskPageKeys.TITLE_FIELD),
                    controller: titleController,
                    cursorColor: Colors.purple,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Title:',
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: FONT_LABEL.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.purple, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: ''),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title field cannot be empty.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextFormField(
                    key: Key(ResinTimePageKeys.RESIN_NEEDED_FIELD),
                    controller: commentController,
                    cursorColor: Colors.purple,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Comment:',
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: FONT_LABEL.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.purple, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: ''),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Comment needed field cannot be empty.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        key: Key(CreateTaskPageKeys.CREATE_BUTTON),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: FONT_BUTTON.sp),
                          onPrimary: Colors.white,
                          primary: lightPurple,
                          onSurface: Colors.grey,
                          minimumSize: Size(double.infinity, 50),
                          elevation: 10,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          // dismiss keyboard
                          FocusScope.of(context).unfocus();
                          widget.controller.jumpToTab(0);
                          widget.callback();

                          if (_formKey.currentState.validate()) {
                            print("create task");
                          }
                        },
                        child: Text('Create')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
