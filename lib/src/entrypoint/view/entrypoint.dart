import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/src/cart/views/cart_screen.dart';
import 'package:fashion_django/src/entrypoint/viewModel/tabs_notifier.dart';
import 'package:fashion_django/src/home/views/home_screen.dart';
import 'package:fashion_django/src/profile/views/profile_screen.dart';
import 'package:fashion_django/src/wishList/views/wishList_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AppEntryPoint extends ConsumerWidget {
  AppEntryPoint({super.key});

  final List<Widget> pageList = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the bottomTabNotifierProvider to get the selected tab index
    final selectedTab = ref.watch(bottomTabNotifier);

    return Scaffold(
      body: Stack(
        children: List.generate(pageList.length, (index) {
          return IndexedStack(
            index: selectedTab,
            children: pageList,
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        elevation: 0,
        backgroundColor: Kolors.kWhite,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedTab,
        selectedItemColor: Kolors.kPrimary,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          // Update the selected tab index
          ref.read(bottomTabNotifier.notifier).setTab(value);
        },
        unselectedIconTheme: const IconThemeData(color: Colors.black38),
        items: [
          BottomNavigationBarItem(
            icon: Icon(AntDesign.home, color: selectedTab == 0 ? Kolors.kPrimary : null, size: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.heart_outline, color: selectedTab == 1 ? Kolors.kPrimary : null, size: 24),
            label: "Wish List",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: const Text("3"),
              child: Icon(MaterialCommunityIcons.shopping_outline,
                  color: selectedTab == 2 ? Kolors.kPrimary : null, size: 24),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(EvilIcons.user, color: selectedTab == 3 ? Kolors.kPrimary : null, size: 32),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
