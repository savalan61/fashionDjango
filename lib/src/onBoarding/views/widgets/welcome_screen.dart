import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/custom_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Kolors.kWhite,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          SizedBox(height: 50.h),
          Image.asset(R.ASSETS_IMAGES_GETSTARTED_PNG),
          SizedBox(height: 30.h),
          Text(AppText.kWelcomeHeader,
              textAlign: TextAlign.center, style: appStyle(24, Kolors.kPrimary, FontWeight.bold)),
          SizedBox(height: 20.h),
          SizedBox(
            width: ScreenUtil().screenWidth,
            child: Text(AppText.kWelcomeMessage,
                textAlign: TextAlign.center, style: appStyle(11, Kolors.kGray, FontWeight.normal)),
          ),
          SizedBox(height: 20.h),
          GradientBtn(
              text: AppText.kGetStarted,
              onTap: () {
                ///TODO
                Storage().setBool("firstOpen", true);
                context.go("/home");
              },
              btnHeight: 35,
              radius: 20,
              btnWidth: ScreenUtil().screenWidth - 100),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableText(text: "Already have an account?", style: appStyle(12, Kolors.kDark, FontWeight.normal)),
              TextButton(
                  onPressed: () {
                    //Navigate to login page
                    context.push("/login");
                  },
                  child: const Text("Sign In", style: TextStyle(fontSize: 12, color: Colors.blue)))
            ],
          )
        ],
      ),
    );
  }
}
