import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterBlocObserver extends BlocObserver {
  @override
  void onTransition(Cubit cubit, Transition transition) {
    print("CubitObserver $transition");
    super.onTransition(cubit, transition);
  }
}
