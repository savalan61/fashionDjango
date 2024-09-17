import 'package:fashion_django/const/app_routes.dart';
import 'package:fashion_django/src/auth/view/login_screen.dart';
import 'package:fashion_django/src/auth/view/registration_screen.dart';
import 'package:fashion_django/src/categories/views/categories_screen.dart';
import 'package:fashion_django/src/categories/views/category_screen.dart';
import 'package:fashion_django/src/notification/views/notification_screen.dart';
import 'package:fashion_django/src/onBoarding/views/onBoarding_screen.dart';
import 'package:fashion_django/src/products/views/product_screen.dart';
import 'package:fashion_django/src/profile/views/orders_screen.dart';
import 'package:fashion_django/src/profile/views/policy_screen.dart';
import 'package:fashion_django/src/profile/views/shipping_address_screen.dart';
import 'package:fashion_django/src/search/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/entrypoint/view/entrypoint.dart';
import '../../src/splashscreen/splash_screen.dart';
import '../widgets/not_foundScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter get router => _router;

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.splash,
  errorPageBuilder: (context, state) => MaterialPage(child: const NotFoundScreen(), key: state.pageKey),
  routes: [
    GoRoute(path: AppRoutes.notFound, builder: (context, state) => const NotFoundScreen()),
    GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppRoutes.home, builder: (context, state) => AppEntryPoint()),
    GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnBoardingScreen()),
    GoRoute(path: AppRoutes.policy, builder: (context, state) => const PolicyScreen()),
    GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchScreen()),
    GoRoute(path: AppRoutes.orders, builder: (context, state) => const OrdersScreen()),
    GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: AppRoutes.register, builder: (context, state) => RegistrationScreen()),
    GoRoute(path: AppRoutes.categories, builder: (context, state) => const CategoriesScreen()),
    GoRoute(path: AppRoutes.addresses, builder: (context, state) => const ShippingAddressScreen()),
    GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationScreen()),
    GoRoute(
      path: AppRoutes.product,
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
    GoRoute(
      path: AppRoutes.category,
      builder: (context, state) {
        final catId = state.pathParameters['id'];
        return CategoryScreen(catId: int.parse(catId!));
      },
    ),

    // Commented routes for future use
    // GoRoute(path: AppRoutes.review, builder: (context, state) => const ReviewsPage()),
    // GoRoute(path: AppRoutes.verification, builder: (context, state) => const VerificationPage()),
    // GoRoute(path: AppRoutes.helpCenter, builder: (context, state) => const HelpCenterPage()),
    // GoRoute(path: AppRoutes.addAddress, builder: (context, state) => const AddAddress()),
    // GoRoute(path: AppRoutes.tracking, builder: (context, state) => const TrackOrderPage()),
    // GoRoute(path: AppRoutes.checkout, builder: (context, state) => const CheckoutPage()),
    // GoRoute(path: AppRoutes.successfulPayment, builder: (context, state) => const SuccessfulPayment()),
    // GoRoute(path: AppRoutes.failedPayment, builder: (context, state) => const FailedPayment()),
  ],
);
