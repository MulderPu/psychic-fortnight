import 'package:flutter/material.dart';
import 'package:genshin_calculator/utils/constant.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key key}) : super(key: key);

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
              padding: EdgeInsets.only(top: expandedHeight / 2),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => ListTile(
                    title: Text("Index: $index"),
                  ),
                ),
              ),
            )
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
                  Color(0xff00d2ff),
                  Color(0xff3a7bd5),
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
                child: FlutterLogo(),
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
