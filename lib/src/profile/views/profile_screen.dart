// ignore_for_file: prefer_const_constructors

import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/help_bottom_sheet.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/app_routes.dart';
import 'package:fashion_django/src/auth/view/login_screen.dart';
import 'package:fashion_django/src/entrypoint/viewModel/tabs_notifier.dart';
import 'package:fashion_django/src/profile/views/widgets/profile_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../common/services/storage.dart';
import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/custom_button.dart';
import '../../auth/controllers/riverpod/auth_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void logOut(WidgetRef ref, BuildContext context) {
    ref.read(authNotifierProvider.notifier).logout(context);
    ref.read(bottomTabNotifier.notifier).setTab(0);
    context.go("/home");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final currentUser = authState.currentUser;
    String? accessToken = Storage().getString("accessToken");

    if (!authState.isLoggedIn || accessToken == null || accessToken.isEmpty) {
      return const LoginScreen();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 100.h),
              CircleAvatar(
                radius: 35,
                backgroundColor: Kolors.kOffWhite,
                backgroundImage: NetworkImage(AppText.kProfilePic),
              ),
              SizedBox(height: 15.h),
              ReusableText(
                text: currentUser.email,
                style: appStyle(11, Kolors.kGray, FontWeight.normal),
              ),
              SizedBox(height: 5.h),
              Container(
                decoration: BoxDecoration(
                  color: Kolors.kOffWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: ReusableText(
                  text: currentUser.username,
                  style: appStyle(14, Kolors.kDark, FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            color: Kolors.kOffWhite,
            child: Column(
              children: [
                ProfileTileWidget(
                  title: "My Orders",
                  leadingIconData: Octicons.checklist,
                  onTap: () => context.push(AppRoutes.checkout),
                ),
                ProfileTileWidget(
                  title: "Shipping Address",
                  leadingIconData: MaterialIcons.location_pin,
                  onTap: () => context.push(AppRoutes.addAddress),
                ),
                ProfileTileWidget(
                  title: "Privacy Policy",
                  leadingIconData: MaterialIcons.policy,
                  onTap: () => context.push(AppRoutes.policy),
                ),
                ProfileTileWidget(
                  title: "Help Center",
                  leadingIconData: AntDesign.customerservice,
                  onTap: () => showHelpCenterBottomSheet(context),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: CustomeBtn(
              text: "Logout".toUpperCase(),
              btnColor: Kolors.kRed,
              btnHeight: 35.h,
              onTap: () {
                logOut(ref, context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
