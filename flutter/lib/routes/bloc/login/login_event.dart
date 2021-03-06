part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginAppStarted extends LoginEvent {}

class LoginKeySubmitted extends LoginEvent {
  final String username;

  const LoginKeySubmitted({required this.username});
}
