// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/src/cart/views/cart_screen.dart';
import 'package:fashion_django/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_django/src/home/views/home_screen.dart';
import 'package:fashion_django/src/profile/views/profile_screen.dart';
import 'package:fashion_django/src/wishList/views/wishList_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});
  final List<Widget> pageList = [HomeScreen(), WishlistScreen(), CartScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<BottomTabNotifier, int>(
        selector: (context, notifier) => notifier.selectedTab,
        builder: (context, selectedTab, child) {
          return Stack(
            children: List.generate(pageList.length, (index) {
              return Offstage(
                offstage: index != selectedTab,
                child: pageList[index],
              );
            }),
          );
        },
      ),
      bottomNavigationBar: Selector<BottomTabNotifier, int>(
        selector: (context, notifier) => notifier.selectedTab,
        builder: (context, selectedTab, child) {
          return BottomNavigationBar(
            selectedFontSize: 12,
            elevation: 0,
            backgroundColor: Kolors.kWhite,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: selectedTab,
            selectedItemColor: Kolors.kPrimary,
            unselectedItemColor: Colors.grey,
            onTap: (value) {
              context.read<BottomTabNotifier>().setTabIndex(value);
            },
            unselectedIconTheme: IconThemeData(color: Colors.black38),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(AntDesign.home, color: selectedTab == 0 ? Kolors.kPrimary : null, size: 24),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.heart_outline, color: selectedTab == 1 ? Kolors.kPrimary : null, size: 24),
                  label: "Wish List"),
              BottomNavigationBarItem(
                  icon: Badge(
                    label: Text("3"),
                    child: Icon(MaterialCommunityIcons.shopping_outline,
                        color: selectedTab == 2 ? Kolors.kPrimary : null, size: 24),
                  ),
                  label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(EvilIcons.user, color: selectedTab == 3 ? Kolors.kPrimary : null, size: 32),
                  label: "Profile"),
            ],
          );
        },
      ),
    );
  }
}
