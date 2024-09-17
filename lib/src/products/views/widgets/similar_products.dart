import 'package:fashion_django/src/products/viewModel/products_riverpod.dart';
import 'package:fashion_django/src/products/views/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../common/services/storage.dart';
import '../../../../common/widgets/login_bottom_sheet.dart';
import '../../../wishList/viewModel/wishlist_notifier.dart';

class SimilarProducts extends ConsumerWidget {
  const SimilarProducts({required this.catId, super.key});

  final int catId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? accessToken = Storage().getString("accessToken");
    final bool isLoggedIn = accessToken != null;

    return ref.watch(fetchSimilarProducts(catId)).when(
          data: (data) {
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
                    final isWished = ref.watch(wishListNotifierProvider).when(
                          data: (wishList) => wishList.any((item) => item.product.id == product.id),
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
            child: Text("Something went wrong"),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
