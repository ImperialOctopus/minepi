import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../model/output_state.dart';
import '../../../repository/data_repository/data_repository.dart';

/// Cubit of monitor states.
class MonitorCubit extends Cubit<OutputState?> {
  /// Subscription to stream.
  late final StreamSubscription _streamSubscription;

  /// Cubit of monitor states.
  MonitorCubit(
      {required DataRepository dataRepository, required String identifier})
      : super(null) {
    dataRepository.getStateStream(identifier).then((stream) {
      _streamSubscription = stream.listen((event) {
        emit(event);
      });
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }
}
