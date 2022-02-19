import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genshin_calculator/bloc/task/task_bloc.dart';
import 'package:genshin_calculator/db/taskDB/taskStatus.dart';
import 'package:genshin_calculator/utils/colors.dart';
import 'package:genshin_calculator/utils/constant.dart';
import 'package:sizer/sizer.dart';

import 'customShape/circle.dart';

class TaskView extends StatefulWidget {
  final bool isRefresh;

  const TaskView({Key? key, required this.isRefresh}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskblocBloc taskBloc = TaskblocBloc();

  @override
  void initState() {
    super.initState();

    print('get all task');
    taskBloc.add(GetAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 200.0;

    if (widget.isRefresh) {
      taskBloc.add(GetAllTasks());
    }

    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: expandedHeight),
              pinned: true,
            ),
            SliverPadding(
                padding: const EdgeInsets.only(top: expandedHeight / 1.5),
                sliver: BlocBuilder<TaskblocBloc, TaskblocState>(
                  bloc: taskBloc,
                  builder: (context, state) {
                    if (state is FinishGetAllTasks) {
                      return SliverFillRemaining(
                        child: ListView.builder(
                            itemCount: state.tasks?.length,
                            itemBuilder: (BuildContext context, int index) {
                              // access element from list using index
                              // you can create and return a widget of your choice
                              return Container(
                                margin: const EdgeInsets.only(
                                  left: PADDING_LARGE,
                                  right: PADDING_LARGE,
                                  top: 0,
                                  bottom: PADDING_LARGE,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    stops: [0.015, 0.015],
                                    colors: [lightPurple, Colors.white],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                ),
                                child: CheckboxListTile(
                                  title: Text(
                                    "${state.tasks![index].title}",
                                    style: TextStyle(fontSize: FONT_LABEL.sp),
                                  ),
                                  onChanged: (value) {
                                    // * update checkbox state
                                    taskBloc.add(UpdateTaskStatus(
                                      taskID: state.tasks![index].id!,
                                      statusIndex: value == true
                                          ? TaskStatusEnum.COMPLETE.index
                                          : TaskStatusEnum.PENDING.index,
                                    ));
                                  },
                                  value: state.tasks![index].statusIndex ==
                                          TaskStatusEnum.COMPLETE.index
                                      ? true
                                      : false,
                                  secondary: const Icon(Icons.notifications),
                                ),
                              );
                            }),
                      );
                    }
                    return const SliverFillRemaining();
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

  MySliverAppBar({required this.expandedHeight});

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
              decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  purple,
                  lightPurple,
                ]),
          )),
          title: const Text("Task Reminder",
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
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
                child: const Padding(
                  padding: EdgeInsets.all(PADDING_MEDIUM),
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
