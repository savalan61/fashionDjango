// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/src/home/viewModel/home_tab_notifier.dart';
import 'package:fashion_django/src/home/views/widgets/home_appbar.dart';
import 'package:fashion_django/src/home/views/widgets/home_categories_list.dart';
import 'package:fashion_django/src/home/views/widgets/home_header.dart';
import 'package:fashion_django/src/home/views/widgets/home_slider.dart';
import 'package:fashion_django/src/home/views/widgets/home_tabs.dart';
import 'package:fashion_django/src/products/views/widgets/explore_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialIndex = homeTabs.indexOf(ref.read(homeTabNotifier).index);
    _tabController = TabController(length: homeTabs.length, vsync: this, initialIndex: initialIndex);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      final newIndex = homeTabs[_tabController.index];
      ref.read(homeTabNotifier.notifier).setIndex(newIndex);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeTabState = ref.watch(homeTabNotifier);

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
          HomeTabs(tabController: _tabController),
          SizedBox(height: 15.h),

          /// --------------------------------- Explore Products -------------------
          ExploreProducts(homeTabState.index),
        ],
      ),
    );
  }
}

List<String> homeTabs = ["All", "Popular", "Unisex", "Men", "Women", "Kids"];
