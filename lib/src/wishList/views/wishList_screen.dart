import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/wishList/viewModel/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../auth/controllers/riverpod/auth_notifier.dart';
import '../../auth/view/login_screen.dart';
import '../../products/views/widgets/staggered_tile_widget.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authNotifierProvider).isLoggedIn;
    final wishListState = ref.watch(wishListNotifierProvider);

    if (!isLoggedIn) {
      return const LoginScreen();
    }

    return wishListState.when(
      data: (wishListProducts) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ReusableText(
            text: 'Wishlist',
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  wishListProducts.length,
                  (index) {
                    final wishListProduct = wishListProducts[index];
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2.4,
                      child: StaggeredTileWidget(
                        i: index,
                        product: wishListProduct.product,
                        isWished: wishListProduct.isWished,
                        onTap: () {
                          ref
                              .read(wishListNotifierProvider.notifier)
                              .toggleWishList(wishListProduct.product.id.toString());
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => const Center(child: Text('Something went wrong')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
