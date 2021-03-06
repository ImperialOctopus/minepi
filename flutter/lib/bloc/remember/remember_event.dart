import 'package:equatable/equatable.dart';

/// Events for remember bloc.
abstract class RememberEvent extends Equatable {
  /// Events for auth bloc.
  const RememberEvent();
}

/// App started.
class RememberAppStarted extends RememberEvent {
  /// App started.
  const RememberAppStarted();

  @override
  List<Object> get props => [];
}

/// User changed.
class RememberLoginSucceeded extends RememberEvent {
  /// Identifier to save.
  final String identifier;

  /// User changed.
  const RememberLoginSucceeded({required this.identifier});

  @override
  List<Object> get props => [identifier];
}
