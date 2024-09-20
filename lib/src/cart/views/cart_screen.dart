import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/const/resource.dart';
import 'package:fashion_django/src/cart/ViewModel/cart_provider.dart';
import 'package:fashion_django/src/cart/views/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  void removeCart(WidgetRef ref, int cartId) async {
    await ref.read(cartNotifierProvider.notifier).removeFromCart(cartId);

    await ref.read(cartNotifierProvider.notifier).fetchCartCount();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartItems = cartState.carts;

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Image.asset(R.ASSETS_IMAGES_EMPTY_PNG),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartTile(
                    cart: cartItems[index],
                    onDelete: () {
                      removeCart(ref, cartItems[index].id);
                    },
                  );
                },
              ),
            ),
    );
  }
}
