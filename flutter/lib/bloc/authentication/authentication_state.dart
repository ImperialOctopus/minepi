import 'package:equatable/equatable.dart';

/// State of auth bloc.
abstract class AuthenticationState extends Equatable {
  /// State of auth bloc.
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

/// Auth state when user is loaded.
class AuthenticationAuthenticated extends AuthenticationState {
  /// Identifier.
  final String identifier;

  /// Auth state when user is loaded.
  const AuthenticationAuthenticated({required this.identifier});
}

/// Auth state before user authenticates.
class AuthenticationUnauthenticated extends AuthenticationState {
  /// Auth state before user authenticates.
  const AuthenticationUnauthenticated();
}

/// Auth state is loading.
class AuthenticationLoading extends AuthenticationState {
  /// Auth state is loading.
  const AuthenticationLoading();
}

/// Auth failed.
class AuthenticationError extends AuthenticationState {
  /// Error message.
  final String message;

  /// Auth failed.
  const AuthenticationError({required this.message});
}
