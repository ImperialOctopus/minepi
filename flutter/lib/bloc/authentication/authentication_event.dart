import 'package:equatable/equatable.dart';

/// Events for auth bloc.
abstract class AuthenticationEvent extends Equatable {
  /// Events for auth bloc.
  const AuthenticationEvent();
}

/// App started.
class AuthenticationAppStarted extends AuthenticationEvent {
  /// App started.
  const AuthenticationAppStarted();

  @override
  List<Object> get props => [];
}

/// User changed.
class AuthenticationRequested extends AuthenticationEvent {
  /// New user object, or null if logged out.
  final String identifier;

  /// User changed.
  const AuthenticationRequested({required this.identifier});

  @override
  List<Object> get props => [identifier];
}
