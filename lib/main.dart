import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/environment.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_django/src/home/controllers/home_tabs_notifier.dart';
import 'package:fashion_django/src/onBoarding/controllers/onBoarding_notifier.dart';
import 'package:fashion_django/src/products/controllers/product_notifier.dart';
import 'package:fashion_django/src/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  print('API_BASE_URL: ${Environment.appBaseUrl}');
  await GetStorage.init();

  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(create: (_) => OnBoardingNotifier()),
          provider.ChangeNotifierProvider(create: (_) => BottomTabNotifier()),
          provider.ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
          provider.ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. ------------------
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}
