import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordState {
  bool passVisible;

  PasswordState({this.passVisible = false});

  PasswordState copyWith({bool? passVisible}) {
    return PasswordState(passVisible: passVisible ?? this.passVisible);
  }
}

class PasswordNotifier2 extends StateNotifier<PasswordState> {
  PasswordNotifier2() : super(PasswordState());

  void changePassState() {
    // Toggle the passVisible state
    state = state.copyWith(passVisible: !state.passVisible);
  }
}

final passNotifierProvider = StateNotifierProvider<PasswordNotifier2, PasswordState>((ref) {
  return PasswordNotifier2();
});
