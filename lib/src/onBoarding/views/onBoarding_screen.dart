import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/src/onBoarding/controllers/onBoarding_notifier.dart';
import 'package:fashion_django/src/onBoarding/views/widgets/onBoard_Screen_one.dart';
import 'package:fashion_django/src/onBoarding/views/widgets/onBoarding_screen_tow.dart';
import 'package:fashion_django/src/onBoarding/views/widgets/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _pageController = PageController(
          initialPage: ref.watch(onBoardNotifier),
        );
      });
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final selectedPage = ref.watch(onBoardNotifier);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) => ref.read(onBoardNotifier.notifier).setPage(value),
            children: pages,
          ),
          Positioned(
            bottom: 50.h,
            child: Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedPage > 0)
                    GestureDetector(
                      onTap: () {
                        if (selectedPage > 0) {
                          ref.read(onBoardNotifier.notifier).setPage(selectedPage - 1);
                          _pageController?.animateToPage(
                            selectedPage - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: const Icon(AntDesign.leftcircleo, color: Kolors.kPrimary, size: 30),
                    )
                  else
                    const SizedBox(width: 30),
                  SizedBox(
                    width: ScreenUtil().screenWidth * .7,
                    height: 50.h,
                    child: PageViewDotIndicator(
                      currentItem: selectedPage,
                      count: pages.length,
                      unselectedColor: Colors.black26,
                      selectedColor: Kolors.kPrimary,
                    ),
                  ),
                  if (selectedPage < pages.length - 1)
                    GestureDetector(
                      onTap: () {
                        if (selectedPage < pages.length - 1) {
                          ref.read(onBoardNotifier.notifier).setPage(selectedPage + 1);

                          _pageController?.animateToPage(
                            selectedPage + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: const Icon(AntDesign.rightcircleo, color: Kolors.kPrimary, size: 30),
                    )
                  else
                    const SizedBox(width: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> pages = [const OnboardScreenOne(), const OnboardScreenTwo(), const WelcomeScreen()];
