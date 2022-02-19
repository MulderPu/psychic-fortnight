import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("BlocObserver $transition");
    super.onTransition(bloc, transition);
  }
}
