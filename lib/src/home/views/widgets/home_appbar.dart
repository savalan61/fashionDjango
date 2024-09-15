// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/home/views/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: ReusableText(text: "Location", style: appStyle(12, Kolors.kGray, FontWeight.normal)),
          ),
          SizedBox(height: 5.h),
          Row(
            children: <Widget>[
              const Icon(Ionicons.location, size: 16, color: Kolors.kPrimary),
              const SizedBox(width: 3.0),
              SizedBox(
                width: ScreenUtil().screenWidth * .7,
                child:
                    ReusableText(text: "Please select a location", style: appStyle(14, Kolors.kDark, FontWeight.w500)),
              ),
            ],
          )
        ],
      ),
      actions: const [NotificationWidget()],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(55.h),
          child: GestureDetector(
            onTap: () {
              context.push("/search");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40.h,
                    width: ScreenUtil().screenWidth - 80.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: .5, color: Kolors.kGrayLight),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Ionicons.search, size: 20, color: Kolors.kPrimaryLight),
                          SizedBox(width: 10.w),
                          ReusableText(text: "Search Product", style: appStyle(14, Kolors.kGray, FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      FontAwesome.sliders,
                      color: Kolors.kWhite,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
