import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'suddenmission_state.dart';

class SuddenmissionCubit extends Cubit<int> {
  SuddenmissionCubit() : super(0);

  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  void increment() {
    if (state < 10) {
      emit(state + 1);
    }
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  Widget changeUi() {
    String updateState = state.toString();
    return Text(
      updateState,
      style: TextStyle(
        color: state == 0 ? Colors.red : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget updateMessage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        state == 10
            ? "Sudden Mission has been done! Please come back tomorrow."
            : "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: state == 10 ? Colors.green : Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }
}
