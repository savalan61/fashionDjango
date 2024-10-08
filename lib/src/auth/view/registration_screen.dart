import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/custom_button.dart';
import 'package:fashion_django/common/widgets/email_textfield.dart';
import 'package:fashion_django/common/widgets/password_field.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/auth/models/signUp_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../controllers/riverpod/auth_notifier.dart';

class RegistrationScreen extends ConsumerWidget {
  RegistrationScreen({super.key});

// Define controllers and focus nodes
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: Kolors.kOffWhite,
      appBar: AppBar(
        leading: AppBackButton(),
        centerTitle: true,
        backgroundColor: Kolors.kOffWhite,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 160.h),
          ReusableText(
            text: "Best Fashion",
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                /// User Name
                EmailTextField(
                  radius: 25,
                  hintText: "User Name",
                  controller: _usernameCtrl,
                  prefixIcon: Icon(CupertinoIcons.profile_circled, size: 20, color: Kolors.kGray),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode),
                ),
                SizedBox(height: 20.h),

                /// Email
                EmailTextField(
                  radius: 25,
                  focusNode: _focusNode,
                  hintText: "Email",
                  controller: _emailCtrl,
                  prefixIcon: Icon(CupertinoIcons.mail, size: 20, color: Kolors.kGray),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_focusNode),
                ),
                SizedBox(height: 20.h),

                /// Password
                PasswordField(controller: _passwordCtrl, focusNode: _focusNode, radius: 25),
                SizedBox(height: 20.h),

                /// Signup Button
                authState.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor: AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomeBtn(
                        text: "S I G N U P",
                        btnWidth: ScreenUtil().screenWidth,
                        btnHeight: 40,
                        radius: 20,
                        onTap: () {
                          // Create SignUpModel
                          SignUpModel userModel = SignUpModel(
                            username: _usernameCtrl.text.trim(),
                            password: _passwordCtrl.text.trim(),
                            email: _emailCtrl.text.trim(),
                          );
                          String userString = signUpModelToJson(userModel);
                          ref.read(authNotifierProvider.notifier).signUpFunction(userString, context);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: GestureDetector(
          onTap: () {
            context.push("/login");
          },
          child: ReusableText(
            text: "Have an account already? Login now.",
            style: appStyle(12, Colors.blue, FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
