import 'dart:convert';

import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/common/widgets/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/services/api_services/auth_service.dart';
import '../../models/access_token_model.dart';
import '../../models/profile_model.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthServiceApi _authApi = AuthServiceApi();

  AuthNotifier() : super(AuthState());

  /// Sign Up
  Future<void> signUpFunction(String data, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await _authApi.signUp(data);

      if (res.statusCode == 201) {
        if (mounted) {
          state = state.copyWith(isLoading: false);
          showSuccessPopup(context, "Account created successfully", "Welcome to the app!", null);
          context.go("/login");
        }
      } else {
        final errorData = jsonDecode(res.body);
        final errorMsg = errorData["password"]?.first ?? "An error occurred during signup.";
        if (mounted) {
          showErrorPopup(context, errorMsg, null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "An error occurred during signup. Please try again.", null, null);
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
      final res = await _authApi.signIn(data);

      if (res.statusCode == 200) {
        final accessToken = accessTokenModelFromJson(res.body).authToken;
        await getUser(accessToken, context);
      } else {
        final errorMsg = jsonDecode(res.body)['detail'] ?? "Incorrect username or password.";
        if (mounted) {
          showErrorPopup(context, errorMsg, null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "An error occurred during login. Please try again.", null, null);
      }
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> getUser(String accessToken, BuildContext context) async {
    try {
      final res = await _authApi.getUser(accessToken);

      if (res.statusCode == 200) {
        if (mounted) {
          Storage().setString("accessToken", accessToken);
          final profile = profileModelFromJson(res.body);
          state = state.copyWith(isLoggedIn: true, currentUser: profile);
        }
      } else {
        if (mounted) {
          showErrorPopup(context, "Failed to fetch user details.", null, null);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "Failed to fetch user details.", null, null);
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await Storage().removeKey("accessToken");

      if (mounted) {
        state = state.copyWith(isLoggedIn: false, currentUser: ProfileModel.empty());
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context, "An error occurred during logout. Please try again.", null, null);
      }
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
