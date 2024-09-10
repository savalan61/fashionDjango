import 'package:auto_size_text/auto_size_text.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/app_style.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(text: "Privacy Policy", style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            SizedBox(height: 12.h),
            ReusableText(text: AppText.kCancelation, style: appStyle(16, Kolors.kPrimary, FontWeight.w500)),
            SizedBox(height: 12.h),
            Text(
              AppText.kAppCancelationPolicy,
              textAlign: TextAlign.justify,
              style: appStyle(13, Kolors.kGray, FontWeight.normal),
            ),
            SizedBox(height: 12.h),
            ReusableText(text: AppText.kTerms, style: appStyle(16, Kolors.kPrimary, FontWeight.w500)),
            SizedBox(height: 12.h),
            AutoSizeText(AppText.kAppTerms, style: appStyle(13, Kolors.kGray, FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
