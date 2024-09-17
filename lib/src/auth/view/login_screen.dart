// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/custom_button.dart';
import 'package:fashion_django/common/widgets/email_textfield.dart';
import 'package:fashion_django/common/widgets/password_field.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/auth/models/signIn_model.dart';
import 'package:fashion_django/src/entrypoint/viewModel/tabs_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../const/app_routes.dart';
import '../controllers/riverpod/auth_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  ///set Tab to home
  void setTab(WidgetRef ref) => ref.read(bottomTabNotifier.notifier).setTab(0);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _usernameCtrl = TextEditingController();
    final TextEditingController _passwordCtrl = TextEditingController();
    final FocusNode _focusNode = FocusNode();
    final _formKey = GlobalKey<FormState>();

    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    if (authState.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.home);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () => context.go(AppRoutes.home),
        ),
        centerTitle: true,
        backgroundColor: Kolors.kOffWhite,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 160.h),
              ReusableText(
                text: 'Best Fashion',
                textAlign: TextAlign.center,
                style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              ReusableText(
                text: "Hi! Welcome back. You've been missed.",
                style: appStyle(13, Kolors.kGray, FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              Column(
                children: [
                  /// User Name
                  EmailTextField(
                    radius: 25,
                    focusNode: _focusNode,
                    hintText: 'User Name',
                    controller: _usernameCtrl,
                    prefixIcon: Icon(CupertinoIcons.profile_circled, size: 20, color: Kolors.kGray),
                    keyboardType: TextInputType.name,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode),
                  ),
                  SizedBox(height: 20.h),

                  /// Password
                  PasswordField(controller: _passwordCtrl, focusNode: _focusNode, radius: 25),
                  SizedBox(height: 20.h),

                  /// Login Button
                  authState.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Kolors.kPrimary,
                            valueColor: AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                          ),
                        )
                      : CustomeBtn(
                          text: 'L O G I N',
                          btnWidth: ScreenUtil().screenWidth,
                          btnHeight: 40,
                          radius: 20,
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final SigInModel userModel = SigInModel(
                                username: _usernameCtrl.text.trim(),
                                password: _passwordCtrl.text.trim(),
                              );

                              final String userString = signInModelToJson(userModel);
                              authNotifier.signInFunction(userString, context);
                              setTab(ref);
                            }
                          },
                        )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: GestureDetector(
          onTap: () {
            context.push(AppRoutes.register);
          },
          child: ReusableText(
            text: "Don't have an account? Register now. ",
            style: appStyle(12, Colors.blue, FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
