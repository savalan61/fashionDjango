import 'dart:convert';
import 'package:fashion_django/src/auth/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/common/utils/environment.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/error_modal.dart';
import 'package:fashion_django/src/auth/models/access_token_model.dart';
import 'package:go_router/go_router.dart';
import "package:http/http.dart" as http;

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final ProfileModel currentUser;

  AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    ProfileModel? currentUser,
  }) : currentUser = currentUser ?? ProfileModel.empty();

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    ProfileModel? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  /// Sign Up
  Future<void> signUpFunction(String data, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final url = Uri.parse("${Environment.appBaseUrl}/auth/users/");
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);

      if (res.statusCode == 201) {
        if (mounted) {
          state = state.copyWith(isLoading: false);
          showSuccessPopup(context, "Created successfully", "Welcome", null);
          context.go("/login");
        }
      } else {
        final errorData = jsonDecode(res.body);
        final errorMsg = errorData["password"]?.first ?? "Error in Signup";
        if (mounted) {
          showErrorPopup(context, errorMsg, null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "Error in Signup", null, null);
      }
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  /// Sign In
  Future<void> signInFunction(String data, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final url = Uri.parse("${Environment.appBaseUrl}/auth/token/login");
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: data);

      if (res.statusCode == 200) {
        final accessToken = accessTokenModelFromJson(res.body).authToken;
        await getUser(accessToken, context);
      } else {
        final errorMsg = jsonDecode(res.body)['detail'] ?? AppText.kErrorLogin;
        if (mounted) {
          showErrorPopup(context, errorMsg, null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, AppText.kErrorLogin, null, null);
      }
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> getUser(String accessToken, BuildContext context) async {
    try {
      final url = Uri.parse("${Environment.appBaseUrl}/auth/users/me/");
      final res = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': 'Token $accessToken'},
      );

      if (res.statusCode == 200) {
        if (mounted) {
          Storage().setString("accessToken", accessToken);
          final profile = profileModelFromJson(res.body); // Parse the profile data
          state = state.copyWith(isLoggedIn: true, currentUser: profile); // Update the state with the currentUser
        }
      } else {
        if (mounted) {
          showErrorPopup(context, "AppText.kErrorFetchUser", null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "AppText.kErrorFetchUser", null, null);
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await Storage().removeKey("accessToken");

      if (mounted) {
        state = state.copyWith(isLoggedIn: false, currentUser: ProfileModel.empty()); // Reset the currentUser on logout
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "AppText.kErrorLogout", null, null);
      }
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
