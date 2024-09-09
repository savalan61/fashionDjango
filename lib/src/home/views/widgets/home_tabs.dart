import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/tab_widget.dart';
import 'package:fashion_django/src/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required TabController tabController}) : _tabController = tabController;
  final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(color: Kolors.kPrimary, borderRadius: BorderRadius.circular(25)),
          labelPadding: EdgeInsets.zero,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          labelStyle: appStyle(11, Kolors.kOffWhite, FontWeight.w600),
          unselectedLabelStyle: appStyle(11, Kolors.kGray, FontWeight.normal),
          isScrollable: true,
          tabs: List.generate(
            homeTabs.length,
            (index) {
              return Tab(
                child: TabWidget(text: homeTabs[index]),
              );
            },
          )),
    );
  }
}
