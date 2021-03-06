import 'package:equatable/equatable.dart';

/// State of remember bloc.
abstract class RememberState extends Equatable {
  /// State of remember bloc.
  const RememberState();

  @override
  List<Object?> get props => [];
}

/// No saved name found.
class RememberNone extends RememberState {
  /// No saved name found.
  const RememberNone();
}

/// Saved name found.
class RememberFound extends RememberState {
  /// Identifier.
  final String identifier;

  /// Saved name found.
  const RememberFound({required this.identifier});
}
