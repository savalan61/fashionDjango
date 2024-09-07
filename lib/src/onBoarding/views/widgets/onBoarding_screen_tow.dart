import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/const/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardScreenTwo extends StatelessWidget {
  const OnboardScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().scaleWidth,
      child: Stack(
        children: [
          Image.asset(R.ASSETS_IMAGES_WISHLIST_PNG, fit: BoxFit.cover),
          Positioned(
              bottom: 200,
              left: 30,
              right: 30,
              child: Text(AppText.kOnboardWishList,
                  style: appStyle(11, Kolors.kGray, FontWeight.normal), textAlign: TextAlign.center))
        ],
      ),
    );
  }
}
