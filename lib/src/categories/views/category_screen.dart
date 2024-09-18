import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/services/storage.dart';
import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/back_button.dart';
import '../../../common/widgets/login_bottom_sheet.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../products/viewModel/products_riverpod.dart';
import '../../products/views/widgets/staggered_tile_widget.dart';
import '../../wishList/viewModel/wishlist_notifier.dart';
import '../viewModel/category_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({required this.catId, super.key});

  final int catId;

  Future<void> _refreshProducts(WidgetRef ref) async {
    await ref.refresh(fetchProductsByCategoryProvider(catId).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? accessToken = Storage().getString('accessToken');
    final bool isLoggedIn = accessToken != null;

    final wishListState = ref.watch(wishListNotifierProvider);

    return ref.watch(fetchProductsByCategoryProvider(catId)).when(
          data: (data) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: ReusableText(
                text: ref.watch(catNotifierProvider).title,
                style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
              ),
              leading: const AppBackButton(),
            ),
            body: RefreshIndicator(
              onRefresh: () => _refreshProducts(ref),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      data.length,
                      (index) {
                        final product = data[index];
                        final isWished = wishListState.when(
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
                                loginBottomSheet(context); // Function to show login prompt
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
                ),
              ),
            ),
          ),
          error: (err, stack) => Center(child: Text("Error: $err")),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
