abstract class KeyState {
  const KeyState();
}

class KeyInitial extends KeyState {
  const KeyInitial();
}

class KeyLoading extends KeyState {
  const KeyLoading();
}

class KeyInvalid extends KeyState {
  const KeyInvalid();
}

class KeyValid extends KeyState {
  final String loginKey;

  const KeyValid(this.loginKey);
}
