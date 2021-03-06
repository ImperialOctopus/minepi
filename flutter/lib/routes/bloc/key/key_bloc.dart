import 'dart:async';

import 'package:bloc/bloc.dart';
import 'key_event.dart';
import 'key_state.dart';

class KeyBloc extends Bloc<KeyEvent, KeyState> {
  KeyBloc() : super(const KeyUnloaded());

  @override
  Stream<KeyState> mapEventToState(
    KeyEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
