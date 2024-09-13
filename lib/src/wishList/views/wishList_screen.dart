// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/views/widgets/explore_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/riverpod/auth_notifier.dart';
import '../../auth/view/login_screen.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String? accessToken = Storage().getString("accessToken");
    // if (accessToken == null) {
    //   return LoginScreen();
    // }
    final bool autState = ref.watch(authNotifierProvider).isLoggedIn;

    if (!autState) {
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(text: AppText.kWishlist, style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ExploreProducts(),
      ),
    );
  }
}
