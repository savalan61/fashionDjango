import '../../models/profile_model.dart';

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final ProfileModel currentUser;

  AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    ProfileModel? currentUser,
  }) : currentUser = currentUser ?? ProfileModel.empty();

  AuthState copyWith({bool? isLoading, bool? isLoggedIn, ProfileModel? currentUser}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
