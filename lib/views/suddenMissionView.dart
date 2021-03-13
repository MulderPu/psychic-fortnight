import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genshin_calculator/cubit/suddenmission_cubit.dart';

class SuddenMissionView extends StatefulWidget {
  SuddenMissionView({Key key}) : super(key: key);

  @override
  _SuddenMissionViewState createState() => _SuddenMissionViewState();
}

class _SuddenMissionViewState extends State<SuddenMissionView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuddenmissionCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sudden Mission"),
        ),
        body: BlocBuilder<SuddenmissionCubit, int>(
          builder: (context, state) {
            print(state);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: 'da',
                      backgroundColor: Colors.purple,
                      onPressed: () =>
                          context.read<SuddenmissionCubit>().decrement(),
                      child: Icon(Icons.remove),
                    ),
                    context.read<SuddenmissionCubit>().changeUi(),
                    state != 10
                        ? FloatingActionButton(
                            heroTag: 'fas',
                            backgroundColor: Colors.purple,
                            onPressed: () =>
                                context.read<SuddenmissionCubit>().increment(),
                            child: Icon(Icons.add),
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            focusElevation: 0,
                            hoverElevation: 0,
                            backgroundColor: Colors.grey,
                            onPressed: () => null,
                            child: Icon(Icons.add),
                          ),
                  ],
                ),
                context.read<SuddenmissionCubit>().updateMessage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
