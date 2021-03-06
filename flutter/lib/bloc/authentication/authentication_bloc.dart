import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/data_repository/data_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

/// Bloc for user authentication.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final DataRepository _dataRepository;

  /// Bloc for user authentication.
  AuthenticationBloc({required DataRepository dataRepository})
      : _dataRepository = dataRepository,
        super(const AuthenticationUnauthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationAppStarted) {
    } else if (event is AuthenticationRequested) {
      yield* _mapRequestToState(event);
    }
  }

  Stream<AuthenticationState> _mapRequestToState(
      AuthenticationRequested event) async* {
    yield const AuthenticationLoading();
    try {
      await _dataRepository.checkUser(event.identifier);
      yield AuthenticationAuthenticated(identifier: event.identifier);
    } catch (e) {
      yield AuthenticationError(message: e.toString());
    }
  }
}
