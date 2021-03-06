import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'remember_event.dart';
import 'remember_state.dart';

/// Bloc for user authentication.
class RememberBloc extends Bloc<RememberEvent, RememberState> {
  /// Bloc for user authentication.
  RememberBloc() : super(const RememberNone());

  static const _key = 'remembered_identifier';

  @override
  Stream<RememberState> mapEventToState(
    RememberEvent event,
  ) async* {
    if (event is RememberAppStarted) {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(_key)) {
        yield RememberFound(identifier: prefs.getString(_key) ?? '');
      }
    } else if (event is RememberLoginSucceeded) {
      yield RememberFound(identifier: event.identifier);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, event.identifier);
    }
  }
}
