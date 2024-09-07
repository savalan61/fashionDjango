import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  _navigator() async {
    Future.delayed(const Duration(seconds: 3), () {
      if (Storage().getBool('firstOpen') == null) {
        GoRouter.of(context).go("/onboarding");
      } else {
        GoRouter.of(context).go("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(R.ASSETS_IMAGES_SPLASHSCREEN_PNG))),
      ),
    );
  }
}
