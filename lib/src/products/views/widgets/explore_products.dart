import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/src/products/viewModel/products_riverpod.dart';
import 'package:fashion_django/src/products/views/widgets/staggered_tile_widget.dart';
import 'package:fashion_django/src/wishList/viewModel/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../common/widgets/login_bottom_sheet.dart';
import '../../../../const/resource.dart';

class ExploreProducts extends ConsumerWidget {
  const ExploreProducts(this.clotheType, {super.key});

  final String clotheType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? accessToken = Storage().getString('accessToken');
    final bool isLoggedIn = accessToken != null;

    final provider = clotheType == 'All' ? fetchAllProdsProvider : fetchProductsByClothesTypeProvider(clotheType);

    ref.watch(wishListNotifierProvider);

    return ref.watch(provider).when(
          data: (data) {
            if (data.isEmpty) {
              return Image.asset(R.ASSETS_IMAGES_EMPTY_PNG);
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  data.length,
                  (index) {
                    final product = data[index];
                    final bool isWished = ref.watch(wishListNotifierProvider).when(
                          data: (wishList) => wishList.any(
                            (item) => item.product.id == product.id,
                          ),
                          loading: () => false,
                          error: (_, __) => false,
                        );

                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2.4,
                      child: StaggeredTileWidget(
                        i: index,
                        product: product,
                        isWished: isWished,
                        onTap: () {
                          if (!isLoggedIn) {
                            loginBottomSheet(context);
                          } else {
                            // Handle wishlist toggle
                            ref.read(wishListNotifierProvider.notifier).toggleWishList(product.id.toString());
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text('Something went wrong!'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
