import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(text: AppText.kCategories, style: appStyle(13, Kolors.kDark, FontWeight.w600)),
        GestureDetector(
          onTap: () {
            router.push("/categories");
          },
          child: ReusableText(text: AppText.kViewAll, style: appStyle(13, Kolors.kGray, FontWeight.normal)),
        )
      ],
    );
  }
}
