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

class StaggeredTileWidget extends ConsumerWidget {
  const StaggeredTileWidget({
    required this.i,
    required this.product,
    super.key,
  });

  final int i;
  final ProductModel product;

  // Toggle wishlist state
  void toggleWishList(bool isAdded, WidgetRef ref) {
    isAdded
        ? ref.read(wishListProvider.notifier).removeFromList(product)
        : ref.read(wishListProvider.notifier).addToList(product);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAdded = ref.watch(wishListProvider.notifier).isInList(product);

    return GestureDetector(
      onTap: () {
        // Navigate to product details page
        context.push('/product/${product.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Card(
          elevation: 6, // Increased shadow for better effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image and Wishlist Icon
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  child: Container(
                    height: 180.h,
                    child: Stack(
                      children: [
                        // Product image
                        CachedNetworkImage(
                          imageUrl: product.imageUrls.isNotEmpty ? product.imageUrls[0] : '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),

                        // Wishlist button
                        Positioned(
                          right: 10.w,
                          top: 10.w,
                          child: GestureDetector(
                            onTap: () {
                              toggleWishList(isAdded, ref);
                            },
                            child: CircleAvatar(
                              backgroundColor: Kolors.kSecondaryLight,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: Icon(
                                  isAdded ? AntDesign.heart : AntDesign.hearto,
                                  key: ValueKey(isAdded),
                                  color: Kolors.kRed,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Product Title and Rating
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(14.sp, Kolors.kDark, FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                        SizedBox(width: 4.w),
                        ReusableText(
                          text: product.rating.toStringAsFixed(1),
                          style: appStyle(14.sp, Kolors.kGray, FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Product Price
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ReusableText(
                  text: '\$${product.price.toStringAsFixed(2)}',
                  style: appStyle(17.sp, Kolors.kDark, FontWeight.w600),
                ),
              ),

              SizedBox(height: 6.h), // Adding slight space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
