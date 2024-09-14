import '../../models/profile_model.dart';

// String? accessToken = Storage().getString("accessToken");
// final bool isLoggedIn = accessToken!.isEmpty || accessToken == null;

class AuthState {
  AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    ProfileModel? currentUser,
  }) : currentUser = currentUser ?? ProfileModel.empty();
  final bool isLoading;
  final bool isLoggedIn;
  final ProfileModel currentUser;

  AuthState copyWith({bool? isLoading, bool? isLoggedIn, ProfileModel? currentUser}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
