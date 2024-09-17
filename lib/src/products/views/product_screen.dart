import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_django/common/services/storage.dart';
import 'package:fashion_django/common/utils/kstrings.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/back_button.dart';
import 'package:fashion_django/common/widgets/error_modal.dart';
import 'package:fashion_django/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/products/models/product_model.dart';
import 'package:fashion_django/src/products/viewModel/selected_product_notifier.dart';
import 'package:fashion_django/src/products/views/widgets/product_bottom_bar.dart';
import 'package:fashion_django/src/products/views/widgets/product_colors_sel.dart';
import 'package:fashion_django/src/products/views/widgets/product_sizes_selection.dart';
import 'package:fashion_django/src/products/views/widgets/similar_products.dart';
import 'package:fashion_django/src/wishList/viewModel/wishlist_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // از riverpod استفاده کنید
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:readmore/readmore.dart';

import '../../../common/utils/kcolors.dart';
import '../../../const/constants.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final productNotifier = provider.Provider.of<ProductNotifier>(context);
    ProductModel currentProduct = ref.watch(selectedProdNotifier).product!;
    var wishes = ref.watch(wishListNotifierProvider);
    String? accessToken = Storage().getString("accessToken");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ----------------- SliverAppbar(Image and Favorite Button) -----------------------
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 320.h,
            collapsedHeight: 65.h,
            pinned: true,
            leading: const AppBackButton(),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: GestureDetector(
                  onTap: () {
                    // Handle favorite button tap
                  },
                  child: CircleAvatar(
                    backgroundColor: Kolors.kSecondaryLight,
                    child: Icon(true ? AntDesign.heart : AntDesign.hearto, color: Kolors.kRed, size: 18),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: SizedBox(
                height: 415.h,
                child: ImageSlideshow(
                  autoPlayInterval: 15000,
                  isLoop: currentProduct.imageUrls.length > 1 ? true : false,
                  indicatorColor: Kolors.kPrimary,
                  height: 415.h,
                  children: List.generate(
                    currentProduct.imageUrls.length,
                    (index) => CachedNetworkImage(
                      placeholder: placeholder,
                      errorWidget: errorWidget,
                      imageUrl: currentProduct.imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ----------------- Sliver Box() -----------------------
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h),
          ),

          // Category and Rating
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: currentProduct.clothesType.toUpperCase(),
                    style: appStyle(13, Kolors.kGray, FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(AntDesign.star, color: Kolors.kGold, size: 14),
                      SizedBox(width: 5.w),
                      ReusableText(
                        text: currentProduct.rating.toStringAsFixed(1),
                        style: appStyle(13, Kolors.kGray, FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReusableText(
                text: currentProduct.title,
                style: appStyle(16, Kolors.kDark, FontWeight.w600),
              ),
            ),
          ),

          // Description
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: ReadMoreText(
                // productNotifier.product!.description,
                currentProduct.description,
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimCollapsedText: 'View more',
                trimExpandedText: 'View less',
                textAlign: TextAlign.justify,
                style: appStyle(13, Kolors.kGray, FontWeight.normal),
                moreStyle: appStyle(11, Kolors.kPrimary, FontWeight.normal),
                lessStyle: appStyle(11, Kolors.kPrimary, FontWeight.normal),
              ),
            ),
          ),

          // space
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Divider(thickness: .5),
            ),
          ),

          // Select Sizes
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReusableText(
                text: "Select sizes",
                style: appStyle(16, Kolors.kDark, FontWeight.w600),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(child: ProductSizesWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          // Select Color
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReusableText(
                text: 'Select Color',
                style: appStyle(16, Kolors.kDark, FontWeight.w600),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(child: ProductColorsWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ReusableText(
                text: 'Similar Products',
                style: appStyle(16, Kolors.kDark, FontWeight.w600),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          // Similar Products
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SimilarProducts(catId: currentProduct.category),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        ],
      ),
      bottomNavigationBar: ProductBottomBar(
        price: currentProduct.price.toStringAsFixed(2),
        onTap: () {
          if (accessToken == null) {
            loginBottomSheet(context);
          } else if ("currentProduct.color == '' || productNotifier.size == ''".isNotEmpty) {
            showErrorPopup(context, AppText.kCartErrorText, 'Error Adding to Cart', true);
          } else {
            // TODO: Handle checkout
            if (kDebugMode) {
              print('Go for checkout');
            }
          }
        },
      ),
    );
  }
}
