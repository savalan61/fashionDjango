// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/custom_button.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * .16,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
                autoPlayInterval: 5000,
                isLoop: true,
                indicatorColor: Kolors.kPrimary,
                onPageChanged: (value) {},
                children: List.generate(
                  images.length,
                  (index) => CachedNetworkImage(
                    placeholder: placeholder,
                    errorWidget: errorWidget,
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Positioned(
              left: 20.w,
              child: SizedBox(
                height: ScreenUtil().screenHeight * .16,
                width: ScreenUtil().screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: AppText.kCollection, style: appStyle(20, Kolors.kDark, FontWeight.w600)),
                    SizedBox(height: 5.h),
                    Text(
                      "Discount 50% off \nthe first transaction",
                      style: appStyle(14, Kolors.kDark.withOpacity(.6), FontWeight.normal),
                    ),
                    SizedBox(height: 10),
                    CustomeBtn(text: 'Shop now', btnWidth: 150.w)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

List<String> images = [
  "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/Images%2Fd.png?alt=media&token=abc534c1-df02-40f9-ab0d-157507c10c9b",
  "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/Images%2Fe.png?alt=media&token=8e04941c-09ef-4ab4-acee-c8458e5e10b7",
  "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/Images%2Ff.png?alt=media&token=927fbffe-0a30-4e2f-b859-a86cb37757a9",
  "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/Images%2Fg.png?alt=media&token=6f59820d-e1e9-444d-9d79-3934eb0e0b55",
  "https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/Images%2Fl.png?alt=media&token=7c34d072-f63a-4b0d-9d3e-0320b65ad041",
];
