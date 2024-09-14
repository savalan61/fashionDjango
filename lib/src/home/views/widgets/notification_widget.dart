// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/login_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GetStorage().read("accessToke") != null ? context.push("/notifications") : loginBottomSheet(context);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: CircleAvatar(
            backgroundColor: Kolors.kGrayLight.withOpacity(.3),
            child: Badge(
              label: Text("5"),
              child: Icon(
                Ionicons.notifications,
                color: Kolors.kPrimary,
              ),
            )),
      ),
    );
  }
}
