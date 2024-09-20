// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.price,
    this.onTap,
  });
  final String price;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 68.h,
        color: Colors.white.withOpacity(.6),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 10, right: 12.w, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
                width: 120.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: "Total Price", style: appStyle(14, Kolors.kGray, FontWeight.normal)),
                    ReusableText(text: "\$ $price", style: appStyle(14, Kolors.kDark, FontWeight.w600)),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Kolors.kPrimary)),
                  onPressed: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesome.shopping_bag,
                        color: Kolors.kWhite,
                        size: 16.w,
                      ),
                      SizedBox(width: 8.w),
                      ReusableText(text: "Add To Cart", style: appStyle(14, Kolors.kWhite, FontWeight.bold))
                    ],
                  ))
            ],
          ),
        ));
  }
}
