import 'dart:async';

import 'package:bloc/bloc.dart';

import 'monitor_state.dart';
import 'monitor_event.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  final String loginKey;

  MonitorBloc({required this.loginKey}) : super(MonitorInitial());

  @override
  Stream<MonitorState> mapEventToState(
    MonitorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
