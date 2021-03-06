abstract class KeyState {
  const KeyState();
}

class KeyUnloaded extends KeyState {
  const KeyUnloaded();
}

class KeyLoaded extends KeyState {
  final String loginKey;

  const KeyLoaded(this.loginKey);
}
