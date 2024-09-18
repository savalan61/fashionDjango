import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/kcolors.dart';
import '../../../../common/widgets/app_style.dart';
import '../../../../common/widgets/reusable_text.dart';
import '../../../wishList/viewModel/wishlist_notifier.dart';
import '../../models/product_model.dart';
import '../../viewModel/selected_product_notifier.dart';

class StaggeredTileWidget extends ConsumerWidget {
  const StaggeredTileWidget({
    required this.i,
    required this.product,
    required this.isWished,
    required this.onTap,
    super.key,
  });

  final int i;
  final ProductModel product;
  final bool isWished;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedProdNotifier.notifier).setProduct(product);
        context.push('/product/${product.id}');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrls.isNotEmpty ? product.imageUrls[0] : '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150.h,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    right: 10.h,
                    top: 10.h,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final productId = product.id.toString();
                          await ref.read(wishListNotifierProvider.notifier).toggleWishList(productId);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error toggling wish list')),
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Icon(
                          ref.watch(wishListNotifierProvider).when(
                                data: (wishList) => wishList.any((item) => item.product.id == product.id)
                                    ? AntDesign.heart
                                    : AntDesign.hearto,
                                loading: () => isWished ? AntDesign.heart : AntDesign.hearto,
                                error: (_, __) => isWished ? AntDesign.heart : AntDesign.hearto,
                              ),
                          color: Kolors.kRed,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(13, Kolors.kDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                        SizedBox(width: 5.w),
                        ReusableText(
                          text: product.rating.toStringAsFixed(1),
                          style: appStyle(18, Kolors.kGray, FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: ReusableText(
                  text: '\$ ${product.price.toStringAsFixed(2)}',
                  style: appStyle(17, Kolors.kDark, FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
