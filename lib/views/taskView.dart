import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genshin_calculator/bloc/task/task_bloc.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';

import 'customShape/circle.dart';

class TaskView extends StatefulWidget {
  TaskView({Key key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskblocBloc taskBloc = TaskblocBloc();
  bool _value = false;

  @override
  void initState() {
    super.initState();
    taskBloc.add(GetAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    final double expandedHeight = 200.0;

    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: expandedHeight),
              pinned: true,
            ),
            SliverPadding(
                padding: EdgeInsets.only(top: expandedHeight / 1.5),
                sliver: BlocBuilder<TaskblocBloc, TaskblocState>(
                  cubit: taskBloc,
                  builder: (context, state) {
                    if (state is FinishGetAllTasks) {
                      return SliverFillRemaining(
                        child: ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              // access element from list using index
                              // you can create and return a widget of your choice
                              return CheckboxListTile(
                                title: Text(
                                  state.tasks[index].title,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                onChanged: (bool value) {
                                  print(" i ma here");
                                  print("value $value");
                                  setState(() {
                                    _value = value;
                                    print("_value $_value");
                                  });
                                },
                                value: _value,
                                secondary: const Icon(Icons.hourglass_empty),
                              );
                            }),
                      );

                      // return SliverList(
                      //   delegate: SliverChildBuilderDelegate(
                      //     (BuildContext context, int index) {
                      //       return CheckboxListTile(
                      //         title: Text(
                      //           state.tasks[index].title,
                      //           style: TextStyle(
                      //               color: Colors.grey,
                      //               decoration: TextDecoration.lineThrough),
                      //         ),
                      //         onChanged: (bool value) {
                      //           // setState(() {
                      //             _value = !value;
                      //           // });
                      //         },
                      //         value: _value,
                      //         secondary: const Icon(Icons.hourglass_empty),
                      //       );
                      //       // return Container(
                      //       //   margin: EdgeInsets.only(
                      //       //     left: PADDING_LARGE,
                      //       //     right: PADDING_LARGE,
                      //       //     top: 0,
                      //       //     bottom: PADDING_LARGE,
                      //       //   ),
                      //       //   padding: EdgeInsets.all(PADDING_MEDIUM),
                      //       //   child: Row(
                      //       //     mainAxisAlignment:
                      //       //         MainAxisAlignment.spaceEvenly,
                      //       //     children: <Widget>[
                      //       //       // StatefulBuilder(builder:
                      //       //       //     (BuildContext context,
                      //       //       //         StateSetter setState) {
                      //       //       //   return Center(
                      //       //       //     child: CheckboxListTile(
                      //       //       //       title: const Text('Animate Slowly'),
                      //       //       //       value: _value,
                      //       //       //       onChanged: (bool value) {
                      //       //       //         setState(() {
                      //       //       //           _value = !value;
                      //       //       //         });
                      //       //       //       },
                      //       //       //       secondary:
                      //       //       //           const Icon(Icons.hourglass_empty),
                      //       //       //     ),
                      //       //       //   );
                      //       //       // }),
                      //       //       Text(
                      //       //         '07.00 AM',
                      //       //         style: TextStyle(color: Colors.grey),
                      //       //       ),
                      //       //       Container(
                      //       //         width: 180,
                      //       //         child: Text(
                      //       //           state.tasks[index].title,
                      //       //           style: TextStyle(
                      //       //               color: Colors.grey,
                      //       //               decoration:
                      //       //                   TextDecoration.lineThrough),
                      //       //         ),
                      //       //       ),
                      //       //       Icon(Icons.notifications),
                      //       //     ],
                      //       //   ),
                      //       //   decoration: BoxDecoration(
                      //       //     gradient: LinearGradient(
                      //       //       stops: [0.015, 0.015],
                      //       //       colors: [Colors.redAccent, Colors.white],
                      //       //     ),
                      //       //     borderRadius: BorderRadius.all(
                      //       //       Radius.circular(5.0),
                      //       //     ),
                      //       //     boxShadow: [
                      //       //       BoxShadow(
                      //       //         color: Colors.grey,
                      //       //         blurRadius: 8.0,
                      //       //       ),
                      //       //     ],
                      //       //   ),
                      //       // );
                      //     },
                      //     childCount: state.tasks.length,
                      //   ),
                      // );
                    }
                    return SliverFillRemaining();
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false, // hides default back button
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  purple,
                  lightPurple,
                ]),
          )),
          title: Text("Task Reminder",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("Search pressed");
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomPaint(
              painter: CircleOne(),
            ),
            CustomPaint(
              painter: CircleTwo(),
            ),
          ],
        ),

        // Center(
        //   child: Opacity(
        //     opacity: shrinkOffset / expandedHeight,
        //     child: Text(
        //       "MySliverAppBar",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w700,
        //         fontSize: 23,
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(PADDING_MEDIUM),
                  child: Image(image: AssetImage("assets/images/anemo.png")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
