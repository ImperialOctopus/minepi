abstract class KeyEvent {
  const KeyEvent();
}

class KeyAppStarted extends KeyEvent {}

class KeySubmitted extends KeyEvent {
  final String loginKey;

  const KeySubmitted({required this.loginKey});
}

class KeyClear extends KeyEvent {
  const KeyClear();
}
