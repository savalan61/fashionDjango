// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/src/home/controllers/home_tabs_notifier.dart';
import 'package:fashion_django/src/home/views/widgets/home_appbar.dart';
import 'package:fashion_django/src/home/views/widgets/home_categories_list.dart';
import 'package:fashion_django/src/home/views/widgets/home_header.dart';
import 'package:fashion_django/src/home/views/widgets/home_slider.dart';
import 'package:fashion_django/src/home/views/widgets/home_tabs.dart';
import 'package:fashion_django/src/products/views/widgets/explore_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabCtrl;
  int _currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: homeTabs.length, vsync: this);
    _tabCtrl.addListener(_handleSelection);
  }

  void _handleSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);
    if (_tabCtrl.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabCtrl.index;
      });
      controller.setIndex(homeTabs[_currentTabIndex]);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.removeListener(_handleSelection);
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(110.h), child: HomeAppBar()),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(height: 20.h),

          /// --------------------------------- Home Slider -------------------
          HomeSlider(),
          SizedBox(height: 15.h),

          /// --------------------------------- Home Categories Header -------------------
          HomeHeader(),
          SizedBox(height: 10.h),

          /// --------------------------------- Home Categories Slider -------------------
          HomeCategoriesList(),
          SizedBox(height: 15.h),

          /// --------------------------------- Home Tabs -------------------
          HomeTabs(tabController: _tabCtrl),
          SizedBox(height: 15.h),

          /// --------------------------------- Explore Products -------------------
          ExploreProducts(),
        ],
      ),
    );
  }
}

List<String> homeTabs = ["All", "Popular", "Unisex", "Men", "Women", "kids"];
