// ignore_for_file: unused_element, prefer_const_constructors

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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => AppEntryPoint(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnBoardingScreen(),
    ),
    // GoRoute(
    //   path: '/review',
    //   builder: (context, state) => const ReviewsPage(),
    // ),
    GoRoute(
      path: '/policy',
      builder: (context, state) => const PolicyScreen(),
    ),
    // GoRoute(
    //   path: '/verification',
    //   builder: (context, state) => const VerificationPage(),
    // ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    // GoRoute(
    //   path: '/help',
    //   builder: (context, state) => const HelpCenterPage(),
    // ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/category/:id',
      builder: (context, state) {
        final catId = state.pathParameters['id'];
        // return CategoryScreen(catId: int.parse(catId!));
        return CategoryScreen(catId: int.parse(catId!));
      },
    ),
    //
    // GoRoute(
    //   path: '/address',
    //   builder: (context, state) => const AddAddress(),
    // ),
    //
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const ShippingAddressScreen(),
    ),
    //
    GoRoute(
      path: '/notifications',
      builder: (context, state) => NotificationScreen(),
    ),
    //
    //  GoRoute(
    //   path: '/tracking',
    //   builder: (context, state) => const TrackOrderPage(),
    // ),
    //
    // GoRoute(
    //   path: '/checkout',
    //   builder: (context, state) => const CheckoutPage(),
    // ),
    //
    //   GoRoute(
    //   path: '/successful',
    //   builder: (context, state) => const SuccessfulPayment(),
    // ),
    //
    //   GoRoute(
    //   path: '/failed',
    //   builder: (context, state) => const FailedPayment(),
    // ),
    //
    GoRoute(
      path: '/product/:id',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
  ],
);

GoRouter get router => _router;
