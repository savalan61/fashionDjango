import 'package:fashion_django/common/utils/app_routes.dart';
import 'package:fashion_django/common/utils/environment.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/src/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: Environment.fileName);
    print('API_BASE_URL: ${Environment.appBaseUrl}');
  } catch (e) {
    print('Failed to load environment variables: $e');
  }

  // Initialize GetStorage
  try {
    await GetStorage.init();
  } catch (e) {
    print('Failed to initialize GetStorage: $e');
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WishListRepository(http.Client()).fetchAllWishList();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
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
